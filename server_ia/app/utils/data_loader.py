import pandas as pd
import numpy as np
import os

class DataLoader:
    def __init__(self, csv_path: str):
        self.csv_path = csv_path
        self.df = self._load_data()

    def _load_data(self) -> pd.DataFrame:
        if os.path.exists(self.csv_path):
            df = pd.read_csv(self.csv_path)
            df['fecha'] = pd.to_datetime(df['fecha'])
            return df.sort_values('fecha')
        else:
            alt_path = os.path.join(os.getcwd(), 'TRAINING_FINAL.csv')
            if os.path.exists(alt_path):
                df = pd.read_csv(alt_path)
                df['fecha'] = pd.to_datetime(df['fecha'])
                return df.sort_values('fecha')
            raise FileNotFoundError(f"No se encontró el archivo CSV en: {self.csv_path}")

    def get_lags(self, fecha_str: str):
        dt = pd.to_datetime(fecha_str)
        
        # Lag 1 (Mes anterior en el dataset)
        hist_prev = self.df[self.df['fecha'] < dt]
        if hist_prev.empty:
            lag1_dict = {}
        else:
            lag1_dict = hist_prev.iloc[-1].to_dict()
            
        # Lag 12 (Mismo mes año anterior)
        t_12 = dt - pd.DateOffset(months=12)
        hist_12 = self.df[self.df['fecha'] <= t_12]
        if hist_12.empty:
            lag12_dict = {}
        else:
            lag12_dict = hist_12.iloc[-1].to_dict()
            
        return lag1_dict, lag12_dict

    def get_history_data(self, sector: str, fecha: str):
        mappings = {
            "agro": "Agro",
            "construccion": "Construccion",
            "manufactura": "Manufactura",
            "servicios": "Servicios"
        }

        columna_sector = mappings.get(sector.lower(), "Agro")

        if columna_sector not in self.df.columns:
            raise ValueError(f"Sector '{sector}' no soportado o columna '{columna_sector}' no encontrada.")

        yearly_df = self.df.groupby(self.df['fecha'].dt.year)[columna_sector].mean()
        year_5 = yearly_df.tail(5)

        history = []
        for year, value in year_5.items():
            history.append({
                "year": int(year),
                "value": int(round(value))
            })

        return history

    def prepare_features(self, sector: str, datos_crudos: dict, expected_features: list):
        fecha_str = datos_crudos.get('fecha', self.df['fecha'].max().strftime('%Y-%m-%d'))
        lag1, lag12 = self.get_lags(fecha_str)
        
        df = pd.DataFrame([datos_crudos])

        # Generar características cíclicas
        cycle_features = self.generate_cycle_features(fecha_str)
        df['month_sin'] = cycle_features['month_sin']
        df['month_cos'] = cycle_features['month_cos']
        
        # Lógica específica por sector
        if sector == "agro":
            df['Agro_lag1'] = lag1.get('Agro', 0)
            df['Agro_lag12'] = lag12.get('Agro', 0)
            df['Agro_diff1'] = 0 

            for macro in ['USD_MXN', 'SP500', 'INPC_SONORA_STATE', 'ENERGY_COST_MFG', 'TIIE_MA6']:
                if macro not in df.columns:
                    df[macro] = lag1.get(macro, 0)
                    
        elif sector == "manufactura":
            df['Mfg_lag1'] = lag1.get('Manufactura', 0)
            df['Mfg_lag12'] = lag12.get('Manufactura', 0)

            for macro in ['US_INDUSTRIAL', 'INDPRO', 'PRODUCCION_AUTO_MEX', 'USD_MXN', 'SP500']:
                if macro not in df.columns:
                    df[macro] = lag1.get(macro, 0)
                if f'{macro}_lag1' not in df.columns:
                    df[f'{macro}_lag1'] = lag1.get(macro, 0)

        elif sector == "servicios":
            df['Serv_lag1'] = lag1.get('Servicios', 0)

        elif sector == "construccion":
            df['Constr_lag1'] = lag1.get('Construccion', 0)
            df['Constr_lag12'] = lag12.get('Construccion', 0)

        for col in expected_features:
            if col not in df.columns:
                df[col] = lag1.get(col, 0) if col in lag1 else 0
        
        return df[expected_features]
    
    def generate_cycle_features(self, fecha_str: str):
        dt = pd.to_datetime(fecha_str)
        month = dt.month
        return {
            'month_sin': np.sin(2 * np.pi * month / 12),
            'month_cos': np.cos(2 * np.pi * month / 12)
        }


    def generate_correlation(self, sector: str, factor_key: str = None, lag: int = 0):
        sector_lower = sector.lower()
        temp_df = self.df.copy()
        temp_df['year'] = temp_df['fecha'].dt.year

        sector_map = {
            "agro": "Agro",
            "construccion": "Construccion",
            "manufactura": "Manufactura",
            "servicios": "Servicios"
        }

        target_col = sector_map.get(sector_lower)

        if not target_col:
            raise ValueError(f"Sector '{sector}' no soportado.")

        if factor_key is None:
            default_factors = {
                "agro": "Presa El Molinito",
                "construccion": "TASA_INTERES_TIIE",
                "manufactura": "US_INDUSTRIAL",
                "servicios": "REAL_PURCHASING_POWER"
            }
            factor_key = default_factors.get(sector_lower)

        if factor_key == "Presa El Molinito":
            presas = ['Presa El Molinito', 'Presa El Novillo', 'Presa La Angostura', 'Presa Mocúzari', 'Presa Oviáchic']
            temp_df['factor_valor'] = temp_df[presas].sum(axis=1)
            factor_name = "Nivel de Presas (Hm3)"
        else:
            if factor_key not in temp_df.columns:
                raise ValueError(f"Factor '{factor_key}' no encontrado.")
            temp_df['factor_valor'] = temp_df[factor_key]
            factor_name = factor_key

        if lag > 0:
            temp_df['factor_valor'] = temp_df['factor_valor'].shift(lag)
            temp_df['factor_valor'] = temp_df['factor_valor'].bfill()

        summary_df = temp_df.groupby('year').agg({
            target_col: 'mean',
            'factor_valor': 'mean'
        }).reset_index()

        summary_df = summary_df.rename(columns={target_col: 'empleo'})

        correlation_value = summary_df['empleo'].corr(summary_df['factor_valor'])
        
        summary_df['factor_nombre'] = factor_name

        x = summary_df['factor_valor'].values
        y = summary_df['empleo'].values

        m, b = np.polyfit(x, y, 1)

        x_range = np.linspace(x.min(), x.max(), 100)
        y_trend = m * x_range + b

        return {
            "correlation_score": correlation_value,
            "factor_name": factor_name,
            "regression_line": {
                "m": round(float(m), 4),
                "b": round(float(b), 4),
                "trend_line": [
                    {"x": float(x_range[0]),  "y": float(y_trend[0])},
                    {"x": float(x_range[-1]), "y": float(y_trend[-1])}
                ]
            },
            "data": summary_df.round(2).to_dict(orient='records')
        }