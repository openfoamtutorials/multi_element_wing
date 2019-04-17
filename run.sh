#!/bin/sh

# Quit script if any step has error:
set -e

# Generate the mesh from script (msh2 format is currently the latest gmshToFoam recognizes):
gmsh mesh/main.geo -3 -format msh2 -o mesh/main.msh
# Convert the mesh to OpenFOAM format:
gmshToFoam mesh/main.msh -case case
# Adjust polyMesh/boundary:
changeDictionary -case case
# Finally, run the simulation:
simpleFoam -case case

