#!/bin/bash
#SBATCH --job-name=td2201_project_trimmomatic
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32GB
#SBATCH --time=2:00:00
#SBATCH --output=log/trim_slurm_%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=td2201@nyu.edu
#SBATCH --array=47-56

cd /scratch/td2201/appl_genomics/Project/

module purge
module load trimmomatic/0.39

java -jar $TRIMMOMATIC_JAR SE -phred33 \
Data/SRR108531${SLURM_ARRAY_TASK_ID}.fastq \
Data/trimmed/SRR108531${SLURM_ARRAY_TASK_ID}_trimmed.fastq \
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:16 MINLEN:36