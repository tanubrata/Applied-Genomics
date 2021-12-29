#!/bin/bash
#SBATCH --job-name=td2201_project_Fastqc
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32GB
#SBATCH --time=1:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=td2201@nyu.edu
#SBATCH --array=47-56


cd /scratch/td2201/appl_genomics/Project/

module purge
module load fastqc/0.11.9

fastqc Data/SRR108531${SLURM_ARRAY_TASK_ID}.fastq -o fastqc/