#!/bin/bash
# run_test.sh
echo "Running opencv-ncnn-test..."
chmod +x ./bin/opencv-ncnn-test ./bin/opencv-dbnet-test run_test.sh
export LD_LIBRARY_PATH=./lib:$LD_LIBRARY_PATH
# ./bin/opencv-ncnn-test ./models/crnn_lite_op.bin ./models/test.jpg
./bin/opencv-dbnet-test ./models/test.jpg
# ./bin/opencv-dbnet-test --models model \--det dbnet_op \--cls angle_op \--rec crnn_lite_op \--keys keys.txt \--image ./model/2.jpg \--numThread 1 \--padding 50 \--maxSideLen 0 \--boxScoreThresh 0.6 \--boxThresh 0.3 \--unClipRatio 2.0 \--doAngle 1 \--mostAngle 1 \--GPU 0 --loopCount 1