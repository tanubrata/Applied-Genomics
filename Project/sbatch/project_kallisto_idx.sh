#!/bin/bash

#SBATCH --job-name=td2201_Project_Kallisto_index
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32GB
#SBATCH --time=1:00:00
#SBATCH --output=log/kallisto_index_slurm_%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=td2201@nyu.edu
#SBATCH --account=class

cd /scratch/td2201/appl_genomics/Project/GRCh38/

module purge
module load kallisto/0.46.1

kallisto index -i GRCh38 Homo_sapiens.GRCh38.all.fa


