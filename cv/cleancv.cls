%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cleancv
% LaTeX Class
% Version 1.0 (11/09/2020)
%
% Author(s):
% Inti Manuel Yabar-Pagaza (intimyp@gmail.com)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ProvidesClass{cleancv}
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}

% Packages
\RequirePackage{fontspec}
\RequirePackage{tikz}
\RequirePackage{enumitem}
\RequirePackage[absolute]{textpos}
\RequirePackage{parskip}
\RequirePackage{fontawesome}
\RequirePackage[a4paper]{geometry}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{tabularx}
\RequirePackage{ifthen}

\setmainfont[Ligatures=TeX, UprightFont={* Light}, ItalicFont={* Light
  Italic}, BoldFont={* Regular}, BoldItalicFont={* Italic}]{Lato}

\pagestyle{empty} % no page numbering

% Set the horizontal and vertical units for textpos package.
\setlength{\TPHorizModule}{1cm} 
\setlength{\TPVertModule}{1cm}

% Set the default indentation of items to zero. 
\setlist[itemize]{leftmargin=*}

\definecolor{main}{HTML}{84A9AC}
\definecolor{bg}{HTML}{E7DFD5}
\definecolor{dark}{HTML}{204051}
\definecolor{light}{HTML}{5F5F5F}

%\pagecolor{bg}
%\color{dark}

\setlength{\tabcolsep}{0pt}

\newlength\imagewidth
\pgfmathsetlength{\imagewidth}{3cm}
\newlength\imagescale
\pgfmathsetlength{\imagescale}{\imagewidth/600}

\newlength\panelheight
\pgfmathsetlength{\panelheight}{5cm}
\newlength\topheight
\pgfmathsetlength{\topheight}{\panelheight+1cm}
\newlength\cvdescriptionwidth
\pgfmathsetlength{\cvdescriptionwidth}{10cm}
\newlength\interspace
\setlength\interspace{1em}

\newlength\halfcvlength
\pgfmathsetlength{\halfcvlength}{\cvdescriptionwidth-\interspace}
\pgfmathsetlength{\halfcvlength}{\halfcvlength/2}

\def\barstart{14.5}
\def\barwidth{5}
\newlength\barwidthlength
\pgfmathsetlength{\barwidthlength}{\barwidth*\TPHorizModule}
\newlength\barplength
\pgfmathsetlength{\barplength}{\barwidthlength-0.8cm}


\geometry{margin=2cm, top=\topheight, bottom=0cm, nohead, nofoot}


% Convenience command
\newcommand{\newrenew}[2]{\newcommand{#1}[1]{\renewcommand{#1}{#2}}}

\newrenew{\cvpicture}{#1}
\newrenew{\firstname}{\textbf{\Huge\MakeUppercase{#1}}}
\newrenew{\lastname}{{\textbf{\Huge\MakeUppercase{#1}}}}
\newrenew{\jobtitle}{{\Large\MakeUppercase{#1}}}
\newrenew{\phone}{\faPhone & #1}
\newrenew{\email}{\faEnvelope & \href{mailto:#1}{#1}}
\newrenew{\linkedin}{\faLinkedin & \href{https://#1}{#1}}
\newrenew{\github}{\faGithub & \href{https://#1}{#1}}
\newrenew{\webpage}{\faGlobe & \href{https://#1}{#1}}
\newrenew{\location}{\faMapMarker &
  \href{https://google.com/maps/search/#1}{#1}}

\newcommand{\makebar}{
  \begin{textblock}{1}[0,1](0,0)
    \begin{tikzpicture}[overlay]
      \node[rectangle,
      fill=main,
      anchor=north west,
      minimum width=\paperwidth,
      minimum height=\panelheight]
      (box) at (0,0){};
    \end{tikzpicture}
  \end{textblock}
}

\newcommand{\makepicture}{
  \begin{textblock}{4}(2,1)
    \begin{tikzpicture}[x=\imagescale, y=-\imagescale]
      \clip (600/2, 600/2) circle (600/2);
      \node[anchor=north west, inner sep=0pt, outer sep=0pt] at (0,0) 
      {\includegraphics[width=\imagewidth]{\cvpicture }};
    \end{tikzpicture}
  \end{textblock}
}

\newcommand{\makenames}{
  \begin{textblock}{6.8}(6,1.5)
  {\firstname} \vspace{1em}\newline 
  {\lastname} \vspace{1em}\newline
  {\jobtitle}
  \end{textblock}
}

\newcommand{\makeinfo}{
  \begin{textblock}{\barwidth}(\barstart,1.5)
    \begin{tabular}{c@{\hspace{1em}}l}
      \phone\\ \email\\ \linkedin\\ \github\\ \webpage\\ \location
    \end{tabular}
  \end{textblock}
}


\newcommand{\makeheader}{
  \makebar
  
  \makepicture

  \makenames
  
  \makeinfo
}

% Specification for different text elements
\newcommand{\bodytext}[1]{\small\color{light}#1}
\newcommand{\titletext}[1]{\large\MakeUppercase{#1}}
\newcommand{\subtitletext}[1]{\textbf{\MakeUppercase{\small#1}}}
\newcommand{\subsubtitletext}[1]{\footnotesize#1}


% Environment for main sections of CV.
\newenvironment{cvsection}[2]{
  \begin{tabular}{p{0cm}@{\hspace{1.5em}}c@{\hspace{1.5em}}p{\cvdescriptionwidth}l}
    & \makebox[0ex][c]{\titletext{#1}} & \titletext{#2} & \vspace{1em} \\
}
{\end{tabular}}

% Environment for right section of CV
% TODO: Create a length parameter for width of rightsection that is
% also used for contact info.
\newenvironment{rightsection}{
  \begin{textblock}{\barwidth}(\barstart,6)
}{\end{textblock}}

\newenvironment{renv}[2]{
  \begin{tabular*}{\barwidthlength}{p{0.3cm}@{\hspace{0.5cm}}p{\barplength}r}
    \titletext{#1} & \titletext{#2} &\vspace{1em}\\
}{\vspace{1cm}\end{tabular*}}
  
% Quickly create new environments.
\newcommand{\newcvsec}[4][cvsection]{
  \newenvironment{#2}{\begin{#1}{#3}{#4}}{\end{#1}}
}

\newcvsec{profilesec}{\faUser}{Profile}
\newcvsec{edusec}{\faGraduationCap}{Education}
\newcvsec{expsec}{\faSuitcase}{Experience}
\newcvsec{prosec}{\faLightbulbO}{Projects}
\newcvsec{volsec}{\faSigning}{Volunteer experience}

\newcvsec[renv]{langsec}{\faFlag}{Languages}
\newcvsec[renv]{academic}{\faBarChart}{Academic skills}
\newcvsec[renv]{refsec}{ }{References}
\newcvsec[renv]{personal}{\faUsers}{Personal skills}
\newcvsec[renv]{itskills}{\faCode}{IT Skills}
\newcvsec[renv]{certificates}{\faCertificate}{Certificates}

\newcommand{\profile}[1]{
  \begin{profilesec}
    &&\parbox{\cvdescriptionwidth}{\bodytext{#1}}&\vspace{1cm}\\
  \end{profilesec}
}


\newcommand{\linedot}[1]{
  \tikz[overlay, baseline=(char.base), node distance=#1]
  {\node (char) {\large •};
    \node[above of=char] (a){};
    \draw[line width=0.2mm, line cap=round, color=light] (a) -- (char.north);}
}

\newcommand{\cvitem}[6][2em]{%
  % Year
  \makebox[0ex][r]{\bodytext{\scriptsize#2}}&\linedot{#1}&
  % Title
  \subtitletext{#3} & \\
  % Institution
  & & \subsubtitletext{at \textbf{#4}} &
  % Location 
  \makebox[0ex][r]{\subsubtitletext{\faMapMarker\ #5}}\vspace{1ex}\\
  % Description
  & & \parbox{\cvdescriptionwidth}{\bodytext{#6}} & \vspace{1cm}\\
}

\newcommand{\skillitem}[3]{
  \makebox[1pt][l]{\subsubtitletext{\textbf{#1}}} & &
  \makebox[0pt][r]{#2}\vspace{1ex}\\
  \makebox[0pt][l]{\parbox{\barwidthlength}{\bodytext{\scriptsize#3}}} & &\vspace{1em}\\
}

\newcommand{\hardskill}[3]{\skillitem{#1}{\proficiency{#2}}{#3}}
\newcommand{\softskill}[2]{\skillitem{#1}{}{#2}}

% TODO: Correct the \halfcvdesc length to take the hspace between
% columns into account.

\newcommand{\projectlayout}[4]{%
  \begin{tabular}{p{\halfcvlength}@{\hspace{\interspace}}p{\halfcvlength}}
    \subtitletext{#1} &\subtitletext{#3}\\
    \parbox[t]{\halfcvlength}{\bodytext{\footnotesize\raggedright#2}}&
    \parbox[t]{\halfcvlength}{\bodytext{\footnotesize\raggedright#4}}
  \end{tabular}
}

\newcommand{\projectitem}[4]{&&\projectlayout{#1}{#2}{#3}{#4}&}
\newcommand{\proficiency}[1]{%
  \begin{tikzpicture}[baseline=(char.base), scale=0.3]
    \useasboundingbox (0.5,-0.5) rectangle (5.3,0.5);
    \foreach \x in {1,...,#1}{
      \node[text=main] at (\x,0) (char) {\scriptsize\faCircle};
    }
    \ifthenelse{#1<5}{
      \def\mynum{#1}
      \pgfmathtruncatemacro{\mynum}{\mynum + 1}
      \foreach \x in {\mynum,...,5}{
      \node[text=light] at (\x,0) {\scriptsize\faCircle};
      }
    }{}
 \end{tikzpicture}}
