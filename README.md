# Cryptic Pocket Exposure via Strategic Mutagenesis

This repository contains the input files, parameters, and analysis
scripts associated with the manuscript:

**"Predicting Holo-Like Conformations of Proteins with Cryptic
Pockets by Targeted Mutation of Cryptic Residues"**
Reshob Routh, Mithun Radhakrishna


## Contents
- `MD_input_files/` — GROMACS mdp files for all simulation stages
- `MDpocket/` — MDpocket grid parameters and reference volumes
- `Scripts/` — Python scripts for cleft distance and RMSD analysis
- `ColabFold_outputs/` — Mutant protein structures from ColabFold

## Software versions
- GROMACS 2023.3
- CHARMM36m force field (July 2022 update)
- CGenFF 4.6
- MDpocket (fpocket 3.0)
- ColabFold 1.5.2 (AlphaFold2 backend)
- Python 3.10
- UCSF Chimera 1.18
- VMD 1.9.4
- PyMOL 3.1.4
