#!/bin/bash

destDir="./converted"
version="1.0"

_awk=$(which awk)
_gs=$(which gs)
_magick=$(which magick)
_xargs=$(which xargs)

function showVersion {
  echo $version
}

function showHelp {
  echo
  echo "Convert PDF document to one or multiple JPG files"
  echo "  @author: PMK"
  echo "  @since: 2019/01"
  echo "  @version: ${version}"
  echo "  @license: MIT - https://pmk.mit-license.org"
  echo "  @dependencies: ghostscript >= 9, imagemagick >= 7, awk, xargs"
  echo
  echo "Available commands:"
  echo "  --help      shows this help message"
  echo "  --version   shows version number"
  echo
  echo "Usage:"
  echo "  $0 file.pdf"
  echo
}

function showError {
  echo
  echo "Error: $1."
  showHelp
}

function convertFile {
  echo -n "Converting... $1"
  mkdir -p ${destDir}/${1%.pdf*}
  $_magick $1 -scene 1 ${destDir}/${1%.pdf*}/%02d.jpg
  echo " ...done!"
}

function validateInput {
  if [ ! -f "$1" ]; then
    showError "no file found to convert"
    exit 1
  fi

  if [[ $1 != *.pdf ]]; then
    showError "no PDF file given"
    exit 1
  fi

  convertFile $1
}

function checkDependencies {
  willExit=0

  _magick_version=$($_magick -version | $_xargs | $_awk '{print $3}')
  _magick_version_major=${_magick_version%%\.*}
  if [ "$_magick_version_major" -lt 7 ]; then
    echo "Please install or upgrade ImageMagick to version 7 or newer."
    willExit=1
  fi

  _gs_version=$($_gs --version)
  _gs_version_major=${_gs_version%%\.*}
  if [ "$_gs_version_major" -lt 9 ]; then
    echo "Please install or upgrade GhostScript to version 9 or newer."
    willExit=1
  fi

  if [ $willExit == 1 ]; then exit 1; fi
}

case $1 in
  "--help")
    showHelp
    ;;
  "--version")
    showVersion
    ;;
  *)
    checkDependencies $1
    validateInput $1
    ;;
esac
