% geobook is built by Ran Wang
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

\renewcommand{\maketitle}{
  \thispagestyle{empty}
  \vspace*{0.2\textheight}
  \pgfornamenthan[color=雪青,width=1.5cm]{14}\par
  {\Huge\bfseries\@title}
  
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

\RequirePackage{unicode-math}

\ifgeobook@customfont
\setmainfont{libertinusserif}[
  Extension      = .otf,
  UprightFont    = *-regular,
  BoldFont       = *-bold,
  ItalicFont     = *-italic,
  BoldItalicFont = *-bolditalic
]
\setsansfont{Roboto}[
  Extension      = .ttf,
  UprightFont    = *-Regular,
  BoldFont       = *-Bold,
  ItalicFont     = *-Italic,
  BoldItalicFont = *-BoldItalic
]
\setmonofont{cmun}[
  Extension   = .otf,
  UprightFont = *btl,
  BoldFont    = *tb,
  SlantedFont = *bto,
  HyphenChar  = None
]
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
\setmathfont{Libertinus Math}
\else
% -- overleaf 上默认的 fandol 中文字体缺字时，引 Noto Sans CJK SC 字体补充 --
  \ifgeobook@overleaf
    \setCJKfallbackfamilyfont{\CJKrmdefault}[Scale=0.92]{Noto Sans CJK SC}
  \fi
\fi

\RequirePackage{pgfornament-han,cncolours}

\RequirePackage[%
  colorlinks,
  pdfstartview = FitH,
  citecolor    = blue]{hyperref}
