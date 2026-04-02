import joblib
import os
import sys

models_dir = r"c:\Users\eliza\OneDrive\Escritorio\SIAH - API\models"
models = ["agro", "construccion", "manufactura", "servicios"]

print("--- AUDITORIA DE MODELOS SIAH ---")

for m in models:
    path = os.path.join(models_dir, f"siah_{m}.pkl")
    if not os.path.exists(path):
        print(f"Sector {m}: [ERROR] No se encuentra siah_{m}.pkl")
        continue

    try:
        obj = joblib.load(path)
        print(f"\nSector: {m}")
        print(f"Tipo: {type(obj)}")
        
        features = None
        # Caso 1: Diccionario empaquetado (Mega-Push)
        if isinstance(obj, dict) and "features" in obj:
            features = obj["features"]
            print("Estructura: Diccionario Empaquetado")
        # Caso 2: Objeto CatBoost directo
        elif hasattr(obj, "feature_names_"):
            features = obj.feature_names_
            print("Estructura: CatBoost Directo")
        # Caso 3: TransformedTargetRegressor
        elif hasattr(obj, "regressor_") and hasattr(obj.regressor_, "feature_names_"):
            features = obj.regressor_.feature_names_
            print("Estructura: TransformedTargetRegressor")
            
        if features:
            print(f"Features ({len(features)}): {features}")
        else:
            print("Features: [!] No se encontró lista de variables")
            
    except Exception as e:
        print(f"Sector {m}: [!] Error al leer: {e}")
