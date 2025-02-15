Abstract

This thesis aims to develop and test a hybrid genetic algorithm obtained by integrating the classic approach of genetic algorithms with machine learning techniques such as clustering and reinforcement learning. The main objective is to improve performance in the search for optimal solutions in complex optimization problems, addressing some of the limitations of traditional genetic algorithms, such as premature convergence and insufficient exploration of the solution space.

Initially, a review of evolutionary algorithms (in particular genetic algorithms) and their possible criticalities is provided, along with an explanation of clustering algorithms and reinforcement learning. Subsequently, the structure and implementation of the hybrid algorithm are illustrated. In this approach, clustering is used to group solutions into homogeneous subdomains, while reinforcement learning is employed to dynamically guide the process of genetic selection and variation (choice of genetic operators) based on feedback (rewards/penalties) derived from previous applications (reinforcement learning).

The experimentation compares the performance of the hybrid algorithm with that of a traditional genetic algorithm, MOEA/D, through a series of selected optimization benchmark problems: DTLZ2 and ZDT3 for real-valued solutions, ZDT5 and MONRP for binary solutions, and MOTSP and mQAP for permutative solutions.

The results indicate that the developed algorithm tends to achieve better performance in terms of execution time and hypervolume. Specifically, it is generally faster for problems with binary and real-valued solutions, while performance is slightly worse or similar for problems with permutative solutions. In terms of hypervolume, which represents the quality of the solutions, it is better or similar compared to MOEA/D. The main critical issues concern the survival phase of solutions, where the current strategy may limit population diversity. Improving this phase could lead to a significant performance gain, making the hybrid algorithm clearly superior to a traditional approach.

This study represents a first step toward the development of more efficient hybrid genetic algorithms, paving the way for future optimizations.

ITALIANO

Questa tesi si propone di sviluppare e sperimentare un algoritmo genetico ibrido, ottenuto mediante l'integrazione dell'approccio classico degli algoritmi genetici con tecniche di machine learning quali il *clustering* e l'apprendimento per rinforzo. L'obiettivo principale è quello di migliorare le prestazioni nella ricerca di soluzioni ottimali in problemi di ottimizzazione complessi, cercando di alcune delle limitazioni degli algoritmi genetici tradizionali, come la convergenza prematura e l'esplorazione insufficiente dello spazio delle soluzioni.

Inizialmente si propone una revisione degli algoritmi evolutivi, ed in particolare genetici, e delle possibilità criticità, insieme ad una spiegazione degli algoritmi di clustering e di reinforcement learning.
Successivamente, viene illustrata la struttra e l'implementazione dell'algoritmo ibrido, in cui il *clustering* viene impiegato per raggruppare le soluzioni in sottodomini omogenei, mentre l'apprendimento per rinforzo viene utilizzato per guidare dinamicamente il processo di selezione e variazione genetica (scelta degli operatori genetici) in funzione di feedback (ricompense/penalità) derivanti dalle precedenti applicazioni (apprendimento per rinforzo).

La sperimentazione condotta ha messo a confronto le performance dell'algoritmo ibrido con quelle di un algoritmo genetico tradizionale, MOEA/D, attraverso una serie di problemi di *benchmark* di ottimizzazione selezionati, DTLZ2 e ZDT3 per soluzioni reali, ZDT5 e MONRP per soluzioni binarie e MOTSP e mQAP per soluzioni permutative. 

I risultati indicano che tendenzialmente l'algoritmo sviluppato ha performance migliori in termini di tempo di esecuzione e *hypervolume*. In particolare è generalmente più veloce per problemi con soluzioni binarie e reali mentre leggermente peggiori o simili con problemi con soluzioni permutative. In termini di *hypervolume*, che rappresentà la bontà delle soluzioni, è migliore o simile rispetto al MOEA/D.
Le principali criticità riscontrate riguardano la fase di sopravvivenza delle soluzioni, in cui la strategia attuale potrebbe limitare la diversità della popolazione. Un perfezionamento di questa fase potrebbe portare a un significativo miglioramento delle prestazioni, rendendo l’algoritmo ibrido nettamente superiore rispetto a un approccio tradizionale.

Lo studio rappresenta un primo passo verso lo sviluppo di algoritmi genetici ibridi più efficienti, aprendo la strada a future ottimizzazioni.
