% The class file for the book project 《代数学方法》
% Copyright 2018  李文威 (Wen-Wei Li).
% Permission is granted to copy, distribute and/or modify this
% document under the terms of the Creative Commons
% Attribution 4.0 International (CC BY 4.0)
% http://creativecommons.org/licenses/by/4.0/

% We make use of etoolbox. The package ntheorem is implicitly required.
% It will also import the files titles-setup.tex (for titles of sections) and font-setup-open.tex/font-setup-HEP.tex (for fonts).

% Identification
% --------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{CODEDUMPNOTE}[2024/04/04 ]

% 使用 key-val 格式指定选项之用, 一切以 @CODEDUMPNOTE 起始.
\RequirePackage{kvoptions}
\RequirePackage{etoolbox}

\SetupKeyvalOptions{
    family = @CODEDUMPNOTE,
    prefix = @CODEDUMPNOTE@,
    setkeys=\kvsetkeys
}
\newcommand{\ekv}[1]{\kvsetkeys{@CODEDUMPNOTE}{#1}}
% Declaration of options
% ----------------------
\DeclareBoolOption[false]{draftmark}    % 是否打上未定稿标记
\DeclareBoolOption[true]{colors}    % 是否让链接带颜色
\DeclareBoolOption[true]{CJKthechapter} % 是否让天眉的各章编号使用中文数字
\DeclareBoolOption[false]{traditional}  % 是否使用繁体中文
\DeclareStringOption[]{coverpage}   % 封面档档名, 默认为空
\DeclareStringOption{fontsetup} % 字体设定档档名
\DeclareStringOption{titlesetup}    % 章节标题设定档档名
\DeclareStringOption[b5]{geometry}  % 版面 (默认 b5)
\DeclareBoolOption[false]{fastcompile} % turns off some features for faster compiling

\PassOptionsToPackage{dvipsnames}{xcolor}   % 让 xcolor 带 dvipsnames 选项; tikz 随后会载入之.

% defalut language is cn
\DeclareStringOption[cn]{lang}
\DeclareVoidOption{en}{\ekv{lang=en}}
\DeclareVoidOption{cn}{\ekv{lang=cn}}

% Execution of options
% ---------------------
\ProcessKeyvalOptions*
\relax

% Package loading
% ---------------------
% 基于 book class, 选项一并载入.
\LoadClass[10pt]{book}

\RequirePackage{fontspec}               % XeLaTeX
\RequirePackage[CJKchecksingle]{xeCJK}  % XeCJK
\RequirePackage{CJKnumb}                % 使用 CJK 数字

% 引入 AMS 宏包 + mathtools
\RequirePackage[intlimits]{amsmath}
\RequirePackage{amssymb}
\RequirePackage[centercolon]{mathtools}

% 支持直接引入 PDF 页面
\RequirePackage{pdfpages}

% 加入字串处理功能
\RequirePackage{xstring}

\RequirePackage{emptypage}
\RequirePackage[many]{tcolorbox}        % 制作方框

\RequirePackage{setspace}   % 设定适于中文排版的行距

% 使用 biblatex + biber 制作书目
\RequirePackage[backend=biber, hyperref=auto, backref=true, backrefstyle=three]{biblatex}

% 要求载入 TikZ
\RequirePackage{tikz}

% 载入 paralist
\RequirePackage{paralist}

% Main codes
% ----------

% ------------------------------------------------------------
% 章节设置
% ------------------------------------------------------------
\RequirePackage[center,pagestyles]{titlesec}
\RequirePackage[title,titletoc,header]{appendix}

% ------------------------------------------------------------
% language settings
% ------------------------------------------------------------
\ifdefstring{\@CODEDUMPNOTE@lang}{cn}{
  \renewcommand{\contentsname}{目录}
  \renewcommand{\figurename}{图}
  \renewcommand{\tablename}{表}
  \renewcommand{\partname}{\color{structurecolor}}
  \renewcommand{\thepart}{第\zhnumber{\arabic{part}}部分}
  \renewcommand{\listfigurename}{图片索引}
  \renewcommand{\listtablename}{表格索引}
  \renewcommand{\bibname}{参考文献}
  \newcommand{\ebibname}{参考文献}
  \renewcommand{\appendixname}{附录}
  \renewcommand{\appendixtocname}{附录}
  \renewcommand{\indexname}{索\hspace{2em}引}
  \newcommand\figref[1]{\textbf{图}~\ref{#1}}
  \newcommand\tabref[1]{\textbf{表}~\ref{#1}}
  \newcommand{\authorname}{\citshape 作者：}
  \newcommand{\institutename}{\citshape 组织：}
  \newcommand{\datename}{\citshape 时间：}
  \newcommand{\versionname}{\citshape 版本：}
  \newcommand{\notename}{笔记}
  \newcommand{\proofname}{证明}
  \newcommand{\definitionname}{定义}
  \newcommand{\theoremname}{定理}
  \newcommand{\axiomname}{公理}
  \newcommand{\postulatename}{公设}
  \newcommand{\lemmaname}{引理}
  \newcommand{\propositionname}{命题}
  \newcommand{\corollaryname}{推论}
  \newcommand{\examplename}{例题} %
  \newcommand{\instancename}{示例} %
  \newcommand{\problemname}{问题} % 问题
  \newcommand{\exercisename}{练习} % 练习=习题
  \newcommand{\remarkname}{注}
  \newcommand{\assumptionname}{假设}
  \newcommand{\conclusionname}{结论}
  \newcommand{\solutionname}{解}
  \newcommand{\propertyname}{性质}
  \newcommand{\introductionname}{内容提要}
  \newcommand\bioinfo[2]{\gdef\@bioinfo{{\citshape #1}：#2}}
  \newcommand{\updatename}{更新：}
  \newcommand{\historyname}{版本更新历史}
  \newcommand{\beforechap}{第}
  \newcommand{\afterchap}{章}
}{\relax}

\ifdefstring{\@CODEDUMPNOTE@lang}{en}{
  \setlength\parindent{2em}
  \newcommand\figref[1]{\textbf{Figure}~\ref{#1}}
  \newcommand\tabref[1]{\textbf{Table}~\ref{#1}}
  \renewcommand{\chaptername}{Chapter}
  \renewcommand{\partname}{\color{structurecolor} Part}
  \newcommand{\authorname}{\textbf{Author: }}
  \newcommand{\institutename}{\textbf{Institute: }}
  \newcommand{\datename}{\textbf{Date: }}
  \newcommand{\versionname}{\textbf{Version: }}
  \newcommand{\notename}{Note}
  \newcommand{\proofname}{Proof}
  \newcommand{\problemname}{Problem}
  \newcommand{\definitionname}{Definition}
  \newcommand{\theoremname}{Theorem}
  \newcommand{\axiomname}{Axiom}
  \newcommand{\postulatename}{Postulate}
  \newcommand{\lemmaname}{Lemma}
  \newcommand{\propositionname}{Proposition}
  \newcommand{\corollaryname}{Corollary}
  \newcommand{\examplename}{Example}
  \newcommand{\exercisename}{Exercise}
  \newcommand{\remarkname}{Remark}
  \newcommand{\assumptionname}{Assumption}
  \newcommand{\conclusionname}{Conclusion}
  \newcommand{\solutionname}{Solution}
  \newcommand{\propertyname}{Property}
  \newcommand{\introductionname}{Introduction}
  \renewcommand{\appendixname}{Appendix}
  \newcommand{\ebibname}{Bibliography}
  % \newcommand{\problemsetname}{Exercise}
  \newcommand\bioinfo[2]{\gdef\@bioinfo{\textbf{#1}: #2}}
  \newcommand{\updatename}{Updates:}
  \newcommand{\historyname}{Version History}
}{\relax}
% ------------------------------------------------------------
\usetikzlibrary{shapes.symbols} % 稍后定义 hint 环境所需

% 定义在 draftmark=true 模式下显示版本信息的指令
\RequirePackage[iso, english]{isodate}  % 使 \today 印出 yyyy-mm-dd
\providecommand{\@CODEDUMPNOTE@draftstring}{{\color{gray!40}\heiti 未定稿: \today}}

\onehalfspacing % 行距
%\raggedbottom  % 减小页面空白

\setlength{\parindent}{2em} % 设置适合于汉语排版的段落缩进

% 扩展 \frontmatter: 制作封面和目录
\g@addto@macro\frontmatter{
    % 当 coverpage 参数非空时, 引入封面档制作封面, 否则 \relax.
    \ifdefempty{\@CODEDUMPNOTE@coverpage}{%
        \relax
    }{%
        \pagestyle{empty}%  清空页面风格
        \renewcommand{\thepage}{C\arabic{page}}%    封面部分页码以 C 开头 (PDF: logical page numbers)
        \IfEndWith{\@CODEDUMPNOTE@coverpage}{.pdf}{% 如果档名以 .pdf 或 .PDF 结尾则引入 PDF
            \includepdf{\@CODEDUMPNOTE@coverpage}
        }{%
            \IfEndWith{\@CODEDUMPNOTE@coverpage}{.PDF}{%
                \includepdf{\@CODEDUMPNOTE@coverpage}
            }{%
                \input{\@CODEDUMPNOTE@coverpage}      % 否则引入 .tex 源代码
            }
        }%
        \pagestyle{fancy}       % 复原页面风格为 fancy
        \pagenumbering{roman}   % 页码复原为小写罗马字母
    }

    % 重设页数: 封面页结束时应已经 \cleardoublepage
    \setcounter{page}{1}
    \thispagestyle{empty}
    \addtocontents{toc}{\protect\thispagestyle{empty}}

    % 重置目录标题
    \if@CODEDUMPNOTE@traditional
        \renewcommand{\contentsname}{目錄}
    \else
        \renewcommand{\contentsname}{目录}
    \fi

    \tableofcontents    % 印出目录
}

% 扩张 \appendix: 重置天眉
\g@addto@macro\appendix{
    % 为附录重置天眉格式
    \if@CODEDUMPNOTE@traditional
        \renewcommand{\appendixname}{附錄}
        \renewcommand{\chaptermark}[1]{\markboth{附錄 \thechapter \quad #1}{}}
    \else
        \renewcommand{\appendixname}{附录}
        \renewcommand{\chaptermark}[1]{\markboth{附录 \thechapter \quad #1}{}}
    \fi
    \renewcommand{\sectionmark}[1]{\markright{\S\thesection \quad #1}}
}

% 扩展 \backmatter: 设置文献显示方式. 注意: 若有附录则须重置天眉格式
\g@addto@macro\backmatter{
    \renewcommand{\em}{\itshape} % 书目部分以斜体表示强调
    % 汉化参考文献标题
    \if@CODEDUMPNOTE@traditional
        \renewcommand{\refname}{參考文獻}
        \renewcommand{\bibname}{參考文獻}
    \else
        \renewcommand{\refname}{参考文献}
        \renewcommand{\bibname}{参考文献}
    \fi
}

% 以下设置 biblatex.
% bibLaTeX 部分第一步: 基本设置与汉化.
\DeclareFieldFormat{postnote}{#1}   % 功能是印出 \cite[postnote]{Book}
\if@CODEDUMPNOTE@traditional
    \DefineBibliographyStrings{english}{%
        in = {刊於},
        editor = {主編},
        byeditor = {編者為},
        backrefpage = {引用於 p.\!},
        backrefpages = {引用於 pp.\!},
    }
    \else
        \DefineBibliographyStrings{english}{%
            in = {刊于},
            editor = {主编},
            byeditor = {编者为},
            backrefpage = {引用于 p.\!},
            backrefpages = {引用于 pp.\!},
    }
\fi
% biblatex 部分第二步: 要求在 doi 和 URL 并存时移除 URL. 仅适用于 Biblatex + Biber. 源码取自 https://tex.stackexchange.com/questions/119136/biblatex-convert-doi-url-into-doi-field  原文如下.
% The actual value inside \regexp can be adjusted.
% In the first step we create a doi field for each entry where the url field matches the regexp, and the novel field has the value of the url field. In the second step we remove the doi "namespace".
% In the second \map sequence the url and urldate fields are cleared if a doi field is present, to mimic the behavior in the first part of the original question. 
\DeclareSourcemap{
    \maps[datatype=bibtex]{
        \map{
            \step[ % copies url to doi field if it starts with http://dx.doi.org/
            fieldsource=url,
            match=\regexp{http://dx.doi.org/(.+)},
            fieldtarget=doi,
            ]
            \step[ % removes http://dx.doi.org/ string from doi field
            fieldsource=doi,
            match=\regexp{http://dx.doi.org/(.+)},
            replace=\regexp{$1}
            ]
        }
        \map{ % removes url + urldate field from all entries that have a doi field
            \step[fieldsource=doi, final]
            \step[fieldset=url, null]
            \step[fieldset=urldate, null]
        }
    }
}

% 将 figure 和 table 索引加入目录: 使用 etoolbox 提供的 patching
\pretocmd{\listoffigures}{%
    \cleardoublepage
    \phantomsection
    \addcontentsline{toc}{chapter}{\listfigurename}
}{}{}
\pretocmd{\listoftables}{%
    \cleardoublepage
    \phantomsection
    \addcontentsline{toc}{chapter}{\listtablename}
}{}{}

% 输入章节标题设置
\input{\@CODEDUMPNOTE@titlesetup}

% 设置习题环境, 置于每章最后: 不用 \section* 以免格式混淆
\if@CODEDUMPNOTE@traditional
    \newenvironment{Exercises}{%
        \markright{習題}
        \addcontentsline{toc}{section}{習題}
        \vspace{1em}\begin{center}
            \Large\CJKfamily{sectionfont} 習題
        \end{center}\vspace{0.7em}
        \begin{small}\begin{enumerate}[\bfseries 1.] %
            }{  % 结束
        \end{enumerate}\end{small}
    }
\else
    \newenvironment{Exercises}{%
        \markright{习题}
        \addcontentsline{toc}{section}{习题}
        \vspace{1em}\begin{center}
            \Large\CJKfamily{sectionfont} 习题
        \end{center}\vspace{0.7em}
        \begin{small}\begin{enumerate}[\bfseries 1.] %
            }{  % 结束
        \end{enumerate}\end{small}
    }
\fi

% 习题提示 (定义为环境, 穿插文中)
\newenvironment{hint}{%
    \ifvmode % 用 \ifvmode 测试: 如果提示另起新段, 则不加空白.
        \ignorespaces   % 消除横向空白, 优于 \unskip
    \else
        \quad   % 否则加入空白.
    \fi
    \begin{tikzpicture}[baseline=(H.base), every node/.style={signal, draw, very thin, signal to=east, signal from=nowhere, signal pointer angle=120, inner sep=2pt}]
        \node[anchor=mid west] (H) at (0,0) {\heiti\footnotesize 提示};
    \end{tikzpicture}
}{}

% 每章开头的学习提示 (定义为环境)
\if@CODEDUMPNOTE@traditional
    \newtcolorbox{wenxintishi}{
        breakable,
        enhanced,
        width = \textwidth,
        colback = white, colbacktitle = white,
        colframe = gray!50, boxrule=0.2mm,
        coltitle = black,
        fonttitle = \sffamily,
        attach boxed title to top left = {yshift=-\tcboxedtitleheight/2,  xshift=\tcboxedtitlewidth/4},
        boxed title style = {boxrule=0pt, colframe=white},
        before skip = 0.5cm,
        top = 3mm,
        bottom = 3mm,
        title={閱讀提示}
    }
\else
    \newtcolorbox{wenxintishi}{
        breakable,
        enhanced,
        width = \textwidth,
        colback = white, colbacktitle = white,
        colframe = gray!50, boxrule=0.2mm,
        coltitle = black,
        fonttitle = \sffamily,
        attach boxed title to top left = {yshift=-\tcboxedtitleheight/2,  xshift=\tcboxedtitlewidth/4},
        boxed title style = {boxrule=0pt, colframe=white},
        before skip = 0.5cm,
        top = 3mm,
        bottom = 3mm,
        title={阅读提示}
    }
\fi

\AtEndPreamble{
    \RequirePackage[thmmarks, amsmath, hyperref]{ntheorem}  % 设置定理环境所需
    
    % 若 hyperref 已载入, 则按 colors 的 Bool 值设置链接色彩.
    \@ifpackageloaded{hyperref}{
        \if@CODEDUMPNOTE@colors
            \hypersetup{
            colorlinks = true,
            linkcolor = blue,
            citecolor = red,
            urlcolor = teal}
        \else
            \hypersetup{hidelinks}
        \fi}
    {}
    
    % 设置页面尺寸
    \RequirePackage{geometry}
    \IfStrEq{\@CODEDUMPNOTE@geometry}{b5}{% 载入 b5 版面设置
    \geometry{
        paper=b5paper,
        headheight=5ex,
        headsep=5ex,
        textwidth=132mm,
        textheight=198mm,
        twoside,
        % bindingoffset=18pt,
        asymmetric  % 单双数页不分
    }}{}

    \IfStrEq{\@CODEDUMPNOTE@geometry}{a4}{% 载入 a4 版面设置
    \geometry{
        paper=a4paper,
        top=3cm,
        inner=2.54cm,
        outer=2.54cm,
        bottom=3cm,
        headheight=6ex,
        headsep=6ex,
        twoside,
        asymmetric
    }}{}

    % 设置天眉所需
    \RequirePackage{fancyhdr}
    % 使空页恒空
    \fancypagestyle{plain}{
        \fancyhead{}
        \renewcommand{\headrulewidth}{0pt}
    }
    
    % 设置天眉
    \pagestyle{fancy}
    \if@CODEDUMPNOTE@CJKthechapter
        \renewcommand{\chaptermark}[1]{\markboth{
            第\CJKnumber{\thechapter}章\quad #1
            }{}}
    \else
        \renewcommand{\chaptermark}[1]{\markboth{
            第 \thechapter 章\quad #1
            }{}}
    \fi
    \renewcommand{\sectionmark}[1]{\markright{\S\arabic{chapter}.\arabic{section} \quad #1}}
    \fancyhf{} % 先清空
    \fancyhead[EC]{\CJKfamily{hei2}\footnotesize{\leftmark}\vspace{1mm}}
    \fancyhead[OC]{\CJKfamily{hei2}\footnotesize{\rightmark}\vspace{1mm}}
    \fancyhead[LE,RO]{{\footnotesize \thepage}\vspace{1mm}} %
    \fancyhead[RE,LO]{}
    \if@CODEDUMPNOTE@draftmark
        \fancyfoot[C]{\@CODEDUMPNOTE@draftstring} % 在 draftmark=true 时打印版本信息
    \fi
    \renewcommand{\headrulewidth}{0pt}  % 天眉暂不加横线
    \renewcommand{\footrulewidth}{0pt}
    \addtolength{\headheight}{0.5pt}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage[framemethod=TikZ]{mdframed}
\usepackage{amsthm}
%Theorem
\mdfsetup{skipabove=\topskip,skipbelow=\topskip}
%%% upto here
\newcounter{theo}[section]
\newenvironment{theo}[1][]{%
\stepcounter{theo}%
\ifstrempty{#1}%
 {\mdfsetup{%
   frametitle={%
    \tikz[baseline=(current bounding box.east),outer sep=0pt]
    \node[anchor=east,rectangle,fill=gray!50]
         {\strut Theorem~\thetheo};}}
 }%
{\mdfsetup{%
  frametitle={%
   \tikz[baseline=(current bounding box.east),outer sep=0pt]
   \node[anchor=east,rectangle,fill=gray!50]
        {\strut Theorem~\thetheo:~#1};}}%
 }%
\mdfsetup{innertopmargin=10pt,linecolor=gray!50,%
       linewidth=2pt,topline=true,
       frametitleaboveskip=\dimexpr-\ht\strutbox\relax,}
   \begin{mdframed}[]\relax%
}
{\end{mdframed}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% ------------------------------------------------------------
% COLORS

% Color palette from https://flatuicolors.com/palette/us
\definecolor{amzchaptercolor}{HTML}{0984e3}
\definecolor{amzdfnboxcolor}{HTML}{0984e3}
\definecolor{amzthmboxcolor}{HTML}{6c5ce7}
\definecolor{amzexboxcolor}{HTML}{fdcb6e}
\definecolor{amzgenboxcolor}{HTML}{00b894}
\definecolor{amztecboxcolor}{HTML}{e17055}
\definecolor{amzcodeboxcolor}{HTML}{2d3436}
\definecolor{amznoteboxcolor}{HTML}{d63031}

% ------------------------------------------------------------
% COLOR BOXES
\if@CODEDUMPNOTE@fastcompile
\tcbset{
    amzdefaultstyle/.style={
        fonttitle=\strut\bfseries,  % strut for uniform title height
        breakable
    },
    genboxstyle/.style={
        amzdefaultstyle,
    },
    noteboxstyle/.style={breakable},
    codeboxstyle/.style={
        overlay={\begin{tcbclipinterior}\fill[darkgray!20!white] (frame.south west) rectangle ([xshift=6mm]frame.north west);\end{tcbclipinterior}},
        skin=bicolor,
        collower=white,
        colbacklower=darkgray
    },
}

%test

\else %\ifamznotes@fastcompile
\tcbset{
    amzdefaultstyle/.style={
        enhanced,
        drop fuzzy shadow,
        fonttitle=\strut\bfseries,  % strut for uniform title height
        boxrule=0pt,
        frame hidden,
        % parbox=false,               % normal paragraph spacing
        breakable,
    },
    genboxstyle/.style={
        amzdefaultstyle,
        frame style={fill=amzgenboxcolor!85!black},
        interior style={fill=amzgenboxcolor!5!white},
        segmentation style={solid,draw=amzgenboxcolor!50!black,opacity=0.25,line width=1pt}
    },
    noteboxstyle/.style={
        enhanced,
        boxrule=0pt,
        frame hidden,
        borderline west={4pt}{0pt}{amznoteboxcolor},
        colback=amznoteboxcolor!7!white,
        sharp corners,
    },
    codeboxstyle/.style={
        overlay={\begin{tcbclipinterior}\fill[darkgray!20!white] (frame.south west) rectangle ([xshift=6mm]frame.north west);\end{tcbclipinterior}},
        skin=bicolor,
        collower=white,
        colbacklower=darkgray
    },
}

\fi %\ifamznotes@fastcompile

% Give the index numbers some more space
\renewcommand{\l@tcolorbox}{\@dottedtocline{1}{0pt}{3em}}
\setlength{\columnsep}{3em}

\newcommand{\amzindex}{
    \addcontentsline{toc}{chapter}{Index}
    \chapter*{Index}

    % Remove header for index
    \renewcommand{\headrulewidth}{0pt}
    \fancyhead{}

    \begin{multicols}{2}
        \amzindexbody
    \end{multicols}
}

\newcommand{\amzindexbody}{}

\newcommand{\addindexentry}[2]{%
    \appto\amzindexbody{
        \iftoggle{#2}{
            \tcblistof[\section*]{#2}{#1}
        }{}
    }
}

%\newamzbox{environment name}{title}{ref label}{color}[tcolorbox style]
\newcounter{amzboxcounter}
\NewDocumentCommand{\newamzbox}{m m m m O{}}{
    \newtcbtheorem[use counter=amzboxcounter,number within=section,list inside={#3}]{tc#1}{#2}{
        amzdefaultstyle,
        frame style={fill=#4!85!black},
        interior style={fill=#4!5!white},
        segmentation style={solid,draw=#4!50!black,opacity=0.25,line width=1pt},
        #5
    }{#3}

    \providetoggle{#3}
    \settoggle{#3}{false}

    \newenvironment{#1}[2]{
        \global\settoggle{#3}{true}
        \begin{tc#1}{##1}{##2}
    }{
        \end{tc#1}
    }

    \newenvironment{#1*}[1]{
        \begin{tc#1*}{##1}
    }{
        \end{tc#1*}
    }

    \addindexentry{#2s}{#3}
}

\newamzbox{dfnbox}{Definition}{dfn}{amzdfnboxcolor}


  \tcbset{
    common/.style={
      fontupper=\citshape,
      lower separated=false,
      % before upper={\setlength{\parindent}{\normalparindent}},
      coltitle=white,
      colback=gray!5,
      boxrule=0.5pt,
      fonttitle=\bfseries,
      enhanced,
      breakable,
      top=8pt,
      before skip=8pt,
      attach boxed title to top left={
        yshift=-0.11in,
        xshift=0.15in},
      boxed title style={
        boxrule=0pt,
        colframe=white,
        arc=0pt,
        outer arc=0pt},
      separator sign={.},},
    defstyle/.style={
      common,
      colframe=main,  
      colback=main!5,
      colbacktitle=main, 
      overlay unbroken and last={
        \node[anchor=south east, outer sep=0pt] at (\linewidth-width,0) {
          \textcolor{main}{$\clubsuit$}};}},
    thmstyle/.style={
      common,
      colframe=second,  
      colback=second!5,
      colbacktitle=second, 
      overlay unbroken and last={
        \node[anchor=south east, outer sep=0pt] at (\linewidth-width,0) {
          \textcolor{second}};}},
    prostyle/.style={
      common,
      colframe=third,  
      colback=third!5,
      colbacktitle=third, 
      overlay unbroken and last={
        \node[anchor=south east, outer sep=0pt] at (\linewidth-width,0) {
          \textcolor{third}{$\spadesuit$}};}},
    CODEDUMPNOTE@title/.code n args={2}
      {

        \tcbset
          {
            title=
              {
                \csname #1name\endcsname~%
                \ifdef{\thetcbcounter}{\thetcbcounter}{}%
                \ifblank{#2}{}{\ (#2)}
              }
          }
      },
    CODEDUMPNOTE@label/.code n args={2}
      {
        \ifblank{#2}
          {}{\tcbset{label={#1:#2}}}
      }
    }
  
  % define an internal control sequence \CODEDUMPNOTE@newtheorem for fancy mode's newtheorem
  % #1 is the environment name, #2 is the prefix of label, #3 is the style
  % style: thmstyle, defstyle, prostyle
  % e.g. \CODEDUMPNOTE@newtheorem{theorem}{thm}{thmstyle}
  % will define two environments: numbered ``theorem'' and no-numbered ``theorem*''
  % WARNING FOR MULTILINGUAL: this cs will automatically find \theoremname's definition,
  % WARNING FOR MULTILINGUAL: it should be defined in language settings.
  \NewDocumentCommand \CODEDUMPNOTE@newtheorem { m m m O{} }{
    \DeclareTColorBox[use counter=amzboxcounter,number within=section]{#1}{ g o t\label g }{
        breakable,
        enhanced,
        width = \textwidth,
        colback = white, colbacktitle = white,
        colframe = gray!50, boxrule=0.2mm,
        coltitle = black,
        %fonttitle = \sffamily,
        attach boxed title to top left = {yshift=-\tcboxedtitleheight/2,  xshift=\tcboxedtitlewidth/4},
        boxed title style = {boxrule=0pt, colframe=white},
        before skip = 0.5cm,
        top = 3mm,
        bottom = 3mm,
        IfValueTF={##1}
          {CODEDUMPNOTE@title={#1}{##1}}
          {
            IfValueTF={##2}
            {CODEDUMPNOTE@title={#1}{##2}}
            {CODEDUMPNOTE@title={#1}{}}
          },
        IfValueT={##4}
          {
            IfBooleanTF={##3}
              {label={##4}}
              {CODEDUMPNOTE@label={#2}{##4}}
          }
      }
    \DeclareTColorBox{#1*}{ g o }{
        common,#3,
        IfValueTF={##1}
          {CODEDUMPNOTE@title={#1}{##1}}
          {
            IfValueTF={##2}
            {CODEDUMPNOTE@title={#1}{##2}}
            {CODEDUMPNOTE@title={#1}{}}
          },
      }
  }
  % define several environment 
  % we define headers like \definitionname before
  \CODEDUMPNOTE@newtheorem{theorem}{thm}{thmstyle}


    \newtcolorbox{remarkbox}{
        breakable,
        enhanced,
        width = \textwidth,
        colback = white, colbacktitle = white,
        colframe = gray!50, boxrule=0.2mm,
        coltitle = black,
        fonttitle = \sffamily,
        attach boxed title to top left = {yshift=-\tcboxedtitleheight/2,  xshift=\tcboxedtitlewidth/4},
        boxed title style = {boxrule=0pt, colframe=white},
        before skip = 0.5cm,
        top = 3mm,
        bottom = 3mm,
        title={注}
    }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtBeginDocument{
}

\AtEndDocument{
}

% ------------------------------------------------------------
% font settings
% ------------------------------------------------------------
% 设置 xeCJK 字体及中文数字
%\setmainfont{TeX Gyre Pagella} % 设置西文衬线字体
\setsansfont{TeX Gyre Heros}    % 设置西文无衬线字体

% 自用模式: Fandol 字体 + 思源黑体 (Noto Sans CJK SC), 宜留意字体高低差异.
\setCJKmainfont[
    BoldFont=FandolSong-Bold.otf,
    ItalicFont=FandolKai-Regular.otf
]{FandolSong-Regular.otf}

\setCJKsansfont[
    BoldFont=FandolHei-Bold.otf
]{FandolHei-Regular.otf}

\setCJKmonofont[
    BoldFont=FandolHei-Bold.otf,
]{FandolHei-Regular.otf}


\setCJKfamilyfont{kai}[
    BoldFont=FandolKai-Regular.otf, ItalicFont=FandolKai-Regular.otf
]{FandolKai-Regular.otf}

\setCJKfamilyfont{song}[
    BoldFont=FandolSong-Bold.otf,
    ItalicFont=FandolKai-Regular.otf
]{FandolSong-Regular.otf}

\setCJKfamilyfont{fangsong}[
    BoldFont=FandolSong-Bold.otf,
    ItalicFont=FandolKai-Regular.otf
]{FandolFang-Regular.otf}

\setCJKfamilyfont{hei}[
    BoldFont=FandolHei-Bold.otf,
    ItalicFont=FandolHei-Regular.otf
]{FandolHei-Regular.otf}

\setCJKfamilyfont{hei2}{Noto Sans CJK SC}

\setCJKfamilyfont{sectionfont}[
    BoldFont=* Black
]{Noto Sans CJK SC}

\setCJKfamilyfont{pffont}[
    BoldFont=* Medium
]{Noto Sans CJK SC} % 证明用的字体
\setCJKfamilyfont{emfont}[
    BoldFont=FandolHei-Regular.otf
]{FandolHei-Regular.otf}    % 强调用的字体

\defaultfontfeatures{Ligatures=TeX} 
\XeTeXlinebreaklocale "zh"
\XeTeXlinebreakskip = 0pt plus 1pt minus 0.1pt

% 以下设置字体相关命令, 用于定理等环境中.
\newcommand\kaishu{\CJKfamily{kai}} % 楷体
\newcommand\songti{\CJKfamily{song}} % 宋体
\newcommand\heiti{\CJKfamily{hei}}  % 黑体
\newcommand\thmheiti{\CJKfamily{hei2}}  % 用于定理名称的黑体
\newcommand\fangsong{\CJKfamily{fangsong}} % 仿宋
\renewcommand{\em}{\bfseries\CJKfamily{emfont}} % 强调