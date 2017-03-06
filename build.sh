#
# Copyright © 2016, "Haneesh Raja" <haneesh.da.rocker@gmail.com>
# Thanks to Vipul Jha "vipuljha08" <vipuljha08@gmail.com>
# Thanks to Kunal Kene "kunalkene1797" <kunalkene1797@gmail.com>
# Thanks to Varun Chitre "varunchitre15" <varunchitre15@gmail.com>
#
# This software is licensed under the terms of the GNU General Public
# License version 2, as published by the Free Software Foundation, and
# may be copied, distributed, and modified under those terms.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# Please maintain this if you use this script or any part of it

# Inits
KERNEL_DIR=$PWD
ZIMAGE=$KERNEL_DIR/arch/arm/boot/zImage
BUILD_START=$(date +"%s")

# Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White
nocol='\033[0m'         # Default

# Exports
export ARCH=arm
export SUBARCH=arm
export KBUILD_BUILD_USER="Chijure"
export KBUILD_BUILD_HOST="Team-Phoenix"
export CROSS_COMPILE=~/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-

# Compilation Scripts
echo
echo ######################################
echo #          Starting Build            #
echo #          Phoenix-Kernel            #
echo ######################################
echo
compile_kernel ()
{
make muse6582_b2l_l_defconfig
make -j8
if ! [ -a $ZIMAGE ];
then
echo -e "$Red Kernel Compilation failed! Please Fix the errors! $nocol"
exit 1
fi
}

# Finalizing Scripts
case $1 in
clean)
make ARCH=arm -j2 clean mrproper
rm -rf include/linux/autoconf.h
rm -rf firmware/synaptics/b2l/PLG387_T021_PR1705825-DS5.5.1.0.1066-10055115.img.*
;;
*)
compile_kernel
;;
esac
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$Yellow Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
