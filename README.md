# dnn-object-detection
This repository contains details of steps taken to train and test three object detection algorithms: Tiny-YOLOv3, Faster RCNN and MobileNet SSD

## Preparing Dataset
1. Download images of litter from the internet. I used a simple script to download images of litter from ImageNet
2. Filtered out images where it is difficult to draw bounding boxes on them.
3. Get litter images from video recordings conducted with a robot in outdoor environments (I used 128 images).
4. Use the open source bounding box drawing tool to draw bounding boxes.

## YOLOv3
The training process for YOLOv3 and YOLOv3-tiny was the same. The steps include:

1. Downloading the network weights and configuration files
2. edit the configuration file to match the number of classes to train the network to detect (I retrained the network to detect only one class, which is litter objects)
3. Install darknet on the machine. I used ARC3 HPC at the University of Leeds.
4. Train the network for required number of iterations. I am using 10,000 iterations!
5. Inference can be done using Darknet. However, I found a python script that can use opencv to perform forward inference on the trained network.

## Faster RCNN

## MobileNet SSD
