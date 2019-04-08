% sybook is built by Ran Wang
% Email: ranwang.osbert@outlook.com

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sybook}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\newif\ifgeobook@customfont
\newif\ifgeobook@overleaf
\DeclareOption{customfont}{\geobook@customfonttrue}
\DeclareOption{systemfont}{\geobook@customfontfalse}
\DeclareOption{overleaf}{\geobook@overleaftrue}
\ExecuteOptions{systemfont}
\ProcessOptions\relax
% -- overleaf 上默认的 fandol 中文字体经常缺字，因此设定缺字处理手段 --
\ifgeobook@customfont\else
  \ifgeobook@overleaf
    \PassOptionsToPackage{AutoFallBack=true}{xeCJK}
  \fi
\fi
\LoadClass{ctexbook}

\newcommand{\chapternamebox}[1]{%
  \parbox{\ccwd}{\linespread{1}\selectfont\centering #1}%
}
\ctexset{
  part/pagestyle = empty,
  chapter = {
    beforeskip = 0pt,
    fixskip = true,
    format = \huge\bfseries,
    nameformat = \rule{\linewidth}{1bp}\par\bigskip\hfill\chapternamebox,
    number = \arabic{chapter},
    aftername = \par\medskip,
    aftertitle = \par\bigskip\nointerlineskip\rule{\linewidth}{1bp}\par,
    pagestyle = empty,
  },
  section = {
    format = \Large\bfseries\raggedright
  }
}

\RequirePackage[
  a4paper,
  inner   = 1in,
  outer   = 1.25in,
  vmargin = 1in
]{geometry}

\RequirePackage{fancyhdr}
\fancyhf{}
\fancyhead[RO]{\rightmark}
\fancyhead[LE]{\leftmark}
\fancyfoot[LE,RO]{--\ \thepage\ --}
\pagestyle{fancy}
\renewcommand\sectionmark[1]{\markright{#1}}

\RequirePackage{ifxetex}
\RequireXeTeX
\ifxetex
\else
\ClassError{ctexbook}{Use `xelatex' driver}{%
  Choose `xelatex' driver or contact ranwang.osbert@outlook.com%
}
\fi

\ifgeobook@customfont
\setCJKmainfont{Source Han Serif SC}[
UprightFont    = *-Regular,
BoldFont       = *-Bold,
ItalicFont     = *-Regular,
BoldItalicFont = *-Bold
]
\setCJKsansfont{Source Han Sans SC}[
UprightFont    = *-Medium,
BoldFont       = *-Bold,
ItalicFont     = *-Medium,
BoldItalicFont = *-Bold
]
\setCJKmonofont{Source Han Sans SC}[
UprightFont    = *-Light,
BoldFont       = *-Medium,
AutoFakeSlant  = 0.2
]
\else
% -- overleaf 上默认的 fandol 中文字体缺字时，引 Noto Sans CJK SC 字体补充 --
  \ifgeobook@overleaf
    \setCJKfallbackfamilyfont{\CJKrmdefault}[Scale=0.92]{Noto Sans CJK SC}
  \fi
\fi

\RequirePackage[%
  colorlinks,
  pdfstartview = FitH]{hyperref}
  
\RequirePackage{pgfornament-han}
\RequirePackage{cncolours}

\renewcommand{\and}{\\[0.5\ccwd]}
\renewcommand{\maketitle}
{
  \begin{titlepage}
    \thispagestyle{empty}
    \pagestyle{empty}
    \vspace*{0.2\textheight}
    \makebox[0.5\linewidth][s]{\Huge\bfseries\@title}
    \par
    \hfill
    \begin{tikzpicture}
      \node (A) at (2,1) {\pgfornamenthan[scale=0.18,symmetry=v]{10}};
      \node at (0,0) {\begin{minipage}[t]{0.25\linewidth}\large\@author\end{minipage}};
    \end{tikzpicture}
    \newpage
    \thispagestyle{empty}
  \end{titlepage}
}