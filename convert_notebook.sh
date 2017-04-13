#!/bin/bash

cd /convert
jupyter-nbconvert --to markdown /to_convert/$1 --template slides --output=/tmp/converted.md
pandoc -s -V theme=$2 -V colortheme=$3 -t beamer /tmp/converted.md -o /tmp/converted.tex

for SVGFILE in $( ls /tmp/*.svg ); do
    PDFFILE=$( echo $SVGFILE | sed "s/\.svg/\.pdf/g" )
    inkscape -z -A $PDFFILE $SVGFILE
done

cat /tmp/converted.tex | grep -v caption{svg} | sed "s/\.svg/\.pdf/g" > /tmp/converted_tmp.tex
cat /tmp/converted_tmp.tex | sed "s/includegraphics/includegraphics[width=0.8\\\textwidth,height=0.7\\\textheight,keepaspectratio]/g" > /tmp/converted.tex

cd /
pdflatex --output-directory=/tmp /tmp/converted.tex

# cp /tmp/converted.tex /to_convert/$1.tex

cp /tmp/converted.pdf /to_convert/$1.pdf
