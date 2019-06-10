#!/bin/bash

#$ -cwd -V
#$ -l h_vmem=12G
#$ -l coproc_k80=1
#$ -l h_rt=03:20:00
#$ -m bae
#$ -M scsoo@leeds.ac.uk

cd /nobackup/scsoo/darknet

module load opencv
module load cuda

# train
./darknet detector train litter/litter.data litter/yolov3-tiny-litter.cfg darknet53.conv.74
# ./darknet detector train litter/litter.data litter/yolov3-litter.cfg darknet53.conv.74
# resume
# ./darknet detector train litter/litter.data litter/yolov3-tiny-litter.cfg backup/yolov3-tiny-litter.backup 
# ./darknet detector train litter/litter.data litter/yolov3-litter.cfg backup/yolov3-litter.backup 

