#!/bin/bash
set -e

############################################
# USER-DEFINED VARIABLES
############################################
GMX=gmx_mpi
VMD=vmd
MDPOCKET=mdpocket
PYTHON=python3

REF_PDB=em_reference_protein.pdb
ALIGNED_XTC=protein_aligned_skip25.xtc
DX_FILE=mdpout_dens_grid.dx
ISO_PDB=iso_0.5.pdb
ISO_VALUE=0.5

############################################
# STEP 1: Extract protein reference PDB using VMD
############################################
echo "==> Step 1: Extracting protein-only reference PDB (VMD)"

cat << EOF > extract_protein.tcl
mol new em.gro type gro
set prot [atomselect top "protein"]
\$prot writepdb ${REF_PDB}
quit
EOF

${VMD} -dispdev text -e extract_protein.tcl
rm extract_protein.tcl

############################################
# STEP 2: Align trajectory
# Fit group     : Backbone (4)
# Output group  : Protein  (1)
############################################
echo "==> Step 2: Aligning trajectory (fit=Backbone, output=Protein, skip=25)"

printf "4\n1\n" | ${GMX} trjconv \
    -s em.gro \
    -f md_noPBC.xtc \
    -o ${ALIGNED_XTC} \
    -fit rot+trans \
    -skip 25

############################################
# STEP 3: Run mdpocket
############################################
echo "==> Step 3: Running mdpocket"

${MDPOCKET} \
    --trajectory_file ${ALIGNED_XTC} \
    --trajectory_format xtc \
    -f ${REF_PDB}

############################################
# STEP 4: Extract isosurface from density grid
############################################
echo "==> Step 4: Extracting isosurface (isovalue = ${ISO_VALUE})"

${PYTHON} extractISOPdb.py ${DX_FILE} ${ISO_PDB} ${ISO_VALUE}

############################################
# DONE
############################################
echo "==> Pipeline completed successfully!"
echo "Generated files:"
echo " - ${REF_PDB}"
echo " - ${ALIGNED_XTC}"
echo " - ${DX_FILE}"
echo " - ${ISO_PDB}"
