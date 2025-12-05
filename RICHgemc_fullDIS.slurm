#!/bin/bash
#SBATCH --job-name=gemc-sim
#SBATCH --account=vossenlab
#SBATCH --partition=scavenger
#SBATCH --mem-per-cpu=2500
#SBATCH --time=12:00:00
#SBATCH --array=1-5
#SBATCH --output=/cwork/cmp115/job_output/%x-%j.out
#SBATCH --error=/cwork/cmp115/job_output/%x-%j.out

#INCREASE TIME LIMIT
OUTSTR="DIS_dev_rga_3kFull_$SLURM_ARRAY_TASK_ID"
OUTPUTDIR="/cwork/cmp115/RICH/gemcSim/"
OUTSUBDIR="DIS/rga/skimmed_dis"
if [ ! -d "$OUTPUTDIR/gemcFiles/$OUTSUBDIR" ]; then
    mkdir -p "$OUTPUTDIR/gemcFiles/$OUTSUBDIR"
    echo "Directory created: $OUTPUTDIR/gemcFiles/$OUTSUBDIR"
fi
if [ ! -d "$OUTPUTDIR/recoFiles/$OUTSUBDIR" ]; then
    mkdir -p "$OUTPUTDIR/recoFiles/$OUTSUBDIR"
    echo "Directory created: $OUTPUTDIR/recoFiles/$OUTSUBDIR"
fi

# replace with rgc_summer2022.gcard for 2 sectors of RICH
$GEMC/gemc -USE_GUI=0 -N=3000 clas12-config/gemc/dev/rga_fall2018.gcard -INPUT_GEN_FILE="LUND, lund-skim/sector41skim_clasdis_10k_targetshiftm3cm_hadInRICH_p1GeV_$SLURM_ARRAY_TASK_ID.dat" -OUTPUT="hipo, $OUTPUTDIR/gemcFiles/$OUTSUBDIR/gemc_$OUTSTR.hipo"

if [ -f "$OUTPUTDIR/recoFiles/$OUTSUBDIR/RECO_$OUTSTR.hipo" ]; then
    # If the file exists, remove it, otherwise recon-utils fails
    rm "$OUTPUTDIR/recoFiles/$OUTSUBDIR/RECO_$OUTSTR.hipo"
fi

recon-util -y clas12-config/coatjava/11.1.0/rga_fall2018.yaml -i $OUTPUTDIR/gemcFiles/$OUTSUBDIR/gemc_$OUTSTR.hipo -o $OUTPUTDIR/recoFiles/$OUTSUBDIR/RECO_$OUTSTR.hipo
