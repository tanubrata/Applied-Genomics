#!/bin/bash

#SBATCH --job-name=td2201_HW2_comp_aligners
#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=8GB
#SBATCH --time=0:40:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=td2201@nyu.edu

cd /scratch/td2201/appl_genomics/week_4/data/

module purge
module load trimmomatic/0.39
module load samtools/intel/1.11
module load star/intel/2.7.6a
module load hisat2/2.2.1
module load python/intel/3.8.6
module load fastqc/0.11.9
module load bwa/intel/0.7.17
module load picard/2.23.8


fastqc read_1.fastq -o fastqc/
fastqc read_2.fastq -o fastqc/


STAR --runThreadN 2 \
--runMode genomeGenerate \
--genomeSAindexNbases 11 \
--genomeDir chr17_Star/ \
--genomeFastaFiles chr17.fa


STAR --genomeDir chr17_Star \
--runThreadN 2 \
--readFilesIn read_1.fastq read_2.fastq \
--outFileNamePrefix ../result/Star/ \
--outSAMtype BAM SortedByCoordinate \
--outSAMunmapped Within \
--outSAMattributes Standard

samtools flagstat ../result/Star/Aligned.sortedByCoord.out.bam > ../chr17_Star.txt


STAR --runThreadN 2 \
--runMode genomeGenerate \
--genomeSAindexNbases 11 \
--genomeDir chr17_Star_sjdb/ \
--genomeFastaFiles chr17.fa \
--sjdbGTFfile chr17.gtf \
--sjdbOverhang 99

STAR --genomeDir chr17_Star_sjdb \
--runThreadN 2 \
--readFilesIn read_1.fastq read_2.fastq \
--outFileNamePrefix ../result/Star_sjdb/ \
--outSAMtype BAM SortedByCoordinate \
--outSAMunmapped Within \
--outSAMattributes Standard


samtools flagstat ../result/Star_sjdb/Aligned.sortedByCoord.out.bam > ../chr17_Star_sjdb.txt


hisat2-build chr17.fa chr17_hisat2/chr17_hisat2

hisat2 -p 2 \
        -x chr17_hisat2/chr17_hisat2 \
        -1 read_1.fastq -2 read_2.fastq -S ../result/hisat2/chr17_hisat2.sam

samtools view -S -b ../result/hisat2/chr17_hisat2.sam > ../result/hisat2/chr17_hisat2.bam
samtools sort ../result/hisat2/chr17_hisat2.bam -o ../result/hisat2/chr17_hisat2_sorted.bam


samtools flagstat ../result/hisat2/chr17_hisat2_sorted.bam > ../chr17_hisat2_sorted.txt

hisat2_extract_splice_sites.py chr17.gtf > chr17_hisat2_ss/chr17.ss
hisat2_extract_exons.py chr17.gtf > chr17_hisat2_ss/chr17.exon

hisat2-build --exon chr17_hisat2_ss/chr17.exon --ss chr17_hisat2_ss/chr17.ss chr17.fa chr17_hisat2_ss/chr17_hisat2_ss

hisat2 -p 2 \
        -x chr17_hisat2_ss/chr17_hisat2_ss \
        -1 read_1.fastq -2 read_2.fastq -S ../result/hisat2_ss/chr17_hisat2_ss.sam
        
samtools view -S -b ../result/hisat2_ss/chr17_hisat2_ss.sam > ../result/hisat2_ss/chr17_hisat2_ss.bam
samtools sort ../result/hisat2_ss/chr17_hisat2_ss.bam -o ../result/hisat2_ss/chr17_hisat2_sorted_ss.bam

samtools flagstat ../result/hisat2_ss/chr17_hisat2_sorted_ss.bam > ../chr17_hisat2_sorted_ss.txt

bwa index chr17.fa

bwa mem chr17.fa read_1.fastq read_2.fastq > ../result/bwa/chr17_bwa_aligned_reads.sam

java -jar $PICARD_JAR SortSam INPUT= ../result/bwa/chr17_bwa_aligned_reads.sam \
OUTPUT= ../result/bwa/chr17_bwa_aligned_reads.bam SORT_ORDER=coordinate

samtools flagstat ../result/bwa/chr17_bwa_aligned_reads.bam > ../chr17_bwa_aligned_sorted.txt


