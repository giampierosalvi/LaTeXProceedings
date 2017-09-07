# CEUR-WSToc2Papers.py
# Takes as input an xml file with the table of content and the pdf file with
# the complete proceedings and extracts the single papers so that they can be
# included in the ceur-ws.org website.
#
# Usage:
#    python CEUR-WSToc2Papers.py toc.xml proceedings.pdf destination_dir
#
# (C) 2017, Giampiero Salvi <giampi@kth.se>
from bs4 import BeautifulSoup
from PyPDF2 import PdfFileWriter, PdfFileReader
import sys
import os

preamblepages = 6 # this should be extracted from the pdf somehow

xmlFileName = sys.argv[1]
pdfFileName = sys.argv[2]
destDir = sys.argv[3]

pdfProceedings = PdfFileReader(open(pdfFileName, "rb"))


with open(xmlFileName, 'r') as f:
    xmlpage=f.read()

output = PdfFileWriter()
for pageid in range(preamblepages):
    output.addPage(pdfProceedings.getPage(pageid))
outputFileName = os.path.join(destDir, "GLU2017_frontmatter.pdf")
with open(outputFileName, "wb") as outputStream:
     output.write(outputStream)

soupObj = BeautifulSoup(xmlpage, "lxml")
paperid = 1
for paper in soupObj.toc.findAll("paper"):
    frompage = int(paper.pages["from"])+preamblepages-1
    topage = int(paper.pages["to"])+preamblepages-1
    output = PdfFileWriter()
    for pageid in range(frompage,topage+1):
        output.addPage(pdfProceedings.getPage(pageid))
    outputFileName = os.path.join(destDir, "GLU2017_paper-{:02d}.pdf".format(paperid))
    with open(outputFileName, "wb") as outputStream:
        output.write(outputStream)
    paperid=paperid+1

