#!/bin/bash

#$ -cwd -V
#$ -l h_vmem=12G
#$ -l coproc_k80=1
#$ -l h_rt=30:20:00
#$ -m bae
#$ -M scsoo@leeds.ac.uk

cd /nobackup/scsoo
source tensorflow/bin/activate

module load cuda
module load python/3.6.0
module load python-libs
cd /nobackup/scsoo/mobilenetSSD/tensorflow/models/research
export PYTHONPATH=`pwd`:`pwd`/slim:~/.local/lib/python3.6/site-packages:$PYTHONPATH
#echo $PYTHONPATH
cd /nobackup/scsoo/mobilenetSSD/tensorflow/models/research/object_detection
#ls -al

python train.py --logtostderr --train_dir=$1 --pipeline_config_path=$2
