import requests
import json
import pandas as pd

# URL local (asumiendo que uvicorn está corriendo)
URL = "http://127.0.0.1:8000"

def test_prediction(sector, fecha, extra_datos=None):
    payload = {
        "sector": sector,
        "datos": {"fecha": fecha}
    }
    if extra_datos:
        payload["datos"].update(extra_datos)
        
    try:
        # 1. Probar Predicción
        res_pred = requests.post(f"{URL}/predict", json=payload)
        print(f"\n--- Probando Sector: {sector.upper()} | Fecha: {fecha} ---")
        if res_pred.status_code == 200:
            pred = res_pred.json()
            valor = pred['empleos_predichos']
            input_used = pred['metadata_input']
            print(f"Predicción: {valor} empleos")
            # print(f"Lag-1 detectado: {input_used.get('Agro_lag1') or input_used.get('Mfg_lag1') or input_used.get('Serv_lag1')}")
            
            # 2. Probar Interpretación (Gemini)
            if valor > 0:
                print("Solicitando interpretación...")
                # Tomamos solo unas pocas variables para no saturar el prompt
                vars_clave = {k: v for k, v in input_used.items() if 'lag1' in k or 'USD' in k}
                focus_val = extra_datos.get("focus", "general") if extra_datos else "general"
                res_int = requests.post(f"{URL}/interpret", json={
                    "sector": sector,
                    "valor": valor,
                    "variables_clave": vars_clave,
                    "focus": focus_val
                })
                if res_int.status_code == 200:
                    print(f"Perfil de Usuario / Enfoque: {focus_val.upper()}")
                    print(f"SIAH: {res_int.json()['interpretacion']}")
                else:
                    print(f"Error Interpretación: {res_int.text}")
        else:
            print(f"Error {res_pred.status_code}: {res_pred.text}")
    except Exception as e:
        print(f"Error de conexión: {e}. ¿Está corriendo el servidor?")

if __name__ == "__main__":
    print("Iniciando Pruebas de Sistema SIAH...")
    
    # Prueba 1: Fecha Histórica (Enero 2024) - Debe usar datos reales de 2023
    test_prediction("agro", "2024-01-01", extra_datos={"focus": "inversion"})
    
    # Prueba 2: Fecha Futura (Mayo 2025) - Debe usar el último dato de Abril 2025
    #test_prediction("manufactura", "2025-05-01")
    
    # Prueba 3: Servicios con interpretación
    #test_prediction("servicios", "2025-02-01")
