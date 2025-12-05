# clas12-rich-sim
Documentation of CLAS12 RICH simulation.

## Software requirements
If working on ifarm (recommended), gemc/5.12 now includes all recent changes to the RICH geometry and digitization, and can be loaded like all other modules, `` module load gemc/5.12 ``. The most recent additions by Marco to the ccdb should also mean that the online ccdb loaded will be set up correctly for the RICH.

Running gemc locally/on ifarm then requires
1. [clas12-config](https://github.com/JeffersonLab/clas12-config#) to load the correct gcards and coatjava yaml files
2. [clas12Tags](https://github.com/gemc/clas12Tags) to load the already-built CLAS12 geometry (tag 5.12)

In my setup on Duke's cluster, I would first unpack/clone ``clas12Tags``, then clone ``clas12-config`` within the clas12Tags directory for ease of use with the relative paths as they are set in the gemc gcards.

## Running the simulation
Running gemc and coatjava should now be pretty straightforward. On ifarm, you can use the already built gemc/5.12 executable. The example slurm job submission scripts in this directory will give an example of running gemc with a given lund file, and show exactly how I generated the most recent large simulated dataset used for calibration. 

If you want to filter for only a specific set of needed output banks (recommended), you can follow the instructions in the coatjava yaml files (setting up a directory with links to the .json bank definition files).

## Skimmed clasdis files
I placed my simple python script for skimming lund files for the scattered electron (always kept for timing) and hadrons in sectors 4/1 in the ``lundSkim/`` directory. It also includes an option for keeping events with the scattered electron in the RICH.
