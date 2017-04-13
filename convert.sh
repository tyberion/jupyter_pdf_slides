#!/bin/bash

docker build -t pdf_slides .
docker run --rm -v $( pwd ):/convert -v $1:/to_convert pdf_slides /bin/bash /convert/convert_notebook.sh $2
