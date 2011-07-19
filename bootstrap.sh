#!/bin/sh

PATCH_DIR=patches

PACKAGE_DIR=packages
SDK_PACKAGE=SDK.UBNT.v3.6.1.4873.tar.bz2
SDK_URL=http://www.ubnt.com/downloads/firmwares/XS-fw/v3.6.1/$SDK_PACKAGE

mkdir -p $PACKAGE_DIR && cd $PACKAGE_DIR
curl -O -z $SDK_PACKAGE $SDK_URL
cd ..

echo "Unpacking SDK tarball..."
tar -xj --strip-components=1 -f $PACKAGE_DIR/$SDK_PACKAGE


echo 
echo "Applying patches from $PATCH_DIR"
echo

for filename in $PATCH_DIR/*.patch
do
   patch -p1 < $filename
done;

echo
echo "Edit conf/xs2/product.mk to specify which packages to build"
echo "Then \"make clean xs2\" to build for xs products (Ministation2, etc)"
echo



