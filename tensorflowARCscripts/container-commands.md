# TENSORFLOW CONTAINER BAZEL COMMANDS
mobilenet-ssd did not work on tensorflow after exporting the frozen inference graph and generating the pbtxt file.
After much searching and research, this process worked for me.

1. I downloaded the tensorflow container that had bazel build installed in it
2. I used bazel to build the transform_graph source file. I had to modify the user_root_directory and cache directories to location where I had large storage space because I had only limited storage in my home directory

bazel --output_user_root /mnt/bazel_out/ build --disk_cache /mnt/cache/ tensorflow/tools/graph_transforms:transform_graph


3. I also used it to  build optimize for inference graph. To optimize the network for inference... However this later did not work. Only the transform graph worked for me.

bazel --output_user_root /mnt/bazel_out/ build --disk_cache /mnt/cache/ tensorflow/python/tools:optimize_for_inference

4. To do the graph transform, I used: 
/mnt/bazel_out/43801f1e35f242fb634ebbc6079cf6c5/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/tools/graph_transforms/transform_graph --in_graph=inference_graphSSD/frozen_inference_graph.pb --out_graph=mobilenetSSD-17068.pb --inputs=image_tensor --outputs="num_detections,detection_scores,detection_boxes,detection_classes" --transforms="fold_constants(ignore_errors=True)"
