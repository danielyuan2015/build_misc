###
 # @2019 © Honeywell BCC Scanning Team
 # @Author: Daniel yuan(H138744)
 # @Date: 2020-02-13 22:12:22
 # @LastEditTime : 2020-02-14 00:24:51
 # @LastEditors  : Daniel yuan(H138744)
 # @FilePath: /home/daniel/workspace/git/boost/original/boost_1_72_0/build.sh
 ###
#/bin/sh
TOOLCHAIN_SYSROOT=/home/daniel/workspace/imx8mq/sysroots

ROOT_PATH=/home/daniel/workspace/git/boost/original/boost_1_72_0
OUT_IMAGE_PATH=$ROOT_PATH/imx8m_image/usr
OUT_TEMP_PATH=$ROOT_PATH/imx8m_temp

# BJAM_TOOLS   = "--ignore-site-config \
# 		'-sTOOLS=gcc' \
# 		'-sGCC=${CC} '${BJAM_CONF} \
# 		'-sGXX=${CXX} '${BJAM_CONF} \
# 		'-sGCC_INCLUDE_DIRECTORY=${STAGING_INCDIR}' \
# 		'-sGCC_STDLIB_DIRECTORY=${STAGING_LIBDIR}' \
# 		'-sBUILD=release <optimization>space <threading>multi <inlining>on <debug-symbols>off' \
# 		'-sPYTHON_ROOT=${PYTHON_ROOT}' \
# 		'--layout=system' \
# 		"

#with python3
#'-sPYTHON_ROOT=/home/daniel/workspace/yocto/imx-yocto-bsp-41498-200ga/build-xwayland/tmp/work/aarch64-poky-linux/python3/3.5.5-r1.0/image//usr' seems useless
do_compile() {
	./install_8m/bin/b2 -j8 -d+2 -q 		--ignore-site-config 		'-sTOOLS=gcc' 		'-sGCC=aarch64-poky-linux-gcc  -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed --sysroot=/home/daniel/workspace/imx8mq/sysroots/aarch64-poky-linux '"'-DBOOST_PLATFORM_CONFIG=\"boost/config/platform/linux.hpp\"'" 		'-sGXX=aarch64-poky-linux-g++  -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed --sysroot=/home/daniel/workspace/imx8mq/sysroots/aarch64-poky-linux '"'-DBOOST_PLATFORM_CONFIG=\"boost/config/platform/linux.hpp\"'" 		'-sGCC_INCLUDE_DIRECTORY=/home/daniel/workspace/imx8mq/sysroots/aarch64-poky-linux/usr/include' 		'-sGCC_STDLIB_DIRECTORY=/home/daniel/workspace/imx8mq/sysroots/aarch64-poky-linux/usr/lib' 		'-sBUILD=release <optimization>space <threading>multi <inlining>on <debug-symbols>off' 		'-sPYTHON_ROOT=/home/daniel/workspace/yocto/imx-yocto-bsp-41498-200ga/build-xwayland/tmp/work/aarch64-poky-linux/python3/3.5.5-r1.0/image//usr' 		'--layout=system' -sBOOST_BUILD_USER_CONFIG=/home/daniel/workspace/git/boost/original/boost_1_72_0/user-config.jam 		--build-dir=/home/daniel/workspace/git/boost/original/boost_1_72_0/build_8m 		 		--disable-icu 		--with-atomic --with-chrono --with-container --with-date_time --with-exception --with-filesystem --with-graph --with-iostreams --with-log --with-math --with-program_options --with-random --with-regex --with-serialization --with-system --with-timer --with-test --with-thread --with-wave --with-locale --with-python --libdir=$OUT_IMAGE_PATH/lib --includedir=$OUT_IMAGE_PATH/include --debug-configuration install
}

do_compile_without_python() {
	./install_8m/bin/b2 -j8 -d+2 -q 		--ignore-site-config 		'-sTOOLS=gcc' 		'-sGCC=aarch64-poky-linux-gcc  -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed --sysroot='$TOOLCHAIN_SYSROOT' '"'-DBOOST_PLATFORM_CONFIG=\"boost/config/platform/linux.hpp\"'" 		'-sGXX=aarch64-poky-linux-g++  -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed --sysroot='$TOOLCHAIN_SYSROOT' '"'-DBOOST_PLATFORM_CONFIG=\"boost/config/platform/linux.hpp\"'" 		'-sGCC_INCLUDE_DIRECTORY=/home/daniel/workspace/imx8mq/sysroots/aarch64-poky-linux/usr/include' 		'-sGCC_STDLIB_DIRECTORY=/home/daniel/workspace/imx8mq/sysroots/aarch64-poky-linux/usr/lib' 		'-sBUILD=release <optimization>space <threading>multi <inlining>on <debug-symbols>off' 		 		'--layout=system' -sBOOST_BUILD_USER_CONFIG=$ROOT_PATH/user-config.jam 		--build-dir=$OUT_TEMP_PATH 		 		--disable-icu 		--with-atomic --with-chrono --with-container --with-date_time --with-exception --with-filesystem --with-graph --with-iostreams --with-log --with-math --with-program_options --with-random --with-regex --with-serialization --with-system --with-timer --with-test --with-thread --with-wave --with-locale --libdir=$OUT_IMAGE_PATH/lib --includedir=$OUT_IMAGE_PATH/include  install
}

#configure
#Go to the directory tools/build/.
#Run bootstrap.sh
#Run b2 install --prefix=PREFIX where PREFIX is the directory where you want Boost.Build to be installed
#Add PREFIX/bin to your PATH environment variable.
do_configure() {
#echo 'using gcc : 4.3.1 : aarch64-poky-linux-g++  -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed --sysroot=/home/daniel/workspace/imx8mq/sysroots : <cflags>" -O2 -pipe -g -feliminate-unused-debug-types " <cxxflags>" -O2 -pipe -g -feliminate-unused-debug-types -fvisibility-inlines-hidden" <linkflags>"-Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed" ;' >> ./user-config-daniel.jam

CC="gcc " CFLAGS="-i/usr/include -O2 -pipe" ./bootstrap.sh --with-bjam=bjam --with-toolset=gcc

# Boost can't be trusted to find Python on it's own, so remove any mention
# of it from the boost configuration
sed -i '/using python/d' ./project-config.jam
}

echo "hello world"
#step 1 do_configure
#step 2
do_compile
# do_compile_without_python
