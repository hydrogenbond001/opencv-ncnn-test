# OpenCV 和 NCNN 测试项目

这是一个基于 OpenCV 和 NCNN 的测试项目，用于在 Luckfox Pico 开发板上运行图像处理和神经网络推理。
tips:ncnn会有一下报错，很烦但不影响结果
```
ex.set_num_threads() is no-op, please set net.opt.num_threads=N before net.load_param()
If you want to use single thread for only some layer, see https://github.com/Tencent/ncnn/wiki/layer-feat-mask
```
注释ncnn/src/net.cpp里的void Extractor::set_num_threads(int num_threads)函数内容，就不会输出了

## 项目简介

本项目演示了如何使用 OpenCV 加载图像，并使用 NCNN 进行神经网络推理。代码包括以下功能：
- 使用 OpenCV 读取图像。
- 使用 NCNN 加载模型并进行推理。

## 效果展示
幸狐LuckFox Pico Ultra W上(rv1106)
![幸狐rv1106上效果](https://github.com/hydrogenbond001/opencv-ncnn-test/scripts/001.jpg)

正点原子CA1上(rk3568)
![正点原子CA1上](https://github.com/hydrogenbond001/opencv-ncnn-test/scripts/002.jpg)

x86_linux上(WSL)
![x86_linux上](https://github.com/hydrogenbond001/opencv-ncnn-test/scripts/003.jpg)



## 依赖项

- **OpenCV**: 用于图像处理。
- **NCNN**: 用于神经网络推理。
- **交叉编译工具链**: 用于在 Luckfox Pico 上编译和运行代码。
依赖库都编译好了
## 使用方法

### 1. 克隆项目

```bash
git clone https://github.com/hydrogenbond001/opencv-ncnn-test.git
cd opencv-ncnn-test
./build.sh
选择架构
```
```
@user:/$ ./build.sh 
请选择编译方式：
1. x86_64 架构
2. aarch64 架构
3. 交叉编译 (x86_64 到 aarch64)
4. 交叉编译 (x86_64 到 arm-rockchip830-linux-uclibcgnueabihf)
7. 清理构建目录
请输入选项 (1/2/3/4/7): 
@user:/$ 1

```

adb推到板端
```
adb push install/ /
adb shell
cd /install
chmod 777 ./bin/opencv-ncnn-test
./run_test.sh
```

参考大佬的视频[https://www.bilibili.com/video/BV1WhAKeoESP/]

大佬的链接[https://mp.weixin.qq.com/s/JWgWGavHYSsl7OK_ze6g4w]

chineseocr_lite项目源地址[https://github.com/DayBreak-u/chineseocr_lite.git]

## 许可证

本项目基于 GPL v2 和 BSD 3-Clause 双重许可。