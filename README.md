# Convert Jupyter slides to pdf

A dockerfile and scripts to convert a jupyter notebook to pdf (latex beamer) slides.

It uses the metadata values from the slides view of jupyter notebook (in the sense that
a skipped cell is not shown), and (if it is installed) the metadata from the hide_code 
jupyter notebook plugin to hide the code or output of a cell.

It inserts a new slide after each markdown section or subsection.

The first cell in the example notebook shows how to make a titlepage
(**Note** the empty line at the beginning is required)


To assure nice images plot them to svg so use the following in your notebook:

    %matplotlib inline
    %config InlineBackend.figure_format = 'svg'

To convert the notebook run:

    convert.sh [-t beamer_template] [-c beamer_color_theme] [-l logo_image] [ipynb_directory] [ipynb_filename]

An optional logo can be provided, place it in the ipynb_directory and use the -l option,
at the moment the logo is placed at the bottom left corner of every slide.

To view the available beamer themes and colors see:

http://deic.uab.es/~iblanes/beamer_gallery/index.html

If you want to design your own custom theme use this thread as a starting point:

https://tex.stackexchange.com/questions/146529/design-a-custom-beamer-theme-from-scratch
