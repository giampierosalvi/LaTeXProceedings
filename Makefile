# Copyright 2011-2017, Giampiero Salvi <giampi@kth.se>
#TGT1 = avsp2011_proc_print
#TGT2 = avsp2011_proc_usb

TGT = glu2017

all: ${TGT}.pdf

${TGT}.pdf: ${TGT}.tex papers.tex
	pdflatex ${TGT}
	./authorindex ${TGT}
	pdflatex ${TGT}
	pdflatex ${TGT}

clean:
	rm -f ${TGT}.pdf ${TGT}.aux ${TGT}.idx ${TGT}.log ${TGT}.toc ${TGT}.ain

