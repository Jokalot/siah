from app.utils.data_loader import DataLoader
import os

class CorrelationService:
    def __init__(self):
        # Intentamos localizar el CSV en la carpeta data
        csv_path = os.path.join(os.getcwd(), 'data', 'TRAINING_FINAL.csv')
        if not os.path.exists(csv_path):
            csv_path = "TRAINING_FINAL.csv"
        self.data_loader = DataLoader(csv_path)

    def get_correlations(self, sector: str, factor_key: str = None, lag: int = 0):
        """
        Obtiene las correlaciones de un sector con un lag opcional en meses.
        """
        data = self.data_loader.generate_correlation(sector, factor_key, lag)

        if data is None:
            raise ValueError(f"Sector '{sector}' no soportado o correlación no encontrada.")

        return data