# ABSTRACT

## Eng version

This thesis aims to develop a hybrid genetic algorithm by integrating the classical approach of genetic algorithms with machine learning techniques such as clustering and reinforcement learning. The main objective is to enhance performance in searching for optimal solutions in complex optimization problems, addressing some limitations of traditional genetic algorithms.

Initially, a review of evolutionary algorithms, particularly genetic algorithms, is presented along with their potential challenges, as well as an explanation of clustering techniques and reinforcement learning algorithms.

Subsequently, the structure and implementation of the hybrid algorithm are described. In this approach, clustering is employed to group solutions into homogeneous subdomains, while reinforcement learning is used to adaptively guide the selection and evolution process based on feedback (rewards/penalties) derived from reinforcement learning.

The conducted experiments compared the performance of the hybrid algorithm with that of a genetic algorithm, MOEA/D, across a series of benchmark optimization problems: DTLZ2 and ZDT3 for real-valued solutions, ZDT5 and MONRP for binary solutions, and MOTSP and mQAP for permutative solutions.

The results indicate that, in general, the developed algorithm performs better in terms of execution time and hypervolume. Specifically, it is generally faster for problems with binary and real-valued solutions, while it performs slightly worse or similarly for problems with permutative solutions. Regarding hypervolume, which represents the quality of solutions, it is either superior or comparable to MOEA/D.

The main challenges encountered relate to the survival phase of solutions, where the adopted strategy may limit population diversity. Refining this aspect could lead to a significant performance improvement, making the hybrid algorithm distinctly superior to a traditional approach.

This study represents a first step toward the development of more efficient hybrid genetic algorithms, paving the way for future optimizations.

## It version

Questa tesi si propone di sviluppare e sperimentare un algoritmo genetico ibrido, ottenuto mediante l'integrazione dell'approccio classico degli algoritmi genetici con tecniche di machine learning quali il *clustering* e l'apprendimento per rinforzo. L'obiettivo principale è quello di migliorare le prestazioni nella ricerca di soluzioni ottimali in problemi di ottimizzazione complessi, cercando di alcune delle limitazioni degli algoritmi genetici tradizionali, come la convergenza prematura e l'esplorazione insufficiente dello spazio delle soluzioni.

Inizialmente si propone una revisione degli algoritmi evolutivi, ed in particolare genetici, e delle possibilità criticità, insieme ad una spiegazione degli algoritmi di clustering e di reinforcement learning.
Successivamente, viene illustrata la struttra e l'implementazione dell'algoritmo ibrido, in cui il *clustering* viene impiegato per raggruppare le soluzioni in sottodomini omogenei, mentre l'apprendimento per rinforzo viene utilizzato per guidare dinamicamente il processo di selezione e variazione genetica (scelta degli operatori genetici) in funzione di feedback (ricompense/penalità) derivanti dalle precedenti applicazioni (apprendimento per rinforzo).

La sperimentazione condotta ha messo a confronto le performance dell'algoritmo ibrido con quelle di un algoritmo genetico tradizionale, MOEA/D, attraverso una serie di problemi di *benchmark* di ottimizzazione selezionati, DTLZ2 e ZDT3 per soluzioni reali, ZDT5 e MONRP per soluzioni binarie e MOTSP e mQAP per soluzioni permutative. 

I risultati indicano che tendenzialmente l'algoritmo sviluppato ha performance migliori in termini di tempo di esecuzione e *hypervolume*. In particolare è generalmente più veloce per problemi con soluzioni binarie e reali mentre leggermente peggiori o simili con problemi con soluzioni permutative. In termini di *hypervolume*, che rappresentà la bontà delle soluzioni, è migliore o simile rispetto al MOEA/D.
Le principali criticità riscontrate riguardano la fase di sopravvivenza delle soluzioni, in cui la strategia attuale potrebbe limitare la diversità della popolazione. Un perfezionamento di questa fase potrebbe portare a un significativo miglioramento delle prestazioni, rendendo l’algoritmo ibrido nettamente superiore rispetto a un approccio tradizionale.

Lo studio rappresenta un primo passo verso lo sviluppo di algoritmi genetici ibridi più efficienti, aprendo la strada a future ottimizzazioni.
