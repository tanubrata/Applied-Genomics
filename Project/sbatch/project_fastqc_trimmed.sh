#!/bin/bash
#SBATCH --job-name=td2201_fastqc_trimmed
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32GB
#SBATCH --time=1:00:00
#SBATCH --output=log/trim_fastqc_slurm_%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=td2201@nyu.edu
#SBATCH --array=47-56


cd /scratch/td2201/appl_genomics/Project/

module purge
module load fastqc/0.11.9

fastqc Data/trimmed/SRR108531${SLURM_ARRAY_TASK_ID}_trimmed.fastq -o fastqc/trimmed/