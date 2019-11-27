#!/bin/bash

INSTALLED_FONTS=`fc-list : family style file spacing | grep -i fura`

if [ -z $INSTALLED_FONTS ] || [ $2 == "force" ]; then

  FONT_DOWNLOAD_URL='https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/FiraCode.zip'
  TMP_WORKDIR=`mktemp -d`
  TMP_ZIP=font.zip

  cd $TMP_WORKDIR
  wget -O $TMP_ZIP $FONT_DOWNLOAD_URL
  unzip $TMP_ZIP
  rm *.ttf
  rm *Windows*

  INSTALLED_FONTS=( $INSTALLED_FONTS )
  for old_font in "$INSTALLED_FONTS[@]"; do
    rm -f "$old_font"
  done
  mv *.otf ~/.fonts/
  fc-cache -rv

fi

