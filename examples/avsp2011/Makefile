# Copyright 2011-2017, Giampiero Salvi <giampi@kth.se>
TGT1 = avsp2011_proc_print
TGT2 = avsp2011_proc_usb

all: ${TGT1}.pdf ${TGT2}.pdf

%.pdf: %.tex papers.tex
	pdflatex ${*}
	./authorindex ${*}
	pdflatex ${*}
	pdflatex ${*}

clean:
	rm -f ${TGT1}.pdf ${TGT1}.aux ${TGT1}.idx ${TGT1}.log ${TGT1}.toc ${TGT1}.ain
	rm -f ${TGT2}.pdf ${TGT2}.aux ${TGT2}.idx ${TGT2}.log ${TGT2}.toc ${TGT2}.ain

