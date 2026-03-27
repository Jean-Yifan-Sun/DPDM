#!/bin/bash
#SBATCH --account=chenhp-data-gen
#SBATCH --qos=bham
#SBATCH --time=48:00:00
#SBATCH --nodes 1
#SBATCH --gres gpu:1
#SBATCH --gpus-per-task 1
#SBATCH --tasks-per-node 1
#SBATCH --constraint=a100_80
#SBATCH --mem=256G  # 请求内存
set -e
module purge
module load baskerville

# 运行 Python 命令
source /bask/projects/q/qingjiem-heart-tte/yifansun/conda/miniconda/etc/profile.d/conda.sh
conda init
conda activate dpdm
conda info --envs
cd /bask/projects/c/chenhp-data-gen/yifansun/project/DPDM
export PYTHONPATH=$PYTHONPATH:$(pwd)
nohup python dataset_tool.py --source data/raw/cifar-10-python.tar.gz --dest data/processed/cifar10.zip