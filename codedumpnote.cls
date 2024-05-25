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



% ------------------------------------------------------------
% 选项设置
% ------------------------------------------------------------
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

\DeclareBoolOption{math}        % enables thmbox and math macros
\DeclareBoolOption{code}        % enables codebox
\DeclareBoolOption{logic}       % enables logic macros
\DeclareBoolOption{quote}       % enables quote macros

% defalut language is cn
\DeclareStringOption[cn]{lang}
\DeclareVoidOption{en}{\ekv{lang=en}}
\DeclareVoidOption{cn}{\ekv{lang=cn}}

% defalut mode is simple
\DeclareStringOption[simple]{mode}
\DeclareVoidOption{fancy}{\ekv{mode=fancy}}
\DeclareVoidOption{simple}{\ekv{mode=simple}}

% Execution of options
% ---------------------
\ProcessKeyvalOptions*
\relax

% Package loading
% ---------------------
% 基于 book class, 选项一并载入.
%\LoadClass[8pt,a4paper]{book}
\LoadClass[10pt,a4paper]{book}
\usepackage[fontsize=7pt]{fontsize}
%\LoadClass[a4paper,oneside]{book}

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

% 图片加载位置
\graphicspath{{./figure/}{./figures/}{./image/}{./images/}{./graphics/}{./graphic/}{./pictures/}{./picture/}}

% ------------------------------------------------------------
% load math\code\logic required packages 
% ------------------------------------------------------------
\if@CODEDUMPNOTE@math
    \RequirePackage{amsfonts}
\fi

\if@CODEDUMPNOTE@code
    \RequirePackage{listings}
    \RequirePackage{algorithm}
    \RequirePackage[noend]{algpseudocode}

    \algnewcommand\algorithmicforeach{\textbf{for each}}
    \algdef{S}[FOR]{ForEach}[1]{\algorithmicforeach\ #1\ }

    \algnewcommand{\LineComment}[1]{\State \(\triangleright\) #1}

%% 自定义listings代码样式
%\renewcommand*\familydefault{\ttdefault} %% Only if the base font of the document is to be typewriter style
\usepackage[T1]{fontenc}
\usepackage[lighttt]{lmodern} % bold and italic ttfamily
\definecolor{lstgrey}{rgb}{0.95,0.95,0.95}
\definecolor{Decorators}{rgb}{0.7,0,0.7}
\definecolor{Keywords}{rgb}{0,0,1}
%\newcommand{\listingsttfamily}{\fontfamily{TeX Gyre Heros}}
\lstdefinestyle{style@base}{
  % Basic design
  %basicstyle=\linespread{1.1}\tt,
  backgroundcolor=\color{lstgrey},
  %basicstyle=\linespread{1.1}\listingsttfamily,
  basicstyle=\linespread{1.1}\ttfamily,
  frame=single,
  framesep=5pt,
  framerule=.5pt,
  framexleftmargin=10pt,
  abovecaptionskip=0pt,
  belowcaptionskip=5pt,
  aboveskip=5pt,
  % Code design
  breakatwhitespace=false,
  breaklines=true,
  captionpos=t,
  keepspaces=true,
  % Line numbers
  numbers=none,
  numbersep=15pt,
  xleftmargin=10pt,
  stepnumber=1,
  firstnumber=1,
  numberfirstline=true,
  % Code
  tabsize=2,
  showspaces=false,
  showstringspaces=false,
  showtabs=false,
  breaklines=true,
  %% keywords
  keywordstyle={\color{Keywords}\bfseries},
  % additional keywords
  keywordstyle={[2]\color{Decorators}},
}
\lstset{style=style@base}
\fi

\if@CODEDUMPNOTE@logic
%\RequirePackage{prftree} % \prf*
\RequirePackage{mathpartir} % inferrule

% tautologically equivalent
\newcommand\tauteq{\mathrel{\vDash \mkern -2.25mu
                               \mathrel{\reflectbox{\ensuremath\vDash}}}}

% syntactically equivalent
\newcommand\syeq{\mathrel{\vdash \mkern -2.25mu
                               \mathrel{\reflectbox{\ensuremath\vdash}}}}
\fi

\if@CODEDUMPNOTE@quote
\usepackage{quoting,xparse}

\NewDocumentCommand{\bywhom}{m}{% the Bourbaki trick
  {\nobreak\hfill\penalty50\hskip1em\null\nobreak
   \hfill\mbox{\normalfont(#1)}%
   \parfillskip=0pt \finalhyphendemerits=0 \par}%
}

\NewDocumentEnvironment{pquotation}{m}
  {\begin{quoting}[
     indentfirst=true,
     leftmargin=\parindent,
     rightmargin=\parindent]\itshape}
  {\bywhom{#1}\end{quoting}}
\fi



% ------------------------------------------------------------
% 章节设置
% ------------------------------------------------------------
\RequirePackage[center,pagestyles]{titlesec}
\RequirePackage[title,titletoc,header]{appendix}

\ifdefstring{\@CODEDUMPNOTE@mode}{simple}{
  \definecolor{structurecolor}{RGB}{0,0,0}
  \definecolor{main}{RGB}{0,0,0}%
  \definecolor{second}{RGB}{0,0,0}%
  \definecolor{third}{RGB}{0,0,0}%
}{\relax}

% ------------------------------------------------------------
% language settings
% ------------------------------------------------------------
\ifdefstring{\@CODEDUMPNOTE@lang}{cn}{
  \renewcommand{\contentsname}{目录}
  \renewcommand{\figurename}{图}
  \renewcommand{\tablename}{表}
  %\renewcommand{\partname}{\color{structurecolor}}
  %\renewcommand{\thepart}{第\zhnumber{\arabic{part}}部分}
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
  \renewcommand{\chaptermark}[1]{\markboth{附录 \thechapter \quad #1}{}}
  \newcommand{\refname}{参考文献}
}{\relax}

\ifdefstring{\@CODEDUMPNOTE@lang}{en}{
  \setlength\parindent{2em}
  \newcommand\figref[1]{\textbf{Figure}~\ref{#1}}
  \newcommand\tabref[1]{\textbf{Table}~\ref{#1}}
  \renewcommand{\chaptername}{Chapter}
  %\renewcommand{\partname}{\color{structurecolor} Part}
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
  \renewcommand{\chaptermark}[1]{\markboth{Appendix \thechapter \quad #1}{}}
  \newcommand{\refname}{References}
}{\relax}
% ------------------------------------------------------------
\usetikzlibrary{shapes.symbols} % 稍后定义 hint 环境所需

% 定义在 draftmark=true 模式下显示版本信息的指令
\RequirePackage[iso, english]{isodate}  % 使 \today 印出 yyyy-mm-dd

\if@CODEDUMPNOTE@draftmark
    \providecommand{\@CODEDUMPNOTE@draftstring}{{\color{gray!40}\heiti 未定稿: \today}}
\fi

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

    \tableofcontents    % 印出目录
}

% 扩张 \appendix: 重置天眉
\g@addto@macro\appendix{
    \renewcommand{\sectionmark}[1]{\markright{\S\thesection \quad #1}}
}

% 扩展 \backmatter: 设置文献显示方式. 注意: 若有附录则须重置天眉格式
\g@addto@macro\backmatter{
    \renewcommand{\em}{\itshape} % 书目部分以斜体表示强调
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

\AtEndPreamble{
    %\RequirePackage[thmmarks, amsmath, hyperref]{ntheorem}  % 设置定理环境所需
    
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

% ------------------------------------------------------------
% env settings
% ------------------------------------------------------------

\newcounter{sectioncounter}

\ifdefstring{\@CODEDUMPNOTE@mode}{simple}{
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
    blank/.style={
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
    },
    CODEDUMPNOTE@title/.code n args={2}
      {
        \tcbset
          {
            title=
              \textbf{
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
  \NewDocumentCommand \CODEDUMPNOTE@boxwithsectionnumber { m m O{} }{
    \DeclareTColorBox[use counter=sectioncounter,number within=section]{#1}{ g o t\label g }{
        breakable,
        enhanced,
        width = \textwidth,
        boxrule=0.2mm,
        %fonttitle = \sffamily,
        attach boxed title to top left = {yshift=-\tcboxedtitleheight/2,  xshift=\tcboxedtitlewidth/4},
        boxed title style = {boxrule=0pt},
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

  \NewDocumentCommand \CODEDUMPNOTE@boxwithname { m m O{} }{
    \DeclareTColorBox{#1}{ g o t\label g }{
        blank,
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
  \CODEDUMPNOTE@boxwithsectionnumber{theorem}{thm}
  \CODEDUMPNOTE@boxwithsectionnumber{definition}{def}
  \CODEDUMPNOTE@boxwithsectionnumber{postulate}{pos}
  \CODEDUMPNOTE@boxwithsectionnumber{axiom}{axi}
  \CODEDUMPNOTE@boxwithsectionnumber{corollary}{cor}
  \CODEDUMPNOTE@boxwithsectionnumber{lemma}{lem}
  \CODEDUMPNOTE@boxwithsectionnumber{proposition}{pro}
  \CODEDUMPNOTE@boxwithsectionnumber{property}{property}

  \CODEDUMPNOTE@boxwithname{note}{note}
  \CODEDUMPNOTE@boxwithname{remark}{remark}

%% Example with counter
\newcounter{exam}[chapter]
\setcounter{exam}{0}
\renewcommand{\theexam}{\thechapter.\arabic{exam}}
\newenvironment{example}[1][]{
  \refstepcounter{exam}
  \par\noindent\textbf{{\examplename} \theexam #1 }\rmfamily}{
  \par\ignorespacesafterend}

%% Exercise with counter
\newcounter{exer}[chapter]
\setcounter{exer}{0}
\renewcommand{\theexer}{\thechapter.\arabic{exer}}
\newenvironment{exercise}[1][]{
  \refstepcounter{exer}
  \par\noindent\makebox[-3pt][r]{
    \scriptsize}
    \textbf{{\exercisename} \theexer #1 }\rmfamily}{
    \par\ignorespacesafterend}

%% Problem with counter
\newcounter{prob}[chapter]
\setcounter{prob}{0}
\renewcommand{\theprob}{\thechapter.\arabic{prob}}
\newenvironment{problem}[1][]{
  \refstepcounter{prob}
  \par\noindent\textbf{{\problemname} \theprob #1 }\rmfamily}{
  \par\ignorespacesafterend}

\newenvironment{solution}{\par\noindent\textbf{\solutionname} \citshape}{\hfill $\square$ \par}
\newenvironment{proof}{\par\noindent\textbf{\proofname} \citshape}{\hfill $\square$ \par}
\newenvironment{assumption}{\par\noindent\textbf{\assumptionname} \citshape}{\par}
\newenvironment{conclusion}{\par\noindent\textbf{\conclusionname} \citshape}{\par}
}{\relax}


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
\usepackage{unicode-math}
\setmainfont{XITS}
\setmathfont{XITS Math}
%\setmathfont{Cambria Math}

% 设置 xeCJK 字体及中文数字
\setsansfont{TeX Gyre Heros}    % 设置西文无衬线字体

\ifcsname kaishu\endcsname
  \newcommand{\citshape}{\kaishu}
\else
  \newcommand{\citshape}{\itshape}
\fi

% 自用模式: Fandol 字体 + 思源黑体 (Noto Sans CJK SC), 宜留意字体高低差异.
%\setCJKmainfont[
%    BoldFont=FandolSong-Bold.otf,
%    ItalicFont=FandolKai-Regular.otf
%]{FandolSong-Regular.otf}
\setCJKmainfont[
    BoldFont={霞鹜文楷},
    ItalicFont={霞鹜文楷},
]{霞鹜文楷}

%\setCJKsansfont[
%    BoldFont=FandolHei-Bold.otf
%]{FandolHei-Regular.otf}
\setCJKsansfont[
    BoldFont={霞鹜文楷},
]{霞鹜文楷}

%\setCJKmonofont[
%    BoldFont=FandolHei-Bold.otf,
%]{FandolHei-Regular.otf}
\setCJKmonofont[
    BoldFont={霞鹜文楷},
]{霞鹜文楷}

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


% ------------------------------------------------------------
% title settings
% ------------------------------------------------------------


% ------------------------------------------------------------
% 引入的包
% ------------------------------------------------------------
% 生成链接
\RequirePackage{hyperref}
\hypersetup{
  breaklinks,
  unicode,
  linktoc=all,
  bookmarksnumbered=true,
  bookmarksopen=true,
  pdfkeywords={ElegantBook},
  colorlinks,
  linkcolor=winered,
  citecolor=winered,
  urlcolor=winered,
  plainpages=false,
  pdfstartview=FitH,
  pdfborder={0 0 0},
  linktocpage
}
