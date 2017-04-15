# Convert Jupyter slides to pdf

A dockerfile and scripts to convert a jupyter notebook to pdf (latex beamer) slides.

It uses the metadata values from the slides view of jupyter notebook (in the sense that
a skipped cell is not shown), and (if it is installed) the metadata from the hide_code
jupyter notebook plugin to hide the code or output of a cell.

It inserts a new slide after each markdown section or subsection. A markdown section
creates a page with only a title (no content) the markdown subsection allows for content.

The first cell in the example notebook shows how to make a titlepage
(**Note** the empty line at the beginning is required)

To assure nice images plot them to svg so use the following in your notebook:

    %matplotlib inline
    %config InlineBackend.figure_format = 'svg'

To convert the notebook run:

    convert.sh [-t beamer_template] [-c beamer_color_theme ] [-l logo_image] [-s logo_size] [-g slide_geometry] ipynb_directory ipynb_filename

An optional logo can be provided, place it in the ipynb_directory and use the -l option,
the logo is placed at a position given by the beamer theme, the size of the logo can be given by -s for
example -s 3cm gives a logo with a width of 3 cm
The geometry of the slides can be given with the -g option. The possible option values with the geometries
in brackets are:
- 1610 (16:10)
- 169 (16:9)
- 149 (14:9)
- 54 (5:4)
- 43 (4:3)
- 32 (3:2)

To view the available beamer themes and colors see:

http://deic.uab.es/~iblanes/beamer_gallery/index.html

If you want to design your own custom theme use this thread as a starting point:

https://tex.stackexchange.com/questions/146529/design-a-custom-beamer-theme-from-scratch
