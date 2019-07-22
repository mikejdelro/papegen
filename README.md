# papegen
Wallpaper Resizer/Cropper

## What is it?
Papegen is a batch file that automatically downloads and uses a binary of [Waifu2x-Caffe](https://github.com/lltcggie/waifu2x-caffe) and [ImageMagick](https://github.com/ImageMagick/ImageMagick) to automatically scale and resize images to wallpaper standard resolutions (currently 1920x1080, 1080x1920, 2560x1440 and 1440x2560).

## Requirements
Tested on Windows 10 1803, with PowerShell 10.0.17763.1

nVidia GPU with CUDA and CUDNN installed (if this is not met, will use CPU0)
Refer to this [guide](https://docs.nvidia.com/deeplearning/sdk/cudnn-install/index.html#install-windows) by nVidia to install CUDA and CUDNN.

## Attributions
[Waifu2x-Caffe](https://github.com/lltcggie/waifu2x-caffe)

本ソフトは、画像変換ソフトウェア「[waifu2x](https://github.com/nagadomi/waifu2x)」の変換機能のみを、
[Caffe](http://caffe.berkeleyvision.org/)を用いて書き直し、Windows向けにビルドしたソフトです。
CPUで変換することも出来ますが、CUDA(あるいはcuDNN)を使うとCPUより高速に変換することが出来ます。

ソフトのダウンロードは[こちらのreleasesページ](https://github.com/lltcggie/waifu2x-caffe/releases)の「Downloads」の項で出来ます。

Waifu2x-Caffe uses [Caffe](https://caffe.berkeleyvision.org/); [CUDNN](https://developer.nvidia.com/cudnn) and [Waifu2x](https://github.com/nagadomi/waifu2x)'s existing models to image scale and noise reduce anime and manga style images.

[ImageMagick](https://github.com/ImageMagick/ImageMagick)

Use [ImageMagick®](https://imagemagick.org/) to create, edit, compose, or convert bitmap images. It can read and write images in a variety of formats (over 200) including PNG, JPEG, GIF, HEIC, TIFF, DPX, EXR, WebP, Postscript, PDF, and SVG. Use ImageMagick to resize, flip, mirror, rotate, distort, shear and transform images, adjust image colors, apply various special effects, or draw text, lines, polygons, ellipses and Bézier curves.
