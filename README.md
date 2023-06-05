# mpv iOS build scripts

These are build scripts for building [libmpv](https://github.com/mpv-player/mpv), and its dependencies:

- FFmpeg
- libass
- freetype
- harfbuzz
- fribidi
- uchardet

## Configuration

Tested with:

- macOS 10.15.4
- Xcode 11.3.1
- Python 3.10.x (not work with Python 3.11.x)

## Usage

1. Run `./download.sh` to download and unarchive the projects' source;
2. Run `./build-ios.sh -e ENVIRONMENT`, where environment is one of;
3. Run `./lipo-ios.sh` to create fat static libraries from the development and distribution architectures;
4. Run `./all.sh` to `./clean.sh && ./download.sh && ./build.sh`.

`development`: builds x86_64 static libaries, and builds mpv with debug symbols and no optimization.

`distribution`: builds x86_64 and arm64 static libraries, adds bitcode, and adds `-Os` to optimize for size and speed.

To build for tvOS, run `./build-tv.sh` and `./lipo-tv.sh` instead.

Alternatively, run `./build.sh` to build and create fat static libraries for iOS and tvOS from the development and distribution architectures.
