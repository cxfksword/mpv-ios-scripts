#!/bin/sh -e

LIBRARIES="libuchardet libfribidi libfreetype libharfbuzz libass ffmpeg libmpv libavcodec libavdevice libavfilter libavformat libavutil libswresample libswscale"
ROOT="$(pwd)"
SCRATCH="$ROOT/scratch-ios"
LIB="$ROOT/lib-ios"
mkdir -p $LIB

for LIBRARY in $LIBRARIES; do
    if [[ "$LIBRARY" != "ffmpeg" ]]; then
        lipo -create $SCRATCH/arm64/lib/$LIBRARY.a $SCRATCH/x86_64/lib/$LIBRARY.a -o $LIB/$LIBRARY.a
    fi
done

cp $SCRATCH/x86_64/openssl/lib/libcrypto.a $LIB/libcrypto.a
cp $SCRATCH/x86_64/openssl/lib/libssl.a $LIB/libssl.a
