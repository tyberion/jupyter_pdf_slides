#!/bin/bash

IPYNB_FILE=$1
THEME=$2
COLORTHEME=$3
LOGO=$4
LOGO_SIZE=$5
GEOMETRY=$6

# check if a custom theme exists
if [ -f /convert/beamertheme$THEME.sty ]; then
    cp /convert/beamertheme$THEME.sty /tmp
fi

# remove extension from file
IPYNB_NAME=$( echo $IPYNB_FILE | sed "s/\.ipynb//g" )

# convert the notebook to markdown
jupyter-nbconvert --to markdown /to_convert/$IPYNB_FILE --template /convert/slides --output=/tmp/converted.md

# clean the markdown file
# remove any line with just four spaces
grep -v '^    $' /tmp/converted.md > /tmp/converted_tmp.md
# Delete all leading blank lines at top of file (only).
sed '/./,$!d' /tmp/converted_tmp.md > /tmp/converted.md
# Delete all trailing blank lines at end of file (only).
#sed -e :a -e '/^\n*$/{$d;N;};/\n$/ba' /tmp/converted_tmp2.md > /tmp/converted.md

if [ $LOGO != - ]; then
    # add the logo file to the header and copy it to /tmp
    cat /convert/header.tex | sed "s/__LOGO__/$LOGO/g" | sed "s/__LOGO_SIZE__/$LOGO_SIZE/g" > /tmp/header.tex
    cp /to_convert/$LOGO /tmp/$LOGO
else
    # no logo, remove from header
    cat /convert/header.tex | grep -v LOGO > /tmp/header.tex
fi

# convert the markdown to beamer latex
pandoc -s -H /tmp/header.tex -V theme=$THEME -V classoption=aspectratio=$GEOMETRY -V colortheme=$COLORTHEME -t beamer /tmp/converted.md -o /tmp/converted.tex

# make sure the graphics have the right size and extension
cat /tmp/converted.tex | grep -v caption{svg} | sed "s/\.svg/\.pdf/g" > /tmp/converted_tmp.tex
cat /tmp/converted_tmp.tex | sed "/\\\logo/b; s/includegraphics/includegraphics[width=0.8\\\textwidth,height=0.7\\\textheight,keepaspectratio]/g" > /tmp/converted.tex

# convert all the svg files to pdf using inkscape
for SVGFILE in $( ls /tmp/*.svg ); do
    PDFFILE=$( echo $SVGFILE | sed "s/\.svg/\.pdf/g" )
    inkscape -z -A $PDFFILE $SVGFILE
done

# convert the latex file to pdf
cd /
pdflatex --output-directory=/tmp /tmp/converted.tex

# cp /tmp/converted.tex /to_convert/$IPYNB_NAME.tex
# cp /tmp/converted.md /to_convert/$IPYNB_NAME.md

# copy the result to the directory containing the ipython notebook file
cp /tmp/converted.pdf /to_convert/$IPYNB_NAME.pdf
