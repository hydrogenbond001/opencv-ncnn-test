#!/bin/bash
# run_test.sh
echo "Running opencv-ncnn-test..."
chmod +x ./bin/opencv-ncnn-test ./bin/opencv-dbnet-test run_test.sh
export LD_LIBRARY_PATH=./lib:$LD_LIBRARY_PATH
./bin/opencv-ncnn-test ./model/crnn_lite_op.bin ./model/2.jpg
./bin/opencv-dbnet-test ./model/dbnet_op.bin ./model/2.jpg