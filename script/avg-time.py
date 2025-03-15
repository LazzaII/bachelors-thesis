import scipy.io
import numpy as np
import os

# location of .mat file
folder_path = "./path" 

mat_files = [f for f in os.listdir(folder_path) if f.endswith(".mat")]

# runtime array
runtime_values = []

for file_name in mat_files:
    file_path = os.path.join(folder_path, file_name)
    
    mat_data = scipy.io.loadmat(file_path)
    
    # extract 'metric' var
    if "metric" in mat_data:
        metric_data = mat_data["metric"]
        
        # extract 'runtime' var 
        T_data = getattr(metric_data, "T", None)
        if T_data is not None and 'runtime' in T_data.dtype.names:
            runtime = T_data['runtime'][0, 0][0, 0]  # value extraction
            runtime_values.append(runtime)

# avg time calculation
if runtime_values:
    average_runtime = np.mean(runtime_values)
    print(f"Tempo medio di esecuzione su {len(runtime_values)} file: {average_runtime:.6f} secondi")
else:
    print("Nessun valore di runtime trovato.")
