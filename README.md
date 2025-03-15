# Bachelor's degree in Computer Science

> University of Pisa A.A. 23/24, February 25 2025

Thesis grade

> 29/30

Final grade 

> 103/110

## Description

This repository contains the implementation of a **hybrid genetic algorithm** integrating **clustering** and **reinforcement learning** to enhance optimization performance.

### Abstract

For a detailed overview of the project, check out the abstract: 
📄 [Read the Abstract](abstract/abstract.pdf)

> [Italian version](abstract/abstract_it.pdf)

If you are interested in reading the full thesis, please contact me on [LinkedIn](https://www.linkedin.com/in/francescolazzarelli/).

## Installation

To run the hybrid genetic algorithm, it is necessary to install the **PlatEMO** library for MATLAB. You can download it from the official MathWorks repository:  
🔗 [PlatEMO on MATLAB Central](https://it.mathworks.com/matlabcentral/fileexchange/105260-platemo)

### Setup Instructions

1. Copy the contents of the [`HGA`](HGA/) folder into the `Algorithms` directory of **PlatEMO**.
2. Open MATLAB and run the following command to launch the PlatEMO GUI:
   ```matlab
   platemo();
   ```
3. To test the algorithm with a benchmark problem:
   - Click on **Open file** in the **Algorithms** section.
   - Select the file [`HYBRIDGA.m`](HGA/HYBRIDGA.m).
   - Choose a **multi-objective problem**, either **real-valued, binary, or permutative**.

## License

This project is licensed under the **MIT License**.  

If you use this research as a starting point for your work, please **cite this repository and the author** appropriately. 

### Citation Example (LaTeX format)
If you use this work in your research, please cite it as follows:

```latex
@article{HybridGA,
  title={{HybridGA}: A hybrid genetic algorithm integrating clustering and reinforcement learning},
  author={Francesco Lazzarelli},
  year={2025},
}
```

## Reference

> **Platemo**: Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB Platform for Evolutionary Multi-Objective Optimization [Educational Forum], IEEE Computational Intelligence Magazine, 2017, 12(4): 73-87
