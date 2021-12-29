#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --time=10:00:00
#SBATCH --mem=64GB
#SBATCH --job-name=index_bam
#SBATCH --mail-type=ALL
#SBATCH --account=class
#SBATCH --mail-user=td2201@nyu.edu
#SBATCH --output=log/index_bam_slurm_%j.out
#SBATCH --array=47-56

cd /scratch/td2201/appl_genomics/Project/

module purge
module load samtools/intel/1.12

samtools index result/Star/SRR108531${SLURM_ARRAY_TASK_ID}/Aligned.sortedByCoord.out.bam