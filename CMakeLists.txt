cmake_minimum_required(VERSION 3.11)
project(opencv-ncnn-test)
set(CMAKE_CXX_STANDARD 11)

# 设置交叉编译工具链
SET(CMAKE_C_COMPILER "${CMAKE_CURRENT_SOURCE_DIR}/toolchain/arm-rockchip830-linux-uclibcgnueabihf/bin/arm-rockchip830-linux-uclibcgnueabihf-gcc")
SET(CMAKE_CXX_COMPILER "${CMAKE_CURRENT_SOURCE_DIR}/toolchain/arm-rockchip830-linux-uclibcgnueabihf/bin/arm-rockchip830-linux-uclibcgnueabihf-g++")

# 设置 OpenCV 路径
set(OpenCV_DIR "./opencv-mobile-4.10.0-luckfox-pico/lib/cmake/opencv4")
find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})
message(STATUS "OpenCV_LIBS=${OpenCV_LIBS}")

# 设置 ncnn 路径
set(NCNN_DIR "${CMAKE_CURRENT_SOURCE_DIR}/ncnn_lib/lib/cmake/ncnn")
find_package(ncnn REQUIRED PATHS ${NCNN_DIR})
include_directories(${NCNN_INCLUDE_DIRS})
message(STATUS "NCNN_LIBS=${NCNN_LIBS}")

# 包含 ncnn 头文件
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/ncnn/build/install/include")

# 添加可执行文件
add_executable(opencv-ncnn-test main.cpp)

# 链接库
link_directories(${CMAKE_CURRENT_SOURCE_DIR}/ncnn/build/install/lib)
target_link_libraries(opencv-ncnn-test ${OpenCV_LIBS} ncnn)

# 设置安装规则
install(TARGETS opencv-ncnn-test
        RUNTIME DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/install
        LIBRARY DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/install
        ARCHIVE DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/install
)

# 如果需要安装其他文件（如配置文件、模型文件等），可以添加以下规则
install(FILES ./model/2.jpg ./model/crnn_lite_op.bin ./model/crnn_lite_op.param ./model/keys.txt
        DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/install/model
)