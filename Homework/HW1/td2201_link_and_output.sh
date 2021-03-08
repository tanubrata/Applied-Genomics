# 1. Please make a shortcut named ag in your home directory and point it to /scratch/[your NetID]/appl_genomics.
#   If you succeed, you should be able to cd ag and go right into the folder.
cd $HOME
ln -s /scratch/td2201/appl_genomics/ ag
cd ag

# 2. After creating a shortcut that works, do ls -l for your home directory, and redirect the output 
#   to save it as home_files_[netID].txt.
cd $HOME
ls -l > home_files_td2201.txt

# 3. Draw the file tree for your applied genomics folder (/scratch/[your NetID]/appl_genomics). 
# The shortcut should be handy now. Save output of the tree by redirection as ag_tree_[netID].txt.
pwd #/home/td2201
tree ag > ag_tree_td2201.txt

###   FINAL STEP  ###
##Run the following command before proceeding:
date >> ag_tree_td2201.txt

###Bonus: Find out how to create a compressed archive file (.tar.gz)###

#copied 6 files to archive/td2201/ using FileZilla.

tar -czf homework_1_td2201.tar.gz ag_tree_td2201.txt head_of_gtf.txt home_files_td2201.txt td2201_link_and_output.sh td2201_manipulating_text_files.sh td2201_organizing_files.sh