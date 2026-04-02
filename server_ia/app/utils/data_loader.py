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
            # Fallback if being run from different places
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
            # Simplificación de diff (en main.py era lag1.get('Agro', 0) - lag1.get('Agro', 0) which was 0 placeholder)
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

        # Asegurar que todas las columnas esperadas existan
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
