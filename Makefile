# Copyright 2011-2012, Giampiero Salvi <giampi@kth.se>
TGT1 = avsp2011_proc_print
TGT2 = avsp2011_proc_usb

all: ${TGT1}.pdf ${TGT2}.pdf

avsp2011_proc_%.pdf: avsp2011_proc_%.tex main.tex papers.tex
	pdflatex avsp2011_proc_${*}
	./authorindex avsp2011_proc_${*}
	pdflatex avsp2011_proc_${*}
	pdflatex avsp2011_proc_${*}

clean:
	rm -f ${TGT1}.pdf ${TGT1}.aux ${TGT1}.idx ${TGT1}.log ${TGT1}.toc ${TGT1}.ain
	rm -f ${TGT2}.pdf ${TGT2}.aux ${TGT2}.idx ${TGT2}.log ${TGT2}.toc ${TGT2}.ain
