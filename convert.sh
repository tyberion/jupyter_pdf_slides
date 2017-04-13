#!/bin/bash
PROGNAME=$0
THEME=default
COLORTHEME=default

function usage () {
   cat <<EOF
Usage: $PROGNAME [-t beamer_template] [-c beamer_color_theme ][ipynb_directory] [ipynb_filename]
EOF
   exit 0
}

while getopts ":t:c:h" OPT; do
   case $OPT in

   t )  THEME=$OPTARG ;;
   c )  COLORTHEME=$OPTARG ;;
   h )  usage ;;
   \?)  usage ;;
   esac
done

shift $(($OPTIND - 1))

docker build -t pdf_slides .
docker run --rm -v $( pwd ):/convert -v $1:/to_convert pdf_slides /bin/bash /convert/convert_notebook.sh $2 $THEME $COLORTHEME
