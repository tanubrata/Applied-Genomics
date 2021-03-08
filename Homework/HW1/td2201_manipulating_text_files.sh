# 1. Unzip flybase_r6.gtf.gz. This is a GTF file containing the genomic features of a fruit fly.
cd $SCRATCH
cd appl_genomics/week_1_linux_intro/assignment/data/
gunzip flybase_r6.gtf.gz

# 2. Check the first seven lines of the file, and save it as head_of_gtf.txt.
head -7 flybase_r6.gtf > head_of_gtf.txt
pwd

# 3. You can either save it directly into result or save it first and move it later. 
mv head_of_gtf.txt ../result
cd ../result
#Q: What is the first gene and last gene in this file (GTF file)?
#   First Gene: FlyBase gene  19961297    19969323   .    +    .    gene_id "FBgn0031081"; gene_symbol "Nep3";
#   Last Gene: FlyBase gene   868673  869857    .   -   .    gene_id "FBgn0020305"; gene_symbol "dbe";

# 4. Each line of a GTF file is a genomic feature (e.g., CDS, UTR, exon, mRNA, gene, and etc.)
# 5. Figure out how many splicing variants are there for a gene called elav.
cd ../data
grep "mRNA" flybase_r6.gtf | grep "elav" | wc -l  #Answer: 4 (4 mRNAs found in data)

