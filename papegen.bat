@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
::This file should 

ECHO Checking if you have waifu2x-caffe in %cd%\waifu2x-caffe
if exist "%cd%\waifu2x-caffe\waifu2x-caffe.exe" (
    goto :haswf
ECHO You have waifu2x-caffe.
) else goto :dlwf

:dlwf
    ECHO Downloading waifu2x-caffe . . .
    powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://github.com/lltcggie/waifu2x-caffe/releases/download/1.2.0.2/waifu2x-caffe.zip', 'waifu2x-caffe.zip')"
    ::powershell Invoke-WebRequest -Uri "https://github.com/lltcggie/waifu2x-caffe/releases/download/1.2.0.2/waifu2x-caffe.zip" -OutFile "%cd%\waifu2x-caffe.zip"
    powershell Expand-Archive waifu2x-caffe.zip -DestinationPath %cd%
    cls
    ECHO You now have waifu2x-caffe
    del waifu2x-caffe.zip

:haswf
    ECHO Checking if you have imagemagick in %cd%\imagemagick
    if exist "%cd%\imagemagick\mogrify.exe" (
        goto :hasim
    ECHO You have imagemagick.
    ) else goto :dlim

:dlim
    ECHO Downloading imagemagick . . .
    powershell -command "(New-Object System.Net.WebClient).DownloadFile('ftp://ftp.imagemagick.org/pub/ImageMagick/binaries/ImageMagick-7.0.8-56-portable-Q16-x64.zip', 'imagemagick.zip')"
    ::powershell Invoke-WebRequest -Uri "ftp://ftp.imagemagick.org/pub/ImageMagick/binaries/ImageMagick-7.0.8-56-portable-Q16-x64.zip" -OutFile "%cd%\imagemagick.zip"
    powershell Expand-Archive imagemagick.zip -DestinationPath %cd%\imagemagick
    cls
    ECHO You now have imagemagick
    del imagemagick.zip

:hasim
    ECHO Checking if you have an input folder in %cd%\input
    if exist "%cd%\input" (
        goto :hasinput
    ECHO You have an input folder.
    ) else md input

:hasinput
cls
ECHO ! ! ! WARNING ! ! !
ECHO We will need to purge your output folder, if you have one. Please make sure to delete/move all your files in %cd%\output
PAUSE
ECHO Deleting and Creating %cd%\output
del %cd%\output
md output

del %cd%\input\temp
md input\temp

cls
ECHO System check done. You have all the prerequisites :)
PAUSE
cls

ECHO Prelimenary Questions
ECHO ==================================================
ECHO Do you have CUDNN installed?
SET /p cudnn_q=Y/N?
if %cudnn_q% == "Y" SET cudnn_mode=cudnn
if %cudnn_q% == "y" SET cudnn_mode=cudnn
if %cudnn_q% == "N" SET cudnn_mode=cpu
if %cudnn_q% == "n" SET cudnn_mode=cpu
cls

ECHO Do you have wish to use TTA Mode? TTA mode will increase quality but will also increase render time.
SET /p tta_q=Y/N?
if %tta_q% == "Y" SET tta_mode=1
if %tta_q% == "y" SET tta_mode=1
if %tta_q% == "N" SET tta_mode=0
if %tta_q% == "n" SET tta_mode=0
cls

ECHO MAIN MENU
ECHO ==================================================
ECHO Instructions:
ECHO In %cd% you will find an input folder. Copy or save all the images you would like to be resized and cropped to wallpapers in that folder. 
ECHO 1 - Create TALL Wallpapers (1080x1920)
ECHO 2 - Create WIDE Wallpapers (1920x1080)
ECHO 3 - Create HD TALL Wallpapers (1440x2560)
ECHO 4 - Create HD WIDE Wallpapers (2560x1440)
ECHO 5 - Create ALL WIDE Wallpapers (1920x1080 AND 2560x1440)
ECHO 6 - Create ALL TALL Wallpapers (1080x1920 AND 1440x2560)
ECHO 0 - Exit
choice /n /c:0123456 /M "Choose an option (0-6) "

if "%ERRORLEVEL%" == "0" (
    goto prog_exit
)

if "%ERRORLEVEL%" == "1" (
    set img_width=1080
    set img_height=1920
)
if "%ERRORLEVEL%" == "2" (
    set img_width=1920
    set img_height=1080
)
if "%ERRORLEVEL%" == "3" (
    set img_width=2560
    set img_height=1440
)
if "%ERRORLEVEL%" == "4" (
    set img_width=1440
    set img_height=2560
)
if "%ERRORLEVEL%" == "5" (
    set has_extra=1
    set img_width=1920
    set img_height=1080
    set img_width_extra=2560
    set img_height_extra=1440
)
if "%ERRORLEVEL%" == "6" (
    set has_extra=1
    set img_width=1920
    set img_height=1080
    set img_width_extra=1440
    set img_height_extra=2560
)

if %img_tall% == "1" (
    %cd%\waifu2x-caffe\waifu2x-caffe.exe -t %tta_mode% -p %cudnn_mode% -i %cd%\input -o %cd%\input\temp\*.png -h %img_height%
    %cd%\imagemagick\mogrify.exe %cd%\input\temp\*.png -background transparent -gravity center -extent %img_height%x%img_width% -format png *.png
) else (
    %cd%\waifu2x-caffe\waifu2x-caffe.exe -t %tta_mode% -p %cudnn_mode% -i %cd%\input -o %cd%\input\temp\*.png -w %img_width%
    %cd%\imagemagick\mogrify.exe %cd%\input\temp\*.png -background transparent -gravity center -extent %img_height%x%img_width% -format png *.png
)

:prog_exit
del %cd%\input\temp
md input\temp
PAUSE
