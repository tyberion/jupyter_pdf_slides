# Convert Jupyter slides to pdf

A dockerfile and scripts to convert a jupyter notebook to pdf (latex beamer) slides.

It uses the metadata values from the slides view of jupyter notebook and (if it is installed)
the metadata from the hide_code jupyter notebook plugin.

To assure nice images plot them to svg so use the following in your notebook:

    %matplotlib inline
    %config InlineBackend.figure_format = 'svg'

To convert the notebook run:

    convert.sh [-t beamer_template] [-c beamer_color_theme ] [ipynb_directory] [ipynb_filename]

To view the available beamer themes and colors see:

http://deic.uab.es/~iblanes/beamer_gallery/index.html
