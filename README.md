# clas12-rich-sim
Documentation of CLAS12 RICH simulation.

## Software requirements
If working on ifarm (recommended), gemc/5.12 now includes all recent changes to the RICH geometry and digitization, and can be loaded like all other modules, `` module load gemc/5.12 ``. The most recent additions by Marco to the ccdb should also mean that the online ccdb loaded will be set up correctly for the RICH.

Running gemc locally/on ifarm then requires
1. [clas12-config](https://github.com/JeffersonLab/clas12-config#) to load the correct gcards and coatjava yaml files
2. [clas12Tags](https://github.com/gemc/clas12Tags) to load the already-built CLAS12 geometry (tag 5.12)

In my setup on Duke's cluster, I would first unpack/clone ``clas12Tags``, then clone ``clas12-config`` within the clas12Tags directory for ease of use with the relative paths as they are set in the gemc gcards.

## Running the simulation
Running gemc and coatjava should now be pretty straightforward (previously the RICH required a lot more checking of geometry and configuring the ccdb). On ifarm, you can use the already built gemc/5.12 executable. The example slurm job submission scripts in this directory will give an example of running gemc with a given lund file, and show exactly how I generated the most recent large simulated dataset used for calibration. 

If you want to filter for only a specific set of needed output banks (recommended), you can follow the [instructions in the coatjava yaml files](https://github.com/JeffersonLab/clas12-config/blob/584b0c80568fd43e2c8b7b3bd1c9ec99964548a1/coatjava/11.1.0/rga_fall2018.yaml#L72) (setting up a directory with links to the .json bank definition files).

## Running clasdis and skimming lund files
I placed my simple python script for skimming lund files for the scattered electron (always kept for timing) and hadrons in sectors 4/1 in the ``lundSkim/`` directory. It also includes an option for keeping events with the scattered electron in the RICH.

To run ``clasdis`` on ifarm, first ``module load mcgen``. Then, ``clasdis`` can be run as
``clasdis --docker --trig 10000 --zpos -3``,
which will produce a file ``clasdis.dat`` with the 10000 lund-formatted events, and the vertex z position at -3cm. The directory ``lund-skim`` in this repository demonstrates how I have been producing these files with ``clasdis`` and skimming them for selected events. 

## Some other notes
- The slurm script I placed here for running gemc and coatjava is configured for Duke's cluster (should only require changing account and partition names)
- If anyone wants instructions for running in a container on a non-ifarm cluster, I am happy to provide it. I tried to write this up for use on ifarm since it is the most straightforward.
