#! /bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=16G
#SBATCH --time=1:00:00
#SBATCH --job-name=hw5_plotMapping
#SBATCH --mail-type=ALL
#SBATCH --mail-user=td2201@nyu.edu


module purge
module load deeptools/3.5.0

cd /scratch/td2201/appl_genomics/week_10_CHiPseq/assignment05/

plotFingerprint -p 6 -b align/SRR3390053_dedup.bam align/SRR3390056_dedup.bam \
        --labels Input_12hr Lhx3_12hr --minMappingQuality 30 \
        --skipZeros --ignoreDuplicates \
        --extendReads 500 \
        -o ctrl_Lhx3_12hr.pdf

plotFingerprint -p 6 -b align/SRR3390069_dedup.bam align/SRR3390073_dedup.bam \
        --labels Input_48hr Lhx3_48hr --minMappingQuality 30 \
        --skipZeros --ignoreDuplicates \
        --extendReads 500 \
        -o ctrl_Lhx3_48hr.pdf
