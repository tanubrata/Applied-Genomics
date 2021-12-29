#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=20
#SBATCH --time=10:00:00
#SBATCH --mem=126GB
#SBATCH --job-name=htseq-count
#SBATCH --mail-type=ALL
#SBATCH --account=class
#SBATCH --mail-user=td2201@nyu.edu
#SBATCH --output=log/htseq_%j.out
#SBATCH --array=47-56

cd /scratch/td2201/appl_genomics/Project/

module purge
module load htseq/0.13.5

time htseq-count --format=bam \
             -s no \
             -t exon \
	         result/Star/SRR108531${SLURM_ARRAY_TASK_ID}/Aligned.sortedByCoord.out.bam \
	         GRCh38/Homo_sapiens.GRCh38.103.gtf > /scratch/td2201/appl_genomics/Project/result/htseq/SRR108531${SLURM_ARRAY_TASK_ID}.counts

