#!/bin/bash
# build.sh - 自动选择架构并编译

set -e  # 遇到错误立即退出
BASE_DIR=$(pwd)  # 记录当前目录

# 显示菜单
echo "请选择编译方式："
echo "1. x86_64 架构"
echo "2. aarch64 架构"
echo "3. 交叉编译 (x86_64 到 aarch64)"
echo "4. 交叉编译 (x86_64 到 arm-rockchip830-linux-uclibcgnueabihf)"
echo "7. 清理构建目录"
read -p "请输入选项 (1/2/3/4/7): " choice

# 选择对应的架构参数
declare -A ARCH_MAP=(
    [1]="build_x86_64:x86_64:"
    [2]="build_aarch64:aarch64:"
    [3]="build_cross_aarch64:aarch64:-DCMAKE_TOOLCHAIN_FILE=$BASE_DIR/toolchains/aarch64-linux-gnu.toolchain.cmake"
    [4]="build_cross_arm-rockchip830-linux-uclibcgnueabihf:rv1106:-DCMAKE_TOOLCHAIN_FILE=$BASE_DIR/toolchains/arm-rockchip830-linux-uclibcgnueabihf.toolchain.cmake"
)

if [[ "$choice" == "7" ]]; then
    echo "清理构建目录..."
    rm -rf build_* install
    echo "清理完成！"
    exit 0
elif [[ -z "${ARCH_MAP[$choice]}" ]]; then
    echo "无效选项，退出脚本。"
    exit 1
fi

# 解析对应的变量
IFS=':' read -r BUILD_DIR LIB_ARCH  TOOLCHAIN <<< "${ARCH_MAP[$choice]}"
echo "选择架构: $LIB_ARCH , 构建目录: $BUILD_DIR"

# 创建构建目录
mkdir -p "$BASE_DIR/$BUILD_DIR"
cd "$BASE_DIR/$BUILD_DIR"

# 调试信息
echo "CMakeLists.txt 路径: $BASE_DIR"
# 运行 CMake 配置
cmake $TOOLCHAIN \
    -DCMAKE_INSTALL_PREFIX="$BASE_DIR/install" \
    -DOpenCV_DIR="$BASE_DIR/opencv_lib/$LIB_ARCH /lib/cmake/opencv4" \
    -Dncnn_DIR="$BASE_DIR/ncnn_lib/$LIB_ARCH /lib/cmake/ncnn" \
    -DLIB_ARCH="$LIB_ARCH" \
    "$BASE_DIR"

# 编译并安装
make -j$(nproc)
make install

# 安装库文件
# echo "安装库文件到 install/lib..."
# mkdir -p "$BASE_DIR/install/lib"
# cp -r "$BASE_DIR/opencv_lib/$LIB_DIR/lib/"*.so* "$BASE_DIR/install/lib"
# cp -r "$BASE_DIR/ncnn_lib/$LIB_DIR/lib/"*.so* "$BASE_DIR/install/lib"

# # 安装脚本文件
# echo "安装脚本文件到 install..."
# mkdir -p "$BASE_DIR/install"
# cp "$BASE_DIR/scripts/run_test.sh" "$BASE_DIR/install"
# chmod +x "$BASE_DIR/install/run_test.sh"

# # 安装模型文件
# echo "安装模型文件到 install/model..."
# mkdir -p "$BASE_DIR/install/model"
# cp "$BASE_DIR/model/"* "$BASE_DIR/install/model"

echo "编译和安装完成！"
