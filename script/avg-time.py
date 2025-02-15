import scipy.io
import numpy as np
import os

# Cartella dove sono salvati i file .mat
folder_path = "./path" 

# Lista dei file .mat nella cartella
mat_files = [f for f in os.listdir(folder_path) if f.endswith(".mat")]

# Lista per salvare i runtime estratti
runtime_values = []

for file_name in mat_files:
    file_path = os.path.join(folder_path, file_name)
    
    # Caricare il file .mat
    mat_data = scipy.io.loadmat(file_path)
    
    # Estrarre la variabile 'metric'
    if "metric" in mat_data:
        metric_data = mat_data["metric"]
        
        # Estrarre il campo 'runtime' (seguendo la struttura analizzata prima)
        T_data = getattr(metric_data, "T", None)
        if T_data is not None and 'runtime' in T_data.dtype.names:
            runtime = T_data['runtime'][0, 0][0, 0]  # Estrarre il valore numerico
            runtime_values.append(runtime)

# Calcolare il tempo medio
if runtime_values:
    average_runtime = np.mean(runtime_values)
    print(f"Tempo medio di esecuzione su {len(runtime_values)} file: {average_runtime:.6f} secondi")
else:
    print("Nessun valore di runtime trovato.")
