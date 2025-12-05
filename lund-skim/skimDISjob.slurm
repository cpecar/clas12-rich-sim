#!/bin/bash
#SBATCH --job-name=rich-gemc-gen
#SBATCH --account=clas12
#SBATCH --partition=production
#SBATCH --mem-per-cpu=1000
#SBATCH --time=00:30:00
#SBATCH --array=0-20
#SBATCH --output=/farm_out/%u/%x-%j.out
#SBATCH --error=/farm_out/%u/%x-%j.err

if [ ! -d "files$SLURM_ARRAY_TASK_ID" ]; then
    mkdir -p "files$SLURM_ARRAY_TASK_ID"
    echo "Directory created: files$SLURM_ARRAY_TASK_ID"
fi

cp gen_dis.sh files$SLURM_ARRAY_TASK_ID
cp skimLund.py files$SLURM_ARRAY_TASK_ID
cd files$SLURM_ARRAY_TASK_ID
./gen_dis.sh $SLURM_ARRAY_TASK_ID
cd ../
mv files$SLURM_ARRAY_TASK_ID/* .
rm -r files$SLURM_ARRAY_TASK_ID
