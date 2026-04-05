from fastapi import APIRouter, HTTPException, Depends
from app.schemas.request import PredictionInput, InterpretationInput

from app.services.predictor import InferenceEngine
from app.services.interpreter import CognitiveEngine

router = APIRouter()


predictor = InferenceEngine(models_path="./models")
interpreter = CognitiveEngine(provider="openai")

@router.post("/predict", tags=["IA Predictiva"])
async def get_prediction(payload: PredictionInput):
    """
    Calcula la cifra de empleo y genera una interpretación narrativa.
    """
    try:
        resultado = predictor.predict(payload.sector, payload.fecha, payload.datos_adicionales)

        
        return resultado
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.post("/interpret", tags=["IA Cognitiva"])
async def get_interpretation(payload: InterpretationInput):
    """
    Genera una narrativa humana sobre el resultado de la predicción.
    """
    try:
        analisis = interpreter.explain(
            sector=payload.sector, 
            valor=payload.valor, 
            contexto=payload.variables_clave,
            nivel=payload.nivel
        )
        return {"interpretacion": analisis}
    except Exception as e:
        raise HTTPException(status_code=500, detail="Error en el análisis narrativo")

@router.get("/metadata/{sector}", tags=["Información"])
async def get_sector_info(sector: str):
    """
    Devuelve el R2 y variables de entrenamiento de un sector.
    """
    return predictor.get_metadata(sector)