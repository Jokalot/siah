from pydantic import BaseModel
from typing import Dict, Any, Optional, List

class PredictionInput(BaseModel):
    sector: str
    fecha: Optional[str] = None
    datos_adicionales: Optional[Dict[str, Any]] = None

class InterpretationInput(BaseModel):
    sector: str
    valor: float
    variables_clave: Dict[str, Any]
    nivel: str = "general"

class CorrelationRecord(BaseModel):
    correlation_score: float
    factor_name: str
    regression_line: Dict[str, Any]
    data: List[Dict[str, Any]]