#!/bin/bash

#SBATCH --job-name=td2201_HW2_comp_aligners
#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=8GB
#SBATCH --time=01:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=td2201@nyu.edu


cd $SCRATCH
mkdir appl_genomics/week_4_seq_align
cd appl_genomics/week_4_seq_align
mkdir {data,result}
cp -r /scratch/work/courses/AppliedGenomics2021Sec3/assignment02/* /scratch/td2201/appl_genomics/week_4_seq_align/data/

cd week_4_seq_align/data
pwd
ls -lh

module purge
module load trimmomatic/0.39
module load bowtie2/2.4.2
module load samtools/intel/1.11
module load star/intel/2.7.6a
module load hisat2/2.2.1
module load python/intel/3.8.6
module load fastqc/0.11.9
module load bwa/intel/0.7.17
module load picard/2.23.8

# TRIMMOMATIC
java -jar /share/apps/trimmomatic/0.39/trimmomatic-0.39.jar PE -phred33 \
read_1.fastq read_2.fastq \
read_1_trimmed.fq read_1_unpair_trimmed.fq \
read_2_trimmed.fq read_2_unpair_trimmed.fq \
HEADCROP:15 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

#BOWTIE2
mkdir chr17_bowtie2
cd chr17_bowtie2

bowtie2-build ../chr17.fa chr17_bowtie2

cd ../
cd ../
mkdir result/bowtie2

bowtie2 -p 2 \
        -x data/chr17_bowtie2/chr17_bowtie2 \
        -1 data/read_1.fastq -2 data/read_2.fastq -S result/bowtie2/chr17_bowtie2.sam

samtools view -S -b result/bowtie2/chr17_bowtie2.sam > result/bowtie2/chr17_bowtie2.bam
samtools sort result/bowtie2/chr17_bowtie2.bam -o result/bowtie2/chr17_bowtie2_sorted.bam
samtools flagstats result/bowtie2/chr17_bowtie2_sorted.bam

#STAR w/o splice
mkdir data/chr17_star_basic

STAR --runThreadN 2 \
--runMode genomeGenerate \
--genomeSAindexNbases 11 \
--genomeDir data/chr17_star_basic/ \
--genomeFastaFiles data/chr17.fa

mkdir result/STAR
STAR --genomeDir data/chr17_star_basic/ \
--runThreadN 2 \
--readFilesIn data/read_1_trimmed.fq data/read_2_trimmed.fq \
--outFileNamePrefix result/STAR/ \
--outSAMtype BAM SortedByCoordinate \
--outSAMunmapped Within \
--outSAMattributes Standard

samtools flagstat result/STAR/Aligned.sortedByCoord.out.bam

mkdir result/STAR_nt
STAR --genomeDir data/chr17_star_basic/ \
--runThreadN 2 \
--readFilesIn data/read_1.fastq data/read_2.fastq \
--outFileNamePrefix result/STAR_nt/ \
--outSAMtype BAM SortedByCoordinate \
--outSAMunmapped Within \
--outSAMattributes Standard

samtools flagstat result/STAR_nt/Aligned.sortedByCoord.out.bam
samtools flagstat result/STAR_nt/Aligned.sortedByCoord.out.bam > chr17_STAR_nt.txt

#STAR w/ splice
mkdir data/chr17_starsj
mkdir result/STAR_sj

STAR --runThreadN 2 \
--runMode genomeGenerate \
--genomeSAindexNbases 11 \
--genomeDir data/chr17_starsj/ \
--genomeFastaFiles data/chr17.fa \
--sjdbGTFfile data/chr17.gtf \
--sjdbOverhang 99

STAR --genomeDir data/chr17_starsj/ \
--runThreadN 2 \
--readFilesIn data/read_1.fastq data/read_2.fastq \
--outFileNamePrefix result/STAR_sj/ \
--outSAMtype BAM SortedByCoordinate \
--outSAMunmapped Within \
--outSAMattributes Standard

samtools flagstat result/STAR_sj/Aligned.sortedByCoord.out.bam

#HISAT2
mkdir data/chr17_hisat2
mkdir result/hisat2

cd data/chr17_hisat2
hisat2-build ../chr17.fa chr17_hisat2

cd ../
cd ../

hisat2 -p 2 \
        -x data/chr17_hisat2/chr17_hisat2 \
        -1 data/read_1.fastq -2 data/read_2.fastq -S result/hisat2/chr17_hisat2.sam

samtools view -S -b result/hisat2/chr17_hisat2.sam > result/hisat2/chr17_hisat2.bam
samtools sort result/hisat2/chr17_hisat2.bam -o result/hisat2/chr17_hisat2_sorted.bam
samtools flagstats result/hisat2/chr17_hisat2_sorted.bam

samtools flagstats result/hisat2/chr17_hisat2_sorted.bam > chr17_hisat2_sorted.txt
samtools flagstat result/STAR_sj/Aligned.sortedByCoord.out.bam >chr17_STARsj.txt
samtools flagstat result/STAR/Aligned.sortedByCoord.out.bam > chr17_STAR.txt
samtools flagstats result/bowtie2/chr17_bowtie2_sorted.bam > chr17_bowtie2.txt
samtools flagstat result/STAR_nt/Aligned.sortedByCoord.out.bam > chr17_STAR_nt.txt

#FASTQC
mkdir Fastqc #n week4

fastqc data/read_1.fastq -o Fastqc/
fastqc data/read_2.fastq -o Fastqc/

#Burrow-Wheeler's Alignment
mkdir data/chr17_bwa
cd data/chr17_bwa

bwa index ../chr17.fa

cd ../
pwd

bwa mem chr17.fa read_1.fastq read_2.fastq >chr17_bwa_aligned_reads.sam
mv chr17_bwa_aligned_reads.sam ../result/bwa/

cd ../result/bwa/
java -jar $PICARD_JAR SortSam INPUT=chr17_bwa_aligned_reads.sam \
OUTPUT=chr17_bwa_aligned_sorted.bam SORT_ORDER=coordinate

samtools flagstat chr17_bwa_aligned_sorted.bam

