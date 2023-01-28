#!/bin/bash

# Bash Color
green='\033[01;32m'
red='\033[01;31m'
blink_red='\033[05;31m'
restore='\033[0m'

# Resources
KERNEL="Image"

# Build dir
BUILD_DIR="kernel_build"

# Anykernel dir
KERNELFLASHER_DIR="kernel_flasher"

# Zip output dir
ZIP_DIR="zip"

# Kernel output dir
OUT_DIR="out/msm-waipio-cupid-gki/dist"

# Kernel repo dirs
KERNEL_DIR="msm-kernel"

# Kernel Details
BASE_YARPIIN_VER="WHITE.WOLF.CUPID."
VER="ALPHA"
YARPIIN_CUPID_VER="$BASE_YARPIIN_VER$VER"

# Functions

function clean {

    cd $BUILD_DIR
    rm -rf out/
    cd ..

}

function clone_vendor_repo {

    cd $BUILD_DIR
    if [ -d "msm-kernel" ] 
    then
        echo "kernel directory exists... updating..."
        cd $KERNEL_DIR
        git checkout origin main
    cd ../..
    else
        echo "Error: vendor directory does not exists... cloning xiaomeme vendor trees"
        git clone https://github.com/yarpiin/White-Wolf-Xiaomi-Cupid.git msm-kernel
    cd ..
    fi



}

function build_cupid_kernel_dirty {

    cd kernel_build

    export LOCALVERSION=-`echo $YARPIIN_CUPID_VER`
    export KBUILD_BUILD_USER=yarpiin
    export KBUILD_BUILD_HOST=kernel
    export TARGET_PRODUCT=cupid
    export SKIP_MRPROPER=1
    export LTO=thin
    export BUILD_CONFIG=common/build.config.msm.cupid
    export VARIANT=gki

    ./build/build.sh -j12

}

function build_cupid_kernel {

    cd kernel_build

    export LOCALVERSION=-`echo $YARPIIN_CUPID_VER`
    export KBUILD_BUILD_USER=yarpiin
    export KBUILD_BUILD_HOST=kernel
    export TARGET_PRODUCT=cupid
    export LTO=thin
    export BUILD_CONFIG=common/build.config.msm.cupid
    export VARIANT=gki

    ./build/build.sh -j12

}

function make_cupid_zip {
		cd $OUT_DIR
        cp -vr $KERNEL ../../../../$KERNELFLASHER_DIR
        cd ../../../../$KERNELFLASHER_DIR
		zip -r9 `echo $YARPIIN_CUPID_VER`.zip *
		mv  `echo $YARPIIN_CUPID_VER`.zip ../$ZIP_DIR
}

DATE_START=$(date +"%s")

echo -e "${green}"
echo "YARPIIN Kernel Creation Script:"
echo

echo "---------------------------"
echo "Kernel Version: Xiaomi Mi12"
echo "---------------------------"

echo -e "${red}"; echo -e "${blink_red}"; echo "$YARPIIN_VER"; echo -e "${restore}";

echo -e "${green}"
echo "---------------------------"
echo "Building White Wolf Kernel:"
echo "---------------------------"
echo -e "${restore}"

while read -p "Do you want to clean (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		clean
		echo
		echo "All Cleaned now."
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to clone kernel repo (y/n)? " dchoice
do
case "$dchoice" in
	y|Y)
		clone_vendor_repo
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to build MI 12 kernel (y/n)? " dchoice
do
case "$dchoice" in
	y|Y)
		build_cupid_kernel
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to dirty build MI 12 kernel (y/n)? " dchoice
do
case "$dchoice" in
	y|Y)
		build_cupid_kernel_dirty
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to zip Mi12 kernel (y/n)? " dchoice
do
case "$dchoice" in
	y|Y)
		make_cupid_zip
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

echo
echo
echo -e "${green}"
echo "-------------------"
echo "Build Completed in:"
echo "-------------------"
echo -e "${restore}"

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo
