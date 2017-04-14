#!/bin/bash
PROGNAME=$0
THEME=default
COLORTHEME=default
LOGO='-'

function usage () {
   cat <<EOF
Usage: $PROGNAME [-t beamer_template] [-c beamer_color_theme ] [-l logo_image] [ipynb_directory] [ipynb_filename]
EOF
   exit 0
}

while getopts ":t:c:l:h" OPT; do
   case $OPT in

   t )  THEME=$OPTARG ;;
   c )  COLORTHEME=$OPTARG ;;
   l )  LOGO=$OPTARG ;;
   h )  usage ;;
   \?)  usage ;;
   esac
done

shift $(($OPTIND - 1))

IPYNB_DIR=$1
IPYNB_FILE=$2

# build the docker image
docker build -t pdf_slides .

# run the image and mount the jupyter_pdf_slides directory to /convert and the directory containing the notebook to /to_convert
docker run --rm -v $( pwd ):/convert -v $IPYNB_DIR:/to_convert pdf_slides /bin/bash /convert/convert_notebook.sh $IPYNB_FILE $THEME $COLORTHEME $LOGO
