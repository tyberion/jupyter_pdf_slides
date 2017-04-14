#!/bin/bash

IPYNB_FILE=$1
THEME=$2
COLORTHEME=$3
LOGO=$4

IPYNB_NAME=$( echo $IPYNB_FILE | sed "s/\.ipynb//g" )

cd /convert
jupyter-nbconvert --to markdown /to_convert/$IPYNB_FILE --template slides --output=/tmp/converted.md

grep -v '^    $' /tmp/converted.md > /tmp/converted_tmp.md
# Delete all leading blank lines at top of file (only).
sed '/./,$!d' /tmp/converted_tmp.md > /tmp/converted.md
# Delete all trailing blank lines at end of file (only).
#sed -e :a -e '/^\n*$/{$d;N;};/\n$/ba' /tmp/converted_tmp2.md > /tmp/converted.md

if [ $LOGO != - ]; then
    cat /convert/header.tex | sed "s/LOGO/$LOGO/g" > /tmp/header.tex
    cp /to_convert/$LOGO /tmp/$LOGO
else
    cat /convert/header.tex | grep -v LOGO > /tmp/header.tex
fi

pandoc -s -H /tmp/header.tex -V theme=$THEME -V colortheme=$COLORTHEME -t beamer /tmp/converted.md -o /tmp/converted.tex



for SVGFILE in $( ls /tmp/*.svg ); do
    PDFFILE=$( echo $SVGFILE | sed "s/\.svg/\.pdf/g" )
    inkscape -z -A $PDFFILE $SVGFILE
done

cat /tmp/converted.tex | grep -v caption{svg} | sed "s/\.svg/\.pdf/g" > /tmp/converted_tmp.tex
cat /tmp/converted_tmp.tex | sed "/\\\logo/b; s/includegraphics/includegraphics[width=0.8\\\textwidth,height=0.7\\\textheight,keepaspectratio]/g" > /tmp/converted.tex

cd /
pdflatex --output-directory=/tmp /tmp/converted.tex

cp /tmp/converted.tex /to_convert/$IPYNB_NAME.tex
cp /tmp/converted.md /to_convert/$IPYNB_NAME.md

cp /tmp/converted.pdf /to_convert/$IPYNB_NAME.pdf
