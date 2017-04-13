# jupyter_pdf_slides

A dockerfile and scripts to convert a jupyter notebook to pdf (latex beamer) slides.
It uses the metadata values from the slides view of jupyter notebook and (if it is installed)
the metadata from the hide_code jupyter notebook plugin.
To assure nice images plot them to svg so use:

    %matplotlib inline
    %config InlineBackend.figure_format = 'svg'

in the notebook.

To convert the notebook run:

    convert.sh [directory of ipynb file] [name of ipynb file]
