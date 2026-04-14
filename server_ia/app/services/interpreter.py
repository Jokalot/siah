import os
from openai import OpenAI
import google.generativeai as genai
from dotenv import load_dotenv

load_dotenv()

class CognitiveEngine:
    def __init__(self, api_key: str = None, provider: str = "openai"):
        self.api_key = api_key or os.getenv("OPENAI_API_KEY")
        self.provider = provider
        self.client = self._initialize_client(self.api_key, provider)
        self.system_instruction = """
        Eres el Analista Inteligente de SIAH (Sistema de Inteligencia de Acompañamiento Histórico).
        Tu propósito es explicar las predicciones de empleo en Sonora de forma clara y profesional.
        Tu lenguaje debe ser accesible para personas comunes (explicando el 'por qué' con peras y manzanas)
        pero con el rigor técnico suficiente para analistas (mencionando variables macro y lags).
        - Evita frases robóticas como 'Soy el motor cognitivo'.
        - Se directo: comienza explicando la tendencia y luego el motivo técnico.
        - Contexto Regional: Sonora depende de la agricultura (presas), el dólar (manufactura) y la estacionalidad laboral.
        - Restricción: Mantén un tono humano, empático y experto. No inventes cifras, usa los datos proporcionados.
        """

    def _initialize_client(self, api_key: str, provider: str = "openai"):
        if not api_key:
            return None
            
        if provider == "openai":
            return OpenAI(api_key=api_key)
        elif provider == "gemini":
            genai.configure(api_key=api_key)
            return genai.GenerativeModel('gemini-1.5-flash')
        else:
            raise ValueError("Proveedor no soportado")

    def _build_prompt(self, sector: str, value: float, context: dict, level: str):
        enfoques = {
            "general": """Tu audiencia son ciudadanos comunes. Explica la predicción de forma clara y profesional, sin tecnicismos excesivos pero con rigor técnico.""",
            "inversion": """Tu audiencia son inversionistas y empresarios. Mencionales si es momento de invertir o no en el sector.""",
            "empleo": """Tu audiencia son trabajadores y sindicatos. Mencionales si es momento de buscar empleo en el sector.""",
            "exportacion": """Tu audiencia son funcionarios públicos y analistas políticos. Mencionales si es momento de exportar o no en el sector."""
        }

        enfoque_desc = enfoques.get(level, enfoques["general"])

        prompt = f"""
        {self.system_instruction}

        SITUACIÓN DETECTADA:
        - Perfil de usuario: {level}
        - Enfoque: {enfoque_desc}
        - Sector: {sector.upper()}
        - Predicción de Empleo: {value}
        - Factores Técnicos (Drivers): {context}

        TAREA: Genera un análisis narrativo profesional pero humano. 
        Explica el 'por qué' de la cifra basado en los conductores técnicos.
        No te despidas, ve directo al grano.
        No vayas a mencionar las variables como "Agro_lag1", "Agro_lag12", etc, sino
        que debes inferir el comportamiento de esas variables y explicarlo de forma natural.
        """

        return prompt

    def explain(self, sector: str, valor: float, contexto: dict, nivel: str):
        if not self.client:
            return "Error: Cliente de IA no configurado o falta API Key."

        try:
            prompt = self._build_prompt(sector, valor, contexto, nivel)
            
            if self.provider == "openai":
                response = self.client.chat.completions.create(
                    model="gpt-4o-mini",
                    messages=[
                        {"role": "system", "content": self.system_instruction},
                        {"role": "user", "content": prompt}
                    ],
                    temperature=0.6,
                    max_tokens=1000
                )
                return response.choices[0].message.content
            elif self.provider == "gemini":
                response = self.client.generate_content(prompt)
                return response.text
                
        except Exception as e:
            return f"Error al generar interpretación: {str(e)}"
