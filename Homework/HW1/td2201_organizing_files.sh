# 1. Please create a new folder in your scratch directory called appl_genomics
cd $SCRATCH
mkdir appl_genomics

# 2. Under this folder, create two folders: week_1_linux_intro and week_2_slurm_jobs.
mkdir appl_genomics/{week_1_linux_intro,week_2_slurm_jobs}

# 3. Under week_1_linux_intro, create lecture_excercise and assignment.
mkdir appl_genomics/week_1_linux_intro/{lecture_exercise,assignment}

# 4. Move the files you used on the Wednesday (2/3) lecture to lecture exercise.
pwd
mv LinuxExercise/*.txt appl_genomics/week_1_linux_intro/lecture_exercise/

# 5. Under assignment, create the following folders: data, result.
pwd
mkdir appl_genomics/week_1_linux_intro/assignment/{data,result}

# 6. Download this Fly gene annotation from
#   ftp://ftp.flybase.org/genomes/dmel/current/gtf/dmel-all-r6.37.gtf.gz to data, and 
#   rename it to flybase_r6.gtf.gz.
cd appl_genomics/week_1_linux_intro/assignment/data/
wget ftp://ftp.flybase.org/genomes/dmel/current/gtf/dmel-all-r6.37.gtf.gz
mv dmel-all-r6.37.gtf.gz flybase_r6.gtf.gz
