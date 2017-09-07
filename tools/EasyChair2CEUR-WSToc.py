# EasyChair2CEUR-WSToc
# Extracts list of authors, title and submission number for each submission
# in a EasyChair Conference and outputs an XML file that can be used by the
# CEUR-WS scripts
#
# Usage:
# 1) right click and download the html for the List of Submission page from
#    easychair.org into (for example) ListOfSubmissions.html
# 2) run:
#    python EasyChair2CEUR-WSToc.py ListOfSubmissions.html > toc.xml
#
# Note: in case of multiple authors, the final " and" is substituted with a ","
#   to comply with the LaTeXProceedings class.
#
# (C) 2017, Giampiero Salvi <giampi@kth.se>
from bs4 import BeautifulSoup
import sys
import re

htmlFileName = sys.argv[1]

with open(htmlFileName, 'r') as f:
    htmlpage=f.read()
# parse the whole page
soupObj = BeautifulSoup(htmlpage, "lxml")
# read submission table
table = soupObj.find("table", attrs={"class":"ct_table"})
# get headings
headings = [th.get_text() for th in table.find("tr").find_all("th")]
# Get indexes for relevant columns
subnridx = headings.index("#")
authorsidx = headings.index("Authors")
titleidx = headings.index("Title")
decisionidx = headings.index("Decisions")
# get data row by row
print('<toc>')
#print("    <session>")
#print("        <title></title>")
for row in table.find_all("tr")[1:]:
    elements = [td.get_text() for td in row.find_all("td")]
    if elements[decisionidx] != 'ACCEPT':
        continue
    print('    <paper>')
    print('        <title>'+elements[titleidx]+'</title>')
    print('        <pages from="" to=""/>')
    print('        <authors>')
    clearnauthors = re.sub('<[^>]*>', '', elements[authorsidx])
    for author in re.split(' and |, ', clearnauthors):
        print('            <author>'+author+'</author>')
    print('        </authors>')
    print("    </paper>")

#print("    </session>")
print('</toc>')
