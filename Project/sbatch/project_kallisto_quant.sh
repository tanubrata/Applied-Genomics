#!/bin/bash

#SBATCH --job-name=td2201_Project_Kallisto_quant
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=10
#SBATCH --mem=64GB
#SBATCH --time=4:00:00
#SBATCH --output=log/kallisto_quant_slurm_%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=td2201@nyu.edu
#SBATCH --account=class
#SBATCH --array=47-56

cd /scratch/td2201/appl_genomics/Project/

module purge
module load kallisto/0.46.1


kallisto quant -i GRCh38/GRCh38 \
                -o result/kallisto/SRR108531${SLURM_ARRAY_TASK_ID} \
                --single -l 200 -s 20 \
                Data/trimmed/SRR108531${SLURM_ARRAY_TASK_ID}_trimmed.fastq 
                