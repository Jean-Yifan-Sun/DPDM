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
nohup python main.py --mode eval --workdir <new_directory> --config configs/mnist_28/sample_eps_1.0.yaml -- model.ckpt=<checkpoint_path> sampler.type=edm sampler.s_churn=100. sampler.s_min=0.05 sampler.s_max=50. sampler.num_steps=1000