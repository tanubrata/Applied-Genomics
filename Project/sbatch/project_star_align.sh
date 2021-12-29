#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=20
#SBATCH --time=10:00:00
#SBATCH --mem=126GB
#SBATCH --job-name=star_align
#SBATCH --mail-type=ALL
#SBATCH --account=class
#SBATCH --mail-user=td2201@nyu.edu
#SBATCH --output=log/star_align_slurm_%j.out
#SBATCH --array=47-56

cd /scratch/td2201/appl_genomics/Project/

module purge
module load star/intel/2.7.6a

time STAR --genomeDir GRCh38/Star_ref/ \
--runThreadN 20 \
--readFilesIn Data/trimmed/SRR108531${SLURM_ARRAY_TASK_ID}_trimmed.fastq \
--outFileNamePrefix result/Star/SRR108531${SLURM_ARRAY_TASK_ID}/ \
--outSAMtype BAM SortedByCoordinate \
--outSAMunmapped Within \
--outSAMattributes Standard









