#!/bin/bash
# run_test.sh
echo "Running opencv-ncnn-test..."
export LD_LIBRARY_PATH=./lib:$LD_LIBRARY_PATH
./bin/opencv-ncnn-test ./model/crnn_lite_op.bin ./model/2.jpg