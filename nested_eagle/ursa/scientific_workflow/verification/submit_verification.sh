#!/bin/bash

#SBATCH -J perform_verification 
#SBATCH -o slurm-%j.out
#SBATCH -e slurm-%j.err
#SBATCH --account=epic
#SBATCH --partition=u1-service
#SBATCH --mem=128g
#SBATCH -t 01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1

source /scratch4/NAGAPE/epic/role-epic/miniconda/bin/activate

export LD_LIBRARY_PATH=$CONDA_PREFIX/lib:$LD_LIBRARY_PATH

export WORKDIR_BASE_PATH=$PWD

sed -i "/^.*workdir:.*$/c\  workdir: $WORKDIR_BASE_PATH\/wxvx_workdir\/lam" wxvx_lam.yaml

sed -i "/^.*workdir:.*$/c\  workdir: $WORKDIR_BASE_PATH\/wxvx_workdir\/global" wxvx_global.yaml

conda activate wxvx 

wxvx -c wxvx_lam.yaml -t plots

wxvx -c wxvx_global.yaml -t plots
