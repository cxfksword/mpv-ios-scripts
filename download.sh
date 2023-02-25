#!/bin/sh -e

# Change to preferred versions
MPV_VERSION="0.34.1"
# https://github.com/mpv-player/mpv
FFMPEG_VERSION="5.0.1"
# http://www.ffmpeg.org/releases/

LIBASS_VERSION="0.15.2"
# https://github.com/libass/libass
FREETYPE_VERSION="2.10.0"
# https://download.savannah.gnu.org/releases/freetype/
HARFBUZZ_VERSION="4.2.1"
# https://github.com/harfbuzz/harfbuzz/releases
FRIBIDI_VERSION="1.0.12"
# https://github.com/fribidi/fribidi/releases

UCHARDET_VERSION="0.0.7"
# https://www.freedesktop.org/software/uchardet/releases 

OPENSSL_VERSION="1.1.1s"
# https://github.com/x2on/OpenSSL-for-iPhone/releases

MPV_URL="https://github.com/mpv-player/mpv/archive/v$MPV_VERSION.tar.gz"
FFMPEG_URL="http://www.ffmpeg.org/releases/ffmpeg-$FFMPEG_VERSION.tar.bz2"
LIBASS_URL="https://github.com/libass/libass/releases/download/$LIBASS_VERSION/libass-$LIBASS_VERSION.tar.gz"
FREETYPE_URL="https://sourceforge.net/projects/freetype/files/freetype2/$FREETYPE_VERSION/freetype-$FREETYPE_VERSION.tar.bz2"
# HARFBUZZ_URL="https://www.freedesktop.org/software/harfbuzz/release/harfbuzz-$HARFBUZZ_VERSION.tar.xz"
HARFBUZZ_URL="https://github.com/harfbuzz/harfbuzz/releases/download/$HARFBUZZ_VERSION/harfbuzz-$HARFBUZZ_VERSION.tar.xz"
FRIBIDI_URL="https://github.com/fribidi/fribidi/releases/download/v$FRIBIDI_VERSION/fribidi-$FRIBIDI_VERSION.tar.xz"
UCHARDET_URL="https://www.freedesktop.org/software/uchardet/releases/uchardet-$UCHARDET_VERSION.tar.xz"
OPENSSL_URL="https://github.com/x2on/OpenSSL-for-iPhone/archive/refs/tags/$OPENSSL_VERSION.tar.gz"

rm -rf src
mkdir -p src downloads
for URL in $OPENSSL_URL $UCHARDET_URL $FREETYPE_URL $HARFBUZZ_URL $FRIBIDI_URL $LIBASS_URL $FFMPEG_URL $MPV_URL; do
	TARNAME=${URL##*/}
    if [ ! -f "downloads/$TARNAME" ]; then
	    curl -f -L -- $URL > downloads/$TARNAME
    fi
    echo "$TARNAME"
    tar xvf downloads/$TARNAME -C src
done

sed -i "s/typedef ptrdiff_t GLsizeiptr;/typedef intptr_t GLsizeiptr;/" ./src/mpv-$MPV_VERSION/video/out/opengl/gl_headers.h;

patch -p0 < mpv-patch.diff
patch -p0 < ffmpeg-patch.diff

echo "\033[1;32mDownloaded: \033[0m\n mpv: $MPV_VERSION \
                            \n FFmpeg: $FFMPEG_VERSION \
                            \n libass: $LIBASS_VERSION \
                            \n freetype: $FREETYPE_VERSION \
                            \n harfbuzz: $HARFBUZZ_VERSION \
                            \n fribidi: $FRIBIDI_VERSION \
                            \n opensll: $OPENSSL_VERSION \
                            \n uchardet: $UCHARDET_VERSION "