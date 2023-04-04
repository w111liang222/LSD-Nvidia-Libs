#!/bin/bash -e

unzip opencv/lib/libopencv_cudafilters.so.4.5.5.zip

# spdlog
cd spdlog
mkdir -p build && cd build && cmake .. && make -j && sudo make install

# protobuf
cd ../../protobuf
./autogen.sh
./configure
make -j6
sudo make install
sudo ldconfig

# Eigen
cd ../Eigen
sudo rm -rf /usr/include/eigen3/Eigen
sudo cp -r Eigen /usr/include/eigen3/

# Ceres
cd ../Ceres
sudo rm -rf /usr/include/ceres
sudo rm -rf /usr/lib/libceres*
sudo rm -rf /usr/lib/cmake/Ceres
sudo cp -r include/ceres /usr/include/
sudo cp -d lib/* /usr/lib/
sudo cp -r modules/Ceres /usr/lib/cmake/

# NLOPT
cd ..
sudo dpkg -i ./libnlopt0_2.4.2+dfsg-4_arm64.deb
sudo dpkg -i ./libnlopt-dev_2.4.2+dfsg-4_arm64.deb

# G2O
cd g2o
sudo cp -r include/g2o /usr/local/include/
sudo cp -r lib/libg2o_* /usr/local/lib/

# OpenCV
sudo apt remove libopencv-samples
sudo rm -rf /usr/bin/opencv_*
sudo rm -rf /usr/include/opencv4
sudo rm -rf /usr/lib/aarch64-linux-gnu/libopencv_*
sudo rm -rf /usr/lib/python3.8/dist-packages/cv2
cd ../opencv
sudo cp -r share/opencv4  /usr/local/share/
sudo cp -r cv2 /usr/lib/python3.8/dist-packages/
sudo cp -d lib/libopencv_* /usr/local/lib/
sudo cp -r cmake/opencv4 /usr/local/lib/cmake/
sudo cp -r include/opencv4 /usr/local/include/

# PCL
cd ../pcl
sudo cp mm_malloc.h /usr/include/
sudo cp -r include/pcl-1.9 /usr/local/include/
sudo cp -d lib/* /usr/local/lib/
sudo cp -r share/pcl-1.9 /usr/local/share/

sudo ldconfig
