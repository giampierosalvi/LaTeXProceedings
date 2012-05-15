TGT = keynote_colm

all: ${TGT}.pdf

%.pdf: %.tex
	pdflatex $*

clean:
	rm -f ${TGT}.pdf ${TGT}.log ${TGT}.aux

