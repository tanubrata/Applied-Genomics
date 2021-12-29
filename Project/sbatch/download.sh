#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=6
#SBATCH --time=6:00:00
#SBATCH --mem=32GB
#SBATCH --job-name=download
#SBATCH --account=class
#SBATCH --output=download_slurm_%j.out
#SBATCH --array=47-56
#SBATCH --mail-type=END
#SBATCH --mail-user=td2201@nyu.edu


module purge
module load sra-tools/2.10.9

cd /scratch/td2201/appl_genomics/Project/
# To submit an array job to download multiple fastq files in parallel
# This line gets the ${SLURM_ARRAY_TASK_ID}th line from a text
# file (SRR_list.txt) in which each line is a SRR number
# You can get this file from SRA run selector -> Accession List
#srr=$(awk "NR==${SLURM_ARRAY_TASK_ID}" SRR_Acc_List.txt)

# --split-3 forces fastq-dump to examine if 
# you have pair-ended or even three-read sequencing (forward, reverse, index)
# and save them as separated fastq files
# This makes it easier for the aligners to deal with the fastq files
fastq-dump --split-3 SRR108531${SLURM_ARRAY_TASK_ID}
