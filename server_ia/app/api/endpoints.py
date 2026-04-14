from fastapi import APIRouter, HTTPException
from app.schemas.request import PredictionInput, InterpretationInput
from app.services.predictor import InferenceEngine
from app.services.interpreter import CognitiveEngine
from app.services.correlation import CorrelationService

router = APIRouter()

predictor = InferenceEngine(models_path="./models")
interpreter = CognitiveEngine(provider="openai")
correlation_service = CorrelationService()

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

@router.get("/correlations", tags=["Correlaciones"])
async def get_correlations(sector: str, factor_key: str = None, lag: int = 0):
    """
    Devuelve las correlaciones de los sectores con un lag opcional en meses.
    """
    return correlation_service.get_correlations(sector, factor_key, lag)

@router.get("/metadata/{sector}", tags=["Información"])
async def get_sector_info(sector: str):
    """
    Devuelve el R2 y variables de entrenamiento de un sector.
    """
    return predictor.get_metadata(sector)