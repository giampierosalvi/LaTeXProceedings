# Copyright 2011-2017, Giampiero Salvi <giampi@kth.se>

TGT = glu2017

all: ${TGT}.pdf

keynotes:
	make -C keynotes

${TGT}.pdf: ${TGT}.tex papers.tex confproc.cls keynotes
	pdflatex ${TGT}
	tools/authorindex ${TGT}
	pdflatex ${TGT}
	pdflatex ${TGT}

# split proceedings into single papers for publication on ceur-ws.org
ceur: ${TGT}.pdf
	tools/CEUR-WSToc2Papers.py ${TGT}_ceur.xml ${TGT}.pdf glu2017ceur/ceur-ws

clean:
	rm -f ${TGT}.pdf ${TGT}.aux ${TGT}.idx ${TGT}.log ${TGT}.toc ${TGT}.ain

