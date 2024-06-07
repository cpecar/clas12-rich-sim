#!/bin/bash

# LOAD CORRECT CLAS12 VERSIONS
module unload ccdb/1.99.1
module switch gemc/5.10
module load sqlite/dev

# SET CUSTOM CCDB
export CCDB_CONNECTION=sqlite:////w/hallb-scshelf2102/clas12/pecar/RICH/gemcSim/ccdb_2024-05-12_richsim.sqlite

#set this to gemc
export GEMC=/w/hallb-scshelf2102/clas12/pecar/RICH/gemcSim/clas12-rich-sim/clas12Tags-5.10/source/
