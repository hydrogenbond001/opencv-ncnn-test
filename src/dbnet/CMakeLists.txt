# 定义 app1 可执行文件
add_executable(opencv-dbnet-test dbnet.cpp)

target_include_directories(opencv-dbnet-test PRIVATE ${OpenCV_INCLUDE_DIRS} ${ncnn_INCLUDE_DIRS})
target_link_libraries(opencv-dbnet-test PRIVATE ${OpenCV_LIBS} ncnn)