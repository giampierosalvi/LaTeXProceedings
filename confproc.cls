%% 
%% FILE: confproc.cls
%%
%% USAGE:    \documentclass[a4paper,twoside,12pt]{confproc}
%%
%% PURPOSE: LaTeX2e class file for the Conference Proceedings
%%
%% ADDITIONAL COMMANDS:
%%  \address{} where the conference takes place
%%  \editor{} Name(s) of the editors of the proceedings
%%  \school{} School (University) hosting the conference
%% 
%% Copyright 2011 Giampiero Salvi 
%% 
%% The author is not responsible for the layout definition, but
%% only for its implementation
%% 
%% This system is distributed in the hope that it will be useful, 
%% but WITHOUT ANY WARRANTY; without even the implied warranty of 
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
%% 


\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{confproc}
%\PassOptionsToClass{twocolumn}{article}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass[11pt, twoside, a4paper]{article}
\RequirePackage{fancyhdr}
%\setlength{\headheight}{14.5pt} % because of the superscript in the date
\RequirePackage[inner=2.2cm,outer=1.8cm,top=2.8cm,bottom=3.0cm]{geometry}
\RequirePackage{pdfpages}
\RequirePackage{authorindex}

\newcommand{\address}[1]{\gdef\theaddress{#1}}
\newcommand{\editor}[1]{\gdef\theeditor{#1}}
\newcommand{\school}[1]{\gdef\theschool{#1}}
\newcommand{\isbn}[1]{\gdef\theisbn{#1}}
\newcommand{\issn}[1]{\gdef\theissn{#1}}
\newcommand{\howpublished}[1]{\gdef\thehowpublished{#1}}
\newcommand{\conferencetype}[1]{\gdef\conftype{#1}}

\newcommand{\newevenside}{
        \ifthenelse{\isodd{\thepage}}{\newpage}{
        \newpage
        \phantom{placeholder} % doesn't appear on page
        \thispagestyle{empty} % if want no header/footer
        \newpage
        }
}

%
% Header/footer layout
%
\pagestyle{fancy}
\lhead[\thepage]{GLU 2017, Stockholm, Sweden, Aug 25}
\rhead[GLU 2017, Stockholm, Sweden, Aug 25]{\thepage}
\lfoot{}
\cfoot{}

%
% Included article layout (twoside offset)
%
\includepdfset{offset=2mm 0}

\renewcommand{\maketitle}{\begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks
  \begin{center}%
    \includegraphics[width=0.2\textwidth]{symbols/kth_pms_comp_science_comm}%
    \vfil%
    {\LARGE Proceedings of the \par}%
    {\Huge \conftype{} on\par}%
    {\Huge \@title \par}%
    \vskip 3em%
    {\large
     \lineskip .75em%
    {\large \@date \par}%       % Set date in \large size.
      \vskip 1.5em%
      \begin{tabular}[t]{c}%
        \theaddress
      \end{tabular}\par}%
  \end{center}\par
  \@thanks
  \vfil\null
  \begin{center}
    %\includegraphics[width=0.8\textwidth]{symbols/avsp-logo}
  \end{center}
  \end{titlepage}%
  \newpage
  \thispagestyle{plain}
  \noindent\theeditor\par
  \noindent\theschool\par\vspace{5mm}
  \noindent Proceedings of the \conftype{} on \@title\par\vspace{5mm}
  \noindent ISBN: \theisbn\par
  \noindent ISSN: \theissn\par\vspace{5mm}
  \noindent Published by\par
  \noindent\theschool\par\vspace{5mm}
  \noindent\thehowpublished
  \vfil
  \noindent Copyright \copyright\ 2017 for the individual papers by the papers' authors. Copying permitted for private and academic purposes. This volume is published and copyrighted by its editors.\par
  \vspace{5mm}
  \noindent \LaTeX{} class and proceedings files by Giampiero Salvi\par
  (\url{https://github.com/giampierosalvi/LaTeXProceedings})\par
  \newpage
}

%\def\trim#1{\ignorespaces#1\unskip}
\def\addtoauthorindex#1{%
  \@for\@myauth:=#1\do{\aimention{\@myauth}}}

% New command to add pdf articles run like following:
% \includepaper[offset]{title}{comma_separated_authors}{pdffile}
\newsavebox\mybox
\newcommand{\includepaper}[4][0 0]{%
%  \newevenside
  \cleardoublepage
  \refstepcounter{subsection}\addcontentsline{toc}{subsection}{#2\\\textit{#3}}%
  \addtoauthorindex{#3}
  % this is to get the number of pages in the pdf
  \savebox\mybox{\includegraphics{#4}}
  \ifthenelse{\pdflastximagepages>1}{% pdftex
    %%%\ifthenelse{\numexpr\XeTeXpdfpagecount
    %%%            \XeTeXquote#1\XeTeXquote\relax > 1}{% xete
    % include first page without headers
    \includepdf[offset=#1, pages=1,pagecommand=\thispagestyle{plain}]{#4}%
    % include remaining pages with headers
    \includepdf[offset=#1, pages=2-,pagecommand=\thispagestyle{fancy}]{#4}%
  }{%
    \includepdf[offset=#1, pages=1,pagecommand=\thispagestyle{plain}]{#4}%
  }
}
%\newcommand{\includepaper}[3]{%
%  \addcontentsline{toc}{section}{#1\\\textit{#2}}%
%  \addtoauthorindex{#2}
%  \includepdf[pages=-,pagecommand=\thispagestyle{fancy}]{#3}%
%%  % include first page without headers
%%  \includepdf[pages=1,pagecommand=\thispagestyle{plain}]{#3}
%%  % include remaining pages with headers
%%  \includepdf[pages=2-last,pagecommand=\thispagestyle{fancy}]{#3}%
%}

\endinput
