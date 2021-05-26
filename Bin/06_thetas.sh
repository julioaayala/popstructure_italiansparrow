#!/bin/bash -l

#SBATCH -A snic2020-5-635
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 10:00:00
#SBATCH -J theta_sparrows
#SBATCH --mail-user=ju7141ay-s@student.lu.se
#SBATCH --mail-type=FAIL

## Calculate thetas (tajimas D, waterson Theta, etc) for all populations
## Based on SFS using ANGSD

module load bioinfo-tools
module load ANGSD # ANGSD/0.933

## Using the template, generate for all populations
mkdir Bin/06_Theta_scripts
for pop in $(ls -1 Data/Populations/ | sed 's/.filelist//'); \
do sed "s/pop/$pop/g" Bin/Templates/theta.sh \
> Bin/06_Theta_scripts/$pop.sh; done

## Execute all scripts
for file in Bin/06_Theta_scripts/*; do chmod +x $file; ./$file; done