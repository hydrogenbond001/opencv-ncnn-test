cmake_minimum_required(VERSION 3.10)
project(opencv-ncnn-test)

# 启用 C++ 标准
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 检测是否使用交叉编译
if(CMAKE_TOOLCHAIN_FILE)
    message(STATUS "Using toolchain file: ${CMAKE_TOOLCHAIN_FILE}")
else()
    message(STATUS "本地编译")
endif()

# 确保 LIB_ARCH 变量被正确传递
if(NOT DEFINED LIB_ARCH OR (NOT LIB_ARCH MATCHES "^(x86_64|aarch64|rv1106)$"))
    set(LIB_ARCH "x86_64" CACHE STRING "Target library architecture" FORCE)
endif()


# 显示架构信息
message(STATUS "Using architecture: ${LIB_ARCH}")

# 选择 OpenCV 和 NCNN 相关路径
set(OpenCV_DIR "${CMAKE_SOURCE_DIR}/opencv_lib/${LIB_ARCH}/lib/cmake/opencv4")
set(ncnn_DIR "${CMAKE_SOURCE_DIR}/ncnn_lib/${LIB_ARCH}/lib/cmake/ncnn")

# 打印库路径
message(STATUS "OpenCV_DIR: ${OpenCV_DIR}")
message(STATUS "ncnn_DIR: ${ncnn_DIR}")

# 查找 OpenCV
find_package(OpenCV REQUIRED)
find_package(ncnn REQUIRED)

# 添加源码
add_executable(opencv-ncnn-test main.cpp)

# 链接 OpenCV 和 NCNN
target_include_directories(opencv-ncnn-test PRIVATE ${OpenCV_INCLUDE_DIRS} ${ncnn_INCLUDE_DIRS})
target_link_libraries(opencv-ncnn-test PRIVATE ${OpenCV_LIBS} ncnn)


# 设置安装规则
install(TARGETS opencv-ncnn-test
        RUNTIME DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/install/bin
        LIBRARY DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/install/lib
        ARCHIVE DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/install/lib
)

# 安装模型文件
install(FILES ./model/2.jpg ./model/crnn_lite_op.bin ./model/crnn_lite_op.param ./model/keys.txt
        DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/install/model
)

# 安装脚本文件
install(FILES scripts/run_test.sh
        DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/install
        PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
)