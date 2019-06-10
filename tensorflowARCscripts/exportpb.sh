#!/bin/bash

### $1 is the path to the configuration file. It is of the form trainingSSD/ssd_mobilenet_v1_coco.config or trainingRCNN/faster_rcnn_inception_v2_pets.config
### $2 points to the specific saved checkpoint you are interested in located at trainingSSD/model.ckpt-XXX or trainingRCNN/model.ckpt-XXX where XXX is the iteration number.
### $3 location where inference graph is saved: inference_graphSSD or inference_graphRCNN
### $4 name of opencv graph.pbtxt created using tf_text_graph*.py script. it should be either mobilenetSSDgraph.pbtxt or faster_rcnn_graph.pbtxt

#$ -cwd -V
#$ -l h_vmem=3G
#$ -l coproc_k80=0.5
#$ -l h_rt=01:15:00
#$ -m bae
#$ -M scsoo@leeds.ac.uk

cd /nobackup/scsoo
source tensorflow/bin/activate

module load cuda
module load python/3.6.0
module load python-libs
cd /nobackup/scsoo/mobilenetSSD/tensorflow/models/research
export PYTHONPATH=`pwd`:`pwd`/slim:~/.local/lib/python3.6/site-packages:$PYTHONPATH

cd /nobackup/scsoo/mobilenetSSD/tensorflow/models/research/object_detection


# GENERATE FASTER-RCNN pb and pbtxt files
# python export_inference_graph.py --input_type image_tensor --pipeline_config_path trainingRCNN-10000/faster_rcnn_inception_v2_pets.config --trained_checkpoint_prefix trainingRCNN-10000/model.ckpt-10000 --output_directory inference_graphRCNN-10000
# python tf_text_graph_faster_rcnn.py --input=inference_graphRCNN-10000/frozen_inference_graph.pb --output=inference_graphRCNN/faster_rcnn_10000.pbtxt --config=trainingRCNN-10000/faster_rcnn_inception_v2_pets.config
# cp inference_graphRCNN-10000/frozen_inference_graph.pb inference_graphRCNN-10000/faster_rcnn_10000.pb

# GENERATE MOBILENET-SSD frozen_inference_graph.pb file
# python export_inference_graph.py --input_type image_tensor --pipeline_config_path trainingSSD-10000/ssd_mobilenet_v1_coco.config --trained_checkpoint_prefix trainingSSD-10000/model.ckpt-10000 --output_directory inference_graphSSD-10000
#there is need to transform SSD's frozen_inference graph before generating the pbtxt file for it.

python tf_text_graph_ssd.py --input=inference_graphSSD-10000/mobilenetSSD-10000.pb --output=inference_graphSSD-10000/mobilenetSSD-10000.pbtxt --config=trainingSSD-10000/ssd_mobilenet_v1_coco.config

# python tf_text_graph_ssd.py --input=$3/frozen_inference_graph.pb --output=$3/$4 --config=$1
# python tf_text_graph_ssd.py --input=inference_graphSSD/final_graph.pb --output=inference_graphSSD/final_graph_mobilenetssd.pbtxt --config=trainingSSD/ssd_mobilenet_v1_coco.config
