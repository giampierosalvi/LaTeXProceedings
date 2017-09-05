# Copyright 2011-2017, Giampiero Salvi <giampi@kth.se>

TGT = glu2017

all: ${TGT}.pdf

keynotes:
	make -C keynotes

${TGT}.pdf: ${TGT}.tex papers.tex confproc.cls keynotes
	pdflatex ${TGT}
	./authorindex ${TGT}
	pdflatex ${TGT}
	pdflatex ${TGT}

clean:
	rm -f ${TGT}.pdf ${TGT}.aux ${TGT}.idx ${TGT}.log ${TGT}.toc ${TGT}.ain

