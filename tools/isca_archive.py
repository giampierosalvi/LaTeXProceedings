# python isca_archive.py papers.tex papers.txt sessions.txt
import os
import sys
import re

inputFileName = sys.argv[1]
papersFileName = sys.argv[2]
sessionsFileName = sys.argv[3]

papersFileHandle = open(papersFileName, 'w')
print('id|authors|title', file=papersFileHandle)
sessionsFileHandle = open(sessionsFileName, 'w')
print('title|papers', file=sessionsFileHandle)

with open(inputFileName, 'r') as f:
    rawinput = f.readlines()
    
ids = {}
    
for line in rawinput:
    line = line.rstrip()
    #print(line)
    if '\\begin{proceedingssession}' in line:
        rematch = re.compile(r'\\begin{proceedingssession}{([^}]*)}').match(line)
        if rematch is None:
            print('error: file format mismatch')
            print(line)
            exit
        session = rematch.group(1)
        ids[session] = []
    if '\\includepaper' in line:
        [title, authors, paperid] = line[len('\\includepaper{'):-1].split('}{')
        paperid = re.sub(r'[^/]*/', '', paperid)
        ids[session].append(paperid)
        print('|'.join([paperid, authors, title]), file=papersFileHandle)

for session in ids.keys():
    print(session+'|'+','.join(ids[session]), file=sessionsFileHandle)
