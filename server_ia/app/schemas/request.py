from pydantic import BaseModel
from typing import Dict, Any, Optional

class PredictionInput(BaseModel):
    sector: str
    fecha: Optional[str] = None
    datos_adicionales: Optional[Dict[str, Any]] = None

class InterpretationInput(BaseModel):
    sector: str
    valor: float
    variables_clave: Dict[str, Any]
    nivel: str = "general"
