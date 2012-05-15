# Copyright 2011-2012, Giampiero Salvi <giampi@kth.se>
TGT1 = avsp2011_proc_print
TGT2 = avsp2011_proc_usb

all: ${TGT1}.pdf ${TGT2}.pdf

papers.tex: avsp2011.csv
	cat $< | gawk 'BEGIN {FS=";"} {printf("\\includepaper{%s}{%s}{articles/avsp11_submission_%s}\n", $$2, $$3, $$1)}' | sed 's/{\"/{/g' | sed 's/\"}/}/g' > $@ 


avsp2011_proc_%.pdf: avsp2011_proc_%.tex main.tex papers.tex keynote_sverre/keynote_sverre.tex keynote_colm/keynote_colm.tex
	make -C keynote_sverre
	make -C keynote_colm
	pdflatex avsp2011_proc_${*}
	./authorindex avsp2011_proc_${*}
	pdflatex avsp2011_proc_${*}
	pdflatex avsp2011_proc_${*}

clean:
	make -C keynote_sverre clean
	make -C keynote_colm clean
	rm -f ${TGT1}.pdf ${TGT1}.aux ${TGT1}.idx ${TGT1}.log ${TGT1}.toc ${TGT1}.ain
	rm -f ${TGT2}.pdf ${TGT2}.aux ${TGT2}.idx ${TGT2}.log ${TGT2}.toc ${TGT2}.ain
