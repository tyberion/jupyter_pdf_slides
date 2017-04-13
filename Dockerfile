FROM continuumio/miniconda3

RUN conda install nbconvert pandoc

RUN apt-get update && apt-get install -y texlive texlive-latex-recommended texlive-latex-extra inkscape
