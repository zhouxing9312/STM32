#!/bin/sh
echo "start clean..."
make clean
echo "start make..."
make
cp ./target.hex /work/share/ -r
