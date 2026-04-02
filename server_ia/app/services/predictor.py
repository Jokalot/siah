import joblib
import os
import pandas as pd
from app.utils.data_loader import DataLoader

class InferenceEngine:
    def __init__(self, models_path: str = "./models"):
        self.models_path = models_path
        self.models = self._load_all_models(models_path)
        self.data_loader = DataLoader(csv_path="./data/TRAINING_FINAL.csv")

    def _load_all_models(self, path: str):
        sectors = ["agro", "manufactura", "servicios", "construccion"]
        loaded = {}
        for s in sectors:
            p = os.path.join(path, f"siah_{s}.pkl")
            if os.path.exists(p):
                loaded[s] = joblib.load(p)
            else:
                print(f"Advertencia: No se encontró el modelo para {s} en {p}")
        return loaded

    def _get_expected_features(self, sector: str):
        model = self.models.get(sector)
        if not model:
            return []
            
        if hasattr(model, 'feature_names_'):
            return model.feature_names_
        elif hasattr(model, 'regressor_') and hasattr(model.regressor_, 'feature_names_'):
            return model.regressor_.feature_names_
        return []

    def get_metadata(self, sector: str):
        sector = sector.lower()
        metrica = {
            "agro": 0.9649,
            "construccion": 0.8573,
            "manufactura": 0.7732,
            "servicios": 0.7525
        }
        return {
            "sector": sector,
            "r2": metrica.get(sector, 0.0), # Reemplazamos r2_score por r2
            "features": self._get_expected_features(sector)
        }

    def predict(self, sector: str, fecha: str, datos_adicionales: dict = None):
        sector = sector.lower()
        if sector not in self.models:
            raise ValueError(f"Sector '{sector}' no soportado o modelo no cargado.")
        
        datos = {"fecha": fecha}
        if datos_adicionales:
            datos.update(datos_adicionales)
            
        expected_features = self._get_expected_features(sector)
        input_df = self.data_loader.prepare_features(sector, datos, expected_features)
        
        prediction = self.models[sector].predict(input_df)[0]
        final_result = max(0, float(prediction))
        
        return {
            "valor_predicho": round(final_result, 2),
            "metadata_input": input_df.to_dict(orient='records')[0],
            "metadata": self.get_metadata(sector)
        }
