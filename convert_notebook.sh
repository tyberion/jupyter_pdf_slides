#!/bin/bash

cd /convert
jupyter-nbconvert --to markdown /to_convert/$1 --template slides --output=/tmp/converted.md
pandoc -s -V theme=Berlin -H /convert/header.tex -t beamer /tmp/converted.md -o /tmp/converted.tex

cat /tmp/converted.tex | sed "s/includegraphics/includesvg/g" > /tmp/converted_svg.tex

cd /tmp
pdflatex converted_svg.tex

cp /tmp/converted_svg.pdf /to_convert/$1.pdf
