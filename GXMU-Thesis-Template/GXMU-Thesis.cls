\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{GXMU-Thesis}[06-28-2023 v1.0 GXMU-Thesis Class]
\RequirePackage{kvoptions}%自定义选项宏包
% ---------------------------------- Default Options ----------------------------------------------%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax
\LoadClass[zihao=-4,fontset=windows,twoside,]{ctexart}
\def\fontspath{fonts/}
\usepackage{fontspec}
\setmainfont{Times New Roman}
\usepackage{anyfontsize} % 提供\fontsize{}{}\selectfont命令
\RequirePackage{geometry}
\RequirePackage{multirow,multicol}
\RequirePackage{indentfirst}
\RequirePackage{booktabs,supertabular,makecell}
\usepackage{etoolbox}
%提供自定义封面选项接口
\usepackage[dvipsnames,svgnames,x11names,table]{xcolor}%颜色宏包 % Driver-independent color extensions
\usepackage{tikz}
\usepackage{titlesec}
\usepackage{ulem}
\usepackage{graphicx} %插图
\usetikzlibrary{calc,fadings,patterns}
\usepackage{adjustbox}
%修正minipage顶部对齐问题
\RequirePackage[font={onehalfspacing, small}, labelsep=space, skip=6pt, figurewithin=none, tablewithin=none]{caption} % figurewithin=none, tablewithin=none 将book 类中向figure of list 添加 10pt间距的命令取消，但也会使得图表章与章之间连续编号，因此需要设置对应计数器每章重置
\colorlet{coverfgcolor}{gray!2}
\RequirePackage[nopostdot]{glossaries} %不显示description后的英文标点符号
\RequirePackage{ifthen}
\usepackage{ninecolors}
\usepackage[colorlinks,
            pdfstartview=FitH,
            CJKbookmarks=true,
            bookmarksnumbered=true,
            bookmarksopen=true,
            linkcolor=black,
            filecolor=purple5,
            anchorcolor=purple5,
            linktocpage=true,
            urlcolor=purple5,
            citecolor=purple5,
            pdfencoding={auto},
			pdfauthor={ Shilong.Lu},pdfsubject={article},
			pdftitle={titlename},pdfkeywords={article},
            breaklinks,
            unicode,
            linktoc=all,
            plainpages=false,
            pdfusetitle,]{hyperref}
\RequirePackage[capitalize]{cleveref} % 要在 hyperref后引用 noabbrev 引用前缀为缩写
\RequirePackage{lastpage} % 统计总页数宏
\RequirePackage[labelformat=simple]{subcaption}

% ===============定义 eversion/pversion 选项===============
\newif\ifOptionPrintVersion % 定义逻辑变量 OptionPrintVersion
\OptionPrintVersionfalse % 默认为false 也就是电子版
\DeclareOption{eversion}{\OptionPrintVersionfalse} % false为电子版
\DeclareOption{pversion}{\OptionPrintVersiontrue} % true为打印版
\ProcessOptions\relax % 处理选项

% ================页边距设置===============
\ifOptionPrintVersion % 根据eversion/pversion 选项设置页边距
  \geometry{inner=3cm, outer=2cm, top=3cm, bottom=2cm} % bindingoffset为内边距加长2.5cm
\else
  \geometry{left=2.5cm, right=2.5cm, top=3cm, bottom=2cm}
\fi
\makeatletter
%%----------------------------------封面信息定义--------------------------------------------------------%%
\newcommand\schoolinformation[1]{\def\@schoolinformation{#1}}
\newcommand\subtitle[1]{\def\@subtitle{#1}}
\newcommand\logo[1]{\def\@logo{#1}}
\newcommand\studentinformation[1]{\def\@studentinformation{#1}}
\newcommand\teacher[1]{\def\@teacher{#1}}
\newcommand\subject[1]{\def\@subject{#1}}
\newcommand\academy[1]{\def\@academy{#1}}
\newcommand\grade[1]{\def\@grade{#1}}
\newcommand\major[1]{\def\@major{#1}}
\newcommand\finishedtime[1]{\def\@finishedtime{#1}}
%%----------------------------------封面信息定义--------------------------------------------------------%%
\newcommand*\makecover{
    %% Use the Tikz library positioning and clear the page header and footer
    \usetikzlibrary{positioning}
    \thispagestyle{empty}
    \begin{tikzpicture}[remember picture,overlay]
        \fill[coverfgcolor]
        (current page.north west) rectangle (current page.south east);% 填充封面背景颜色 (coverbgcolor)
    \node[text=black,font=\bfseries] at ([xshift=3cm,yshift=-3cm]current page.north west) {
        \begin{tabular}{|c|c|}
        \hline
          学~校~代~码   &\normalfont 10608 \\ \hline
          学~~~~~~~~~~号  &\normalfont xx\\ \hline
          分~~~类~~~号  &\normalfont O151.21\\ \hline
          密~~~~~~~~~~级  &\normalsize\normalfont 公\quad 开\\ \hline
        \end{tabular}
    };
    \node[] (logo) at ([yshift=-8cm]current page.north) {\includegraphics[width=.8\linewidth]{\@logo}};
    \node[text=black,font=\fontsize{50}{50}\selectfont] (title) at ([yshift=-1.5cm]logo.south) {硕~士~学~位~论~文};
    \node[text=black,font=\fontsize{15.75pt}{\baselineskip}\selectfont\bfseries] (subtitle) at ([yshift=-2.5cm]title.south) {\@subtitle};
    \node[text=black,font=\large\bfseries] (studentinformation) at ([yshift=5.5cm]current page.south) {
        \centering
        \begin{tabular}{lcc}
          \makebox[.22\linewidth][s]{研究生姓名} &: & \makebox[.25\linewidth][s]{\@author}  \\[-5pt]\cmidrule[0.85pt]{3-3}
          \makebox[.22\linewidth][s]{导师姓名职称}&: & \makebox[.25\linewidth][s]{\@teacher} \\[-5pt]\cmidrule[0.85pt]{3-3}
          \makebox[.22\linewidth][s]{学科专业} &:& \makebox[.25\linewidth][s]{\@subject} \\[-5pt]\cmidrule[0.85pt]{3-3}
          \makebox[.22\linewidth][s]{所属学院} &:& \makebox[.25\linewidth][s]{\@academy} \\[-5pt]\cmidrule[0.85pt]{3-3}
          \makebox[.22\linewidth][s]{年级} &:&\makebox[.1\linewidth][s]{\@grade} \\[-5pt]\cmidrule[0.85pt]{3-3}
          \makebox[.22\linewidth][s]{论文完成时间} &:&\makebox[.2\linewidth][s]{\@finishedtime} \\[-5pt]\cmidrule[0.85pt]{3-3}
        \end{tabular}
    };
    \end{tikzpicture}%
  \newpage
}
\makeatother
% ====================独创性（或创新性）声明设置====================
\newcommand{\originalitydeclaration}{
  \newpage
  \thispagestyle{empty} %没有页眉页脚，空白页
  \begin{spacing}{1.5}
    \pdfbookmark{独创性（或创新性）声明}{originalitydeclaration}
    \noindent

    \begin{center} % \noindent无缩进
      \fontsize{14pt}{20pt}\selectfont\bfseries 独创性声明
    \end{center}

    \par{\fontsize{12pt}{12pt}\selectfont\noindent\null\hspace{24pt} % % \noindent无缩进
    本人声明所呈交的论文是我个人在导师指导下进行的研究工作及取得的研究成果。尽我所知，除了文中特别加以标注和致谢中所罗列的内容以外，论文中不包含其他人已经发表或撰写过的研究成果；也不包含为获得桂林电子科技大学或其它教育机构的学位或证书而使用过的材料。与我一同工作的同志对本研究所做的任何贡献均已在论文中做了明确的说明并表示了谢意。}
    \\

    \fontsize{12pt}{12pt}\selectfont\noindent\null\hspace{24pt} % \noindent无缩进
    申请学位论文与资料若有不实之处，本人承担一切相关责任。%
    \\

    \fontsize{12pt}{12pt}\selectfont\noindent\null\hspace{24pt}本人签名：\hspace{84pt} %
    日期： \\

    \vspace{1cm}
    \noindent
    \begin{center} % \noindent无缩进
      \fontsize{14pt}{20pt}\selectfont\bfseries 关于论文使用授权的说明
    \end{center}

    \par{\fontsize{12pt}{12pt}\selectfont\noindent\null\hspace{24pt} %
    本人完全了解广西民族大学有关保留和使用学位论文的规定，即：研究生在校攻读学位期间论文工作的知识产权单位属桂林电子科技大学。本人保证毕业离校后，结合学位论文研究成果完成的论文、发明专利等成果，署名单位仍然为桂林电子科技大学。学校有权保留送交论文的复印件，允许查阅和借阅论文；学校可以公布论文的全部或部分内容，可以允许采用影印、缩印或其它复制手段保存论文。（保密的论文在解密后遵守此规定）}\\

    \vspace{1cm}

    \fontsize{12pt}{12pt}\selectfont\noindent\null\hspace{24pt}作者签名：   
    \hspace{84pt} %
    日期： \\

    \fontsize{12pt}{12pt}\selectfont\noindent\null\hspace{24pt}导师签名：         
    \hspace{84pt} %
    日期： \\
  
  \end{spacing}
    \ifOptionPrintVersion
      {\blankpage}
    \else
      {}
    \fi
    \newpage
}

% ====================导入独创性声明定义PDF文件设置====================
\newcommand{\signatureofdeclaration}[1]{
  \includepdf[pages=-]{#1}
  \newpage\setcounter{page}{0}
  \ifOptionPrintVersion 
      {\blankpage}
    \else
      {}
    \fi
}
% 页眉页脚
\makeatletter
\RequirePackage{fancyhdr}
\renewcommand{\sectionmark}[1]{%
\markboth{\thesection\quad #1}{}}
\pagestyle{fancy}
  \fancyhf{}
  \fancyhead[OC]{\leftmark }
  \fancyhead[CE]{\makebox[.25\linewidth][s]{自然辩证法结课论文}} %even
  % \renewcommand\headrulewidth{0pt}
  \fancyfoot[C]{\fontsize{9pt}{10.8pt}\selectfont\thepage}
%
\titleformat{\chapter}[block] 
{\centering\fontsize{16pt}{16pt}\selectfont\heiti\thispagestyle{fancy}}
{\thechapter}{7.5pt}{}
\renewcommand\thesection{第\zhnumber{\arabic{section}}章} %\zhnumber{计数器}，使计数器值输出为汉字格式。
\renewcommand\thesubsection{\arabic{section}.\arabic{subsection}} 
%
% ===============设置图表格式===============  
\captionsetup[subfigure]{aboveskip=2pt, belowskip=2pt} % width=36pt 设置子图标题的宽度 
\captionsetup[subfoat]{aboveskip=2pt, belowskip=2pt}
\captionsetup[figure]{aboveskip=3pt, belowskip=0pt} %设置标题与插图或表格之间的垂直距离，设置标题与下文之间的附加垂直距离, 如果标题在插图或表格之下;或标题与上文之间的附加垂直距离, 如果标题在插图或表格之上。该参数的默认值是0pt。为6pt，下面为0pt
\captionsetup[table]{aboveskip=0pt, belowskip=6pt}
\captionsetup[longtable]{aboveskip=0pt, belowskip=6pt}
\setlength{\intextsep}{9pt} % 控制出现在页⾯中间的浮动体（如使⽤了h 选项的浮动体）与上下方文本之间的垂直距离
% \setlength{\textfloatsep}{6pt} % 控制出现在页⾯的顶部或底部的浮动体与⽂本之间的垂直距离

%\captionsetup{format=hang} %caption工具包在加载时可以修改标题的很多方面，也可以通过 captionsetup命令也可以在工具包选项中修改。\captionsetup[浮动体类型]{参数1=选项, 参数2=选项,…}其中可选参数浮动体类型的选项可以是figure或table,如果省略该参数, 则表示这两种浮动体都适用。format：plain默认值,将标题作为普通段落排版。hang将标题从第二行起悬挂缩进排版，缩进宽度等于标题标志加分隔符的宽度。indention设置从标题第二行起的附加缩进宽度, 例如indention=5mm,其默认值是0pt。
%标题设置\captionsetup

\makeatother
% ===============章节和目录深度设置===============
\setcounter{secnumdepth}{3} %设置章节深度
\setcounter{tocdepth}{2} %设置目录深度
% 目录
\RequirePackage[titles]{tocloft}
\providecommand{\cftchappagefont}{\normalfont}
\providecommand\cftchapleader{\cftdotfill{\cftdotsep}}
\renewcommand{\cftdotsep}{0.4}

\setlength{\cftbeforetoctitleskip}{0pt}
\setlength{\cftaftertoctitleskip}{18pt}
\setlength{\cftbeforesecskip}{2pt}
\addtolength{\cftsecnumwidth}{25pt}

\cftsetindents{section}{21pt}{22pt}
\cftsetindents{subsection}{44pt}{31pt}
\cftsetindents{subsubsection}{76pt}{41pt}

\makeatletter
\renewcommand{\@pnumwidth}{5pt}
\makeatother
\renewcommand{\cfttoctitlefont}{\fontsize{15pt}{15pt}\selectfont\heiti}
\renewcommand\cftsecfont{\heiti}

\renewcommand{\today}{\number\year 年 \number\month 月 \number\day 日}
%=========================中文摘要===============%
\makeatletter
\newenvironment{cnabstract}{
    \section*{摘\quad 要}
    \addcontentsline{toc}{section}{\heiti 摘\quad 要} % 设置在目录显示摘要
  
  \setcounter{page}{1} % 定义为第一页
  \pagenumbering{Roman} % 设置页码显示为罗马数字

  \fancyhf{} % 初始化页码页脚布局
    \renewcommand\headrulewidth{0.75pt}
    \fancyhead[C]{\fontsize{10.5pt}{12.6pt}\selectfont 摘\quad 要} % 设置页眉
    \fancyfoot[CE,CO]{\fontsize{9pt}{10.8pt}\selectfont\thepage} % 罗马页码居中显示

}{
    \newpage
}

%=========================中文关键字
\newcommand{\chinesekeyword}[1]{
\vspace{\baselineskip}
\noindent %无缩进
\@hangfrom{\makebox[48pt][l]{\textbf{关键词：}}}#1
}

%=========================英文摘要
\newenvironment{enabstract}
{
    \section*{\bfseries ABSTRACT}
    \addcontentsline{toc}{section}{\bfseries ABSTRACT} % 设置在目录显示

  \fancyhf{} 
  \renewcommand\headrulewidth{0.75pt}
    \fancyhead[C]{\fontsize{10.5pt}{12.6pt}\selectfont ABSTRACT}
    \fancyfoot[CE,CO]{\fontsize{9pt}{10.8pt}\selectfont\thepage}


}{
    \newpage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%英文关键字

\newcommand{\englishkeyword}[1]
{
  \vspace{\baselineskip}
  \noindent % 无缩进
  \@hangfrom{\makebox[2.1cm][l]{\textbf{Keywords:}}}#1
}
\makeatother
% ===============图表公式引用设置=============== cleveref
% \crefformat{equation}{式#1} %公式引用标签中去掉括号
\crefname{figure}{图}{图} % 更改引用前缀 参数二为单独引用
\crefname{table}{表}{表} % 参数三为多个引用
\crefname{equation}{式}{式}
\crefname{algorithm}{算法}{算法}
\crefname{chapter}{}{}
\crefname{section}{}{}
\crefname{subsection}{}{}
\renewcommand{\contentsname}{目\quad 录} %使默认的Contents改为目 录显示
% \renewcommand{\bibname}{参考文献} %使默认的参考文献名字改为参考文献显示
\renewcommand{\figurename}{图} %使默认的图名字改为图显示
\renewcommand{\tablename}{表} %使默认的表名字改为表显示
\renewcommand{\listfigurename}{插图索引}
\renewcommand{\listtablename}{插表索引}

\setlength{\extrarowheight}{2pt} % 行距

\usepackage{listings} %导入包

\definecolor{codebrown}{rgb}{0.8,0.44,0.2}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.95,0.95,0.92}

\lstdefinestyle{mystyle}{
    backgroundcolor=\color{backcolour},   
    commentstyle=\color{codebrown},
    keywordstyle=\color{magenta},
    numberstyle=\tiny\color{codegray},
    stringstyle=\color{codepurple},
    basicstyle=\ttfamily\footnotesize,
    breakatwhitespace=false,         
    breaklines=true,                 
    captionpos=b,                    
    keepspaces=true,                 
    numbers=left,                 
    % numbersep=5pt,
    % numbers=none,
    showspaces=false,                
    showstringspaces=false,
    showtabs=false,                  
    tabsize=2,
    xleftmargin=0.1\textwidth,
    xrightmargin=0.1\textwidth
}
\lstset{style=mystyle}
\fancypagestyle{figtoc}{
  \fancyhf{} % 初始化页码页脚布局
    \fancyhead[C]{\fontsize{10.5pt}{12.6pt}\selectfont{插图索引}}
    \fancyfoot[CE,CO]{\fontsize{9pt}{10.8pt}\selectfont\thepage} 
}
\fancypagestyle{tabtoc}{
  \fancyhf{}
% 硕博插表索引页眉页码设置 👇
    \fancyhead[C]{\fontsize{10.5pt}{12.6pt}\selectfont{插表索引}}
    \fancyfoot[CE,CO]{\fontsize{9pt}{10.8pt}\selectfont\thepage} 
}
% ====================插图索引格式设置====================
\newcommand{\thesisfigurelist}{{\thispagestyle{figtoc}\listoffigures\clearpage}} % 自定义调用\listoffigures的命令
\pretocmd{\listoffigures}
{ % 图目录是存放在.lof目录的文件下
  \newpage  % 新建一页
  \addtolength{\cftfignumwidth}{12pt} % 设置长度命令，使命令\cftfignumwidth的长度设置为12pt，条目编号与条目内容之间占用的宽度, 例如：图 1-2 [\cftfignumwidth] 电子战飞机
  \renewcommand{\cftfigpresnum}{图} % 条目编号前内容  
}{}{} 

% ====================插表索引格式设置====================
% 定义硕博插表索引命令 👇
\newcommand{\thesistablelist}{{\thispagestyle{tabtoc}\listoftables\clearpage}} % 自定义\thesistablelist命令
\pretocmd{\listoftables}
{ % 表目录是存放在.lot目录的文件下
  \newpage
  \addtolength{\cfttabnumwidth}{12pt} % 条目编号占用宽度，条目编号与条目内容之间占用的宽度, 例如：表1-1 [\cftfignumwidth] 参数设置
  \renewcommand{\cfttabpresnum}{表} % 条目编号前内容
}{}{}


% ====================算法栏====================
\RequirePackage[algosection, boxruled, linesnumbered]{algorithm2e}
\SetAlgorithmName{算法}{算法}{算法列表}
\renewcommand\thealgocf{\arabic{section}-\arabic{algocf}}
\SetAlgoCaptionSeparator{\null}
\AtBeginEnvironment{algorithm}{\vspace{9pt}}
\AfterEndEnvironment{algorithm}{\vspace{9pt}}
% ====================致谢设置====================
\newcommand{\thesisacknowledgement}
{
  \newpage
    \addtocontents{toc}{\protect\setcounter{tocdepth}{0}} % 只显示一级标题
    \setcounter{section}{0} % section计数器清零 
    \section*{致\quad 谢}
  \addcontentsline{toc}{section}{致\quad 谢}
  % \markboth{致谢}{致谢} %\markboth{<左面页眉>}{<右面页眉>}
  \fancyhf{}
  \fancyhead[C]{\fontsize{10.5pt}{12.6pt}\selectfont 致\quad 谢}
  \fancyfoot[CE,CO]{\fontsize{9pt}{10.8pt}\selectfont\thepage}
  \thispagestyle{fancy}
  \normalsize % 设置字体为小四
  % \input{Chapters/Thanks.tex} % 致谢文档位置
  \clearpage
}

\newcommand{\thesisaccomplish}{
  \newpage
  \addtocontents{toc}{\protect\setcounter{tocdepth}{0}} %只显示一级标题
  \setcounter{section}{0} %section计数器清零 

  \section*{攻读硕士学位期间取得的成果}
  \addcontentsline{toc}{section}{攻读硕士学位期间取得的成果}
  \fancyhf{}
  \fancyhead[C]{\fontsize{10.5pt}{12.6pt}\selectfont 攻读硕士学位期间取得的成果}
  \fancyfoot[CE,CO]{\fontsize{9pt}{10.8pt}\selectfont\thepage}
  \thispagestyle{fancy}
  \normalsize % 设置字体为小四
  % \input{Chapters/Accomplish.tex} %% 学术成果文档位置
  \clearpage
}
{}

%
\fancypagestyle{bibstyle}{
  \fancyhf{}
  \fancyhead[C]{\fontsize{10.5pt}{12.6pt}\selectfont 参考文献}
  \fancyfoot[CE,CO]{\fontsize{9pt}{10.8pt}\selectfont\thepage}
  \thispagestyle{fancy}
}