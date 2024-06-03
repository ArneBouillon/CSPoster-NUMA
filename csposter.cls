%%
%% This is `csposter.cls', a poster template for the Department of Computer Science of KU Leuven, based on `kuposter.cls'
%%
%% Adaptation of the `kuposter.cls' file by Brian Amberg and Reinhold Kainhofer (2011)
%% Improved version of Keith Myerscough' work in December 2016, at https://github.com/KeithWM/kuposter
%% Customized for Department of Computer Science (April 2017)

\ProvidesClass{csposter}[2011/11/26 v2.0 csposter class]
\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\LoadClass{article}

%% Define lengths only once on inclusion, such that we can make multiple posters
\newlength{\baposter@xheight}% the logo height
\newlength{\baposter@xmargin} % the margin as we'd like it to be relative to the logo size
\newlength{\baposter@xborder} % the border as we'd like it to be relative to the logo size
\newlength{\baposter@basepaperwidth}%
\newlength{\baposter@basepaperheight}%
\newlength{\baposter@basemargin}%
\newlength{\baposter@finalpaperwidth}%
\newlength{\baposter@finalpaperheight}%
\newlength{\baposter@finalmargin}%
\newlength{\headerheight}%
\newlength{\footerheight}%
\newlength{\footerfontsize}% PR
\newlength{\colwidth}%
\newlength{\colheight}%
\newlength{\baposter@@colspacing}%
\newlength{\baposter@box@@boxheaderheight}%
\newlength{\baposter@box@@boxpadding}%
\newlength{\boxstartx}%
\newlength{\boxstarty}%
\newlength{\boxwidth}%
\newlength{\boxheight}%
\newlength{\baposter@titleimage@left@width}%
\newlength{\baposter@titleimage@right@width}%
\newlength{\baposter@titleimage@textwidth}%
\newbox\baposter@box@content%
\newbox\baposter@titleimage@left%
\newbox\baposter@titleimage@title%
\newbox\baposter@titleimage@right%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Packages
%-------------------------------------------------------------------------------
% The only ``weird'' dependency of this package is pgf. All the rest should be
% installed on any decent system.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\typeout{Use Packages}
\RequirePackage{xkeyval}
\RequirePackage{calc}
\RequirePackage[cmyk]{xcolor}
%\RequirePackage[dvipdfmx]{graphicx}
%\RequirePackage{bmpsize}
\RequirePackage{tikz}
\RequirePackage{pgf}
\RequirePackage{ifthen}
\RequirePackage[T1]{fontenc}
%\RequirePackage[l2tabu, orthodox]{nag}
\usetikzlibrary{decorations}
\usetikzlibrary{fadings}
\usetikzlibrary{decorations}
\usetikzlibrary{calc}
\RequirePackage{enumitem}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Settings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Choose a smaller value for larger fonts
\newcommand{\baposter@fontscale}{0.35}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Zoom
%-------------------------------------------------------------------------------
% We scale the page from fontscale * papersize up to papersize
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Paper sizes
\newif\if@landscape
\newif\if@cslandscape % PR
\newif\if@geometryKnowsThisSize
\DeclareOptionX{landscape}{\@landscapetrue}
\DeclareOptionX{portrait}{}

\newcommand{\baposter@setfinalpapersize}[2]{%
\if@geometryKnowsThisSize
  \setlength{\baposter@finalpaperwidth}{#1}%
  \setlength{\baposter@finalpaperheight}{#2}%
\else
\if@landscape
% Transpose length, if geometry does not handle the papersize based on the key
  \setlength{\baposter@finalpaperwidth}{#2}%
  \setlength{\baposter@finalpaperheight}{#1}%
\else
  \setlength{\baposter@finalpaperwidth}{#1}%
  \setlength{\baposter@finalpaperheight}{#2}%
\fi
\fi
}


% Default paperwidth and paperheight = a0paper
\DeclareOptionX{paperwidth}[841mm]{\setlength{\baposter@finalpaperwidth}{#1}}
\DeclareOptionX{paperheight}[1189mm]{\setlength{\baposter@finalpaperheight}{#1}}
\DeclareOptionX{archA}         {                           \baposter@setfinalpapersize{9in}{12in}}%
\DeclareOptionX{archB}         {                           \baposter@setfinalpapersize{12in}{18in}}%
\DeclareOptionX{archC}         {                           \baposter@setfinalpapersize{18in}{24in}}%
\DeclareOptionX{archD}         {                           \baposter@setfinalpapersize{24in}{36in}}%
\DeclareOptionX{archE}         {                           \baposter@setfinalpapersize{36in}{48in}}%
\DeclareOptionX{archE1}        {                           \baposter@setfinalpapersize{30in}{42in}}%
\DeclareOptionX{archE2}        {                           \baposter@setfinalpapersize{26in}{38in}}%
\DeclareOptionX{archE3}        {                           \baposter@setfinalpapersize{27in}{39in}}%
\DeclareOptionX{a0paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{841mm}{1189mm}}%g
\DeclareOptionX{a1paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{594mm}{841mm}}%g
\DeclareOptionX{a2paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{420mm}{594mm}}%g
\DeclareOptionX{a3paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{297mm}{420mm}}%g
\DeclareOptionX{a4paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{210mm}{297mm}}%g
\DeclareOptionX{a5paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{148mm}{210mm}}%g
\DeclareOptionX{a6paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{105mm}{148mm}}%g
\DeclareOptionX{b0paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{1000mm}{1414mm}}%g
\DeclareOptionX{b1paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{707mm}{1000mm}}%g
\DeclareOptionX{b2paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{500mm}{707mm}}%g
\DeclareOptionX{b3paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{353mm}{500mm}}%g
\DeclareOptionX{b4paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{250mm}{353mm}}%g
\DeclareOptionX{b5paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{176mm}{250mm}}%g
\DeclareOptionX{b6paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{125mm}{176mm}}%g
\DeclareOptionX{ansiapaper}    {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{8.5in}{11in}}%
\DeclareOptionX{ansibpaper}    {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{11in}{17in}}%
\DeclareOptionX{ansicpaper}    {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{17in}{22in}}%
\DeclareOptionX{ansidpaper}    {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{22in}{34in}}%
\DeclareOptionX{ansiepaper}    {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{34in}{44in}}%
\DeclareOptionX{letterpaper}   {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{8.5in}{11in}}%
\DeclareOptionX{legalpaper}    {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{8.5in}{14in}}%
\DeclareOptionX{executivepaper}{\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{7.25in}{10.5in}}%
\DeclareOptionX{screen}        {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{225mm}{180mm}}%
\DeclareOptionX{cs_portrait}        {\baposter@setfinalpapersize{600mm}{800mm}}% PR added
\DeclareOptionX{cs_landscape}        {\baposter@setfinalpapersize{800mm}{600mm}\@landscapetrue\@cslandscapetrue}% PR added

\DeclareOptionX{xheight}   [30 mm]{\setlength{\baposter@xheight}{#1}}
\DeclareOptionX{fontscale}[0.55]{\renewcommand{\baposter@fontscale}{#1}}

% move text/poster body to the right (or to the left if negative) 
% Not sure why this option is desirable -- KWM
\newlength{\baposter@movebody}
\setlength{\baposter@movebody}{0cm}
\DeclareOptionX{movebody}[0cm]{\setlength{\baposter@movebody}{#1}}


\newif\if@debug
\DeclareOptionX{debug}{\@debugtrue}
%% Will be passed on to other packages (xcolor and geometry), still we don't want unused warnings
\DeclareOptionX{table}{}
\DeclareOptionX{showframe}{}

\ProcessOptionsX

\if@debug
\newcommand{\debug}[1]{\typeout{#1}}
\else
\newcommand{\debug}[1]{}
\fi


% heights that follow from the house style (defined early on so we may use them later too.
% the logo height is specified as a fraction of the paperwidth such that it is 30 mm in A0 portrait/A1 landscape
\if@landscape
  \setlength{\baposter@xheight}{0.0356\baposter@finalpaperwidth} % 30 mm can be interpreted as a maximum size in the house style, even if not explicitly stated
\else
  \setlength{\baposter@xheight}{0.0356\baposter@finalpaperheight} % 30 mm can be interpreted as a maximum size in the house style, even if not explicitly stated
\fi
\setlength{\baposter@xheight}{0.0356\baposter@finalpaperheight}
%% PR ADDED
\if@cslandscape
  \setlength{\baposter@xheight}{0.0356\baposter@finalpaperwidth}
\fi
% measure from width if cs_landscape

%%
%\setlength{\baposter@xheight}{0.0356\baposter@finalpaperheight} % 30 mm can be interpreted as a maximum size in the house style, even if not explicitly stated
%\setlength{\baposter@xheight}{30mm} % 30 mm can be interpreted as a maximum size in the house style, even if not explicitly stated
\typeout{xheight: \the\baposter@xheight}

% Margin
\setlength{\baposter@xmargin}{\baposter@xheight/4} % the margin as we'd like it to be relative to the logo size
\setlength{\baposter@xborder}{\baposter@xheight/10} % the margin as we'd like it to be relative to the logo size
\setlength{\baposter@finalmargin}{11\baposter@xmargin/5}

\setlength{\baposter@xheight}        {\baposter@fontscale\baposter@xheight}
\setlength{\baposter@xmargin}        {\baposter@fontscale\baposter@xmargin}
\setlength{\baposter@xborder}        {\baposter@fontscale\baposter@xborder}
\setlength{\baposter@basepaperwidth} {\baposter@fontscale\baposter@finalpaperwidth}
\setlength{\baposter@basepaperheight}{\baposter@fontscale\baposter@finalpaperheight}
\setlength{\baposter@basemargin}     {\baposter@fontscale\baposter@finalmargin}
\newlength{\baposter@basemarginright}
\setlength{\baposter@basemarginright}{\baposter@basemargin}
\addtolength{\baposter@basemarginright}{-\baposter@fontscale\baposter@movebody}
\newlength{\baposter@basemarginleft}
\setlength{\baposter@basemarginleft}{\baposter@basemargin}
\addtolength{\baposter@basemarginleft}{\baposter@fontscale\baposter@movebody}
\setlength{\headerheight}{5\baposter@xheight}
\setlength{\baposter@box@@boxpadding}{6\baposter@xmargin/5}
\setlength{\footerheight}{1.25\baposter@xheight} % only comes into play if there IS a footer (will be measured, hopefully)

\setlength{\footerfontsize}{0.2\baposter@xheight} % PR

% Itemize and enumerate environments
\setlist[itemize]{labelindent=0em,labelwidth=0.5em,labelsep*=0.5em,leftmargin=!,itemindent=.0em,label=$\tikz{\filldraw (0,0)--(.5em,0)--(.5em,.5em)--(0,.5em)--cycle}$} % the draw and cycle are important to make it line up exactly % squar%e
\setlist[enumerate]{nosep,labelindent=0em,labelwidth=0.5em,labelsep*=0.5em,leftmargin=!,itemindent=.0em} % the draw and cycle are important to make it line up exactly % squar%e
\setlist[description]{itemsep=0.25em, font=\sffamily\bfseries, leftmargin=0cm}
\newlist{noindentitemize}{itemize}{5}
\setlist[noindentitemize]{nosep,labelindent=0em,labelwidth=0.5em,labelsep*=0.5em,leftmargin=!,itemindent=.0em,label=$\tikz{\filldraw (0,0)--(.5em,0)--(.5em,.5em)--(0,.5em)--cycle}$} % the draw and cycle are important to make it line up exactly % squar%e
%\setlist[noindentitemize,0]{itemsep=.0em,labelwidth=2\baposter@xborder,labelindent=-\baposter@box@@boxpadding-.5\baposter@xborder,leftmargin=0pt,itemindent=0pt,labelsep=!,label=$\tikz{\fill[borderColor] (0,0)--(\baposter@xborder,\baposter@xborder)--(0,2\baposter@xborder)--cycle;}$} % right angle arror
%\setlist[noindentitemize,0]{itemsep=.01em,labelwidth=0.5em,labelindent=-\baposter@box@@boxpadding + 0.5em,leftmargin=0pt,itemindent=.0em,labelsep=!,label={}} % no bullet?
%\setlist[noindentitemize,0]{itemsep=.01em,labelwidth=0.5em,labelindent=-\baposter@box@@boxpadding + 0.5em,leftmargin=0pt,itemindent=.0em,labelsep=!,label=$\tikz{\filldraw[borderColor] (0,0)--(.5em,0em)--(.5em,.5em)--(0,.5em)--cycle;}$} % the draw and cycle are important to make it line up exactly % squar%e
%\setlist[noindentitemize,0]{itemsep=.0em,labelwidth=2\baposter@xborder,labelindent=-\baposter@box@@boxpadding-.5\baposter@xborder,leftmargin=0pt,itemindent=0pt,labelsep=!,label=$\tikz{\fill[borderColor] (0,0)--(\baposter@xborder,0)--(\baposter@xborder,\baposter@xborder)--(0,\baposter@xborder)--cycle;\fill[boxColorOne] (0,\baposter@xborder)--(-\baposter@xborder,\baposter@xborder)--(-\baposter@xborder,1.5\baposter@xborder)--(0,1.5\baposter@xborder)--cycle;}$} % hookbullet
\setlist[noindentitemize,0]{itemsep=.0em,labelwidth=2\baposter@xborder,labelindent=-\baposter@box@@boxpadding+.25\baposter@xborder,leftmargin=0pt,itemindent=0pt,labelsep=!,label=$\tikz{\fill[borderColor] (0,0)--(\baposter@xborder,0)--(\baposter@xborder,\baposter@xborder)--(0,\baposter@xborder)--cycle;}$} % borderColor square with an interrupted border
%\setlist[noindentitemize,0]{itemsep=.0em,labelwidth=2\baposter@xborder,labelindent=-\baposter@box@@boxpadding-.5\baposter@xborder,leftmargin=0pt,itemindent=0pt,labelsep=!,label=$\tikz{\fill[borderColor] (0,0)--(\baposter@xborder,0)--(\baposter@xborder,\baposter@xborder)--(0,\baposter@xborder)--cycle;\fill[white] (0,0)--(-\baposter@xborder,0)--(-\baposter@xborder,\baposter@xborder)--(0,\baposter@xborder)--cycle;}$} % borderColor square with an interrupted border
%\setlist[noindentitemize,0]{itemsep=.01em,labelwidth=0.5em,labelindent=-\baposter@box@@boxpadding + 0.25em,leftmargin=0pt,itemindent=.0em,labelsep=!,label=$\tikz{\filldraw[borderColor] (0,0)--(.5em,0em)--(.5em,.5em)--(0,.5em)--cycle;}$} % the draw and cycle are important to make it line up exactly % squar%e
%\setlist[noindentitemize,0]{itemsep=.01em,labelwidth=0.5em,labelindent=-\baposter@box@@boxpadding + 0.25em,leftmargin=0pt,itemindent=.0em,labelsep=!,label=$\tikz{\filldraw[borderColor] (0,0)--(.5em,0em)--(.5em,.5em)--(0,.5em)--cycle;}$} % the draw and cycle are important to make it line up exactly % squar%e

% For some reason, these values are transposed for landscape posters...
\typeout{Paperwidth=\the\baposter@finalpaperwidth}
\typeout{Paperheight=\the\baposter@finalpaperheight}
\typeout{BasePaperwidth=\the\baposter@basepaperwidth}
\typeout{BasePaperheight=\the\baposter@basepaperheight}
\usepackage[
   paperwidth=\baposter@basepaperwidth,
   paperheight=\baposter@basepaperheight,
   tmargin=\baposter@basemargin,
   bmargin=\baposter@basemargin,
   lmargin=\baposter@basemarginleft,
   rmargin=\baposter@basemarginright,
   ]{geometry} 

\usepackage{pgfpages}
\if@landscape
\if@geometryKnowsThisSize
\pgfpagesuselayout{resize to}[physical paper width=\baposter@finalpaperheight,physical paper height=\baposter@finalpaperwidth]
\else
\pgfpagesuselayout{resize to}[physical paper width=\baposter@finalpaperwidth,physical paper height=\baposter@finalpaperheight]
\fi
\else
\pgfpagesuselayout{resize to}[physical paper width=\baposter@finalpaperwidth,physical paper height=\baposter@finalpaperheight]
\fi



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Default functions for borders/backgrounds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% These functions will all be redefined from the actual option values. In
%% particular, they will be set to \baposter@optionname@optionvalue, which
%% should do the actual work / setting for that particular optionvalue.

\newcommand{\baposterPosterDrawBackground}[2]{} % Draw poster background

\newcommand{\baposterBoxGetShape}{}             % Returns path of text box shape
\newcommand{\baposterBoxDrawBackground}[2]{}    % Draw bg of boxes
\newcommand{\baposterBoxDrawBorder}[1]{}        % Draw border of individual boxes

\newcommand{\baposterHeaderGetShape}{}          % Returns path of text box shape
\newcommand{\baposterHeaderSetShade}[3]{}       % Set bg style for box headers
\newcommand{\baposterHeaderDrawBackground}[3]{} % Draw background of box header
\newcommand{\baposterHeaderDrawBorder}[1]{}     % Draw border of box header
\newcommand{\baposterHeaderDrawText}[1]{}       % Draw text inside box header

\newcommand{\@@previousbox}{notset}             % stores the previously processed box for below=auto

% Function to set a user-defined background
\newcommand{\baposter@backgroundCmd}{
}
\newcommand{\background}[1]{\renewcommand{\baposter@backgroundCmd}{#1}}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Handle poster and box options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\debug{Handling keys}

%%
%% POSTER OPTIONS
%%
%% Store all poster options in variables of the form \baposter@option
%% choose-keys also store the index in \baposter@optionnr
%% choose-keys typically also assign a function
\definecolor{baposter@silver}{cmyk}{0,0,0,0.7}
\define@cmdkey[ba]{poster}[baposter@]{dutch}                 [false]       {}
\define@cmdkey [ba]{poster}[baposter@]{columns}              [{}]          {}
\define@cmdkey [ba]{poster}[baposter@]{bgColorOne}           [baposter@silver]{}
\define@cmdkey [ba]{poster}[baposter@]{bgColorTwo}           [green]       {}
\define@cmdkey [ba]{poster}[baposter@]{titleFontColor}       [white]       {}
\define@cmdkey [ba]{poster}[baposter@]{titleBelow}           [false]       {}
\define@cmdkey [ba]{poster}[baposter@]{font}                 [{}]       {}
\define@cmdkey [ba]{poster}[baposter@]{Faculteit}            [Ingenieurswetenschappen]{}

% background can be one of: shadeLR, shadeTB, plain, user, none
\define@choicekey*+[ba]{poster}{background}%
    [\baposter@background\baposter@backgroundnr]%
    {shadeLR, shadeTB, plain, user, none} [plain] {%
  \debug{Poster background: \baposter@background}
  \renewcommand{\baposterPosterDrawBackground}[2]{
      \csname baposter@background@\baposter@background\endcsname{##1}{##2}}
}{
  \PackageWarning{baposter}{Unknown background `\baposter@background' (use
      shadeLR, shadeTB, plain, none, or user). If user is used, you also
      have to define \background{...}.}
  \renewcommand{\baposterPosterDrawBackground}[2]{\baposter@background@none{##1}{##2}}
}


%%
%%  BOX OPTIONS
%%
\define@cmdkey[ba]{posterbox}[baposter@box@]{boxheaderheight}       [2em]         {}


% textborder can be one of: none, bars, coils, triangles, rectangle, rounded, hook,onlyleft, hookbox, onlytop
% roundedleft, roundedsmall, faded; UNIMPLEMENTED: roundedright
\edef\baposter@box@textborder@validvalues{none,bars,coils,triangles,open, rectangle,rounded,roundedleft,roundedsmall,faded, hook,onlyleft, hookbox,onlytop}
\define@choicekey*+[ba]{posterbox}{textborder}%
    [\baposter@box@textborder\baposter@box@textbordernr]%
    {none,bars,coils,triangles,open,rectangle,rounded,roundedleft,roundedright,roundedsmall,faded,hook,onlyleft,onlytop,hookbox} [hook] {%
  \debug{Text border: \baposter@box@textborder}
  \renewcommand{\baposterBoxGetShape}{
      \csname baposter@box@boxshape@\baposter@box@textborder\endcsname}
  \renewcommand{\baposterBoxDrawBorder}[1]{
      \csname baposter@box@drawborder@\baposter@box@textborder\endcsname{##1}}
}{
  \PackageWarning{baposter}{Unknown text-border style `\baposter@box@textborder'.
      Edit your file to choose a valid option (\baposter@box@textborder@validvalues).}
  \renewcommand{\baposterBoxGetShape}{\baposter@boxshape@rectangle}
  \renewcommand{\baposterBoxDrawBorder}[1]{\baposter@drawborder@rectangle{##1}}
}

% boxshade can be one of: shadeLR, shadeTB, plain, none
\define@choicekey*+[ba]{posterbox}{boxshade}%
    [\baposter@box@boxshade\baposter@box@boxshadenr]%
    {shadelr,shadetb,plain,none} [none] {%
  \debug{Box shade: \baposter@box@boxshade}
  \renewcommand{\baposterBoxDrawBackground}[2]{
      \csname baposter@box@drawbackground@\baposter@box@boxshade\endcsname{##1}{##2}}
}{
  \PackageWarning{baposter}{Unknown boxshade style `\baposter@boxshade'.
      Edit your file to choose a valid option.}
  \renewcommand{\baposterBoxDrawBackground}[2]{\baposter@box@drawbackground@none{##1}{##2}}
}

% headershade can be one of: shade-lr, shade-tb, shade-tb-inverse, plain
\define@choicekey*+[ba]{posterbox}{headershade}%
    [\baposter@box@headershade\baposter@box@headershadenr]%
    {shadelr, shadetb, shadetbinverse, plain} [shadelr] {%
  \debug{Header shade: \baposter@box@headershade}
  \renewcommand{\baposterHeaderSetShade}[3]{
      \csname baposter@box@headershade@\baposter@box@headershade\endcsname{##1}{##2}{##3}}
}{
  \PackageWarning{baposter}{Unknown headershade style `\baposter@box@headershade'.
      Edit your file to choose a valid option.}
  \renewcommand{\baposterHeaderSetShade}[3]{\baposter@box@headershade@none{##1}{##2}{##3}}
}

% headershape can be one of: rectangle, rounded, smallrounded, roundedleft, roundedright
\define@choicekey*+[ba]{posterbox}{headershape}%
    [\baposter@box@headershape\baposter@box@headershapenr]%
    {rectangle,rounded,smallrounded,roundedleft,roundedright} [roundedright] {%
  \debug{Header shape: \baposter@box@headershape}
  \renewcommand{\baposterHeaderGetShape}{
      \csname baposter@box@headershape@\baposter@box@headershape\endcsname}
  \renewcommand{\baposterHeaderDrawText}[1]{
      \csname baposter@box@headerdrawtext@\baposter@box@headershape\endcsname{##1}}
  \renewcommand{\baposterHeaderDrawBorder}[1]{
      \csname baposter@box@headerdrawborder@\baposter@box@headershape\endcsname{##1}}
}{
  \PackageWarning{baposter}{Unknown headershape style `\baposter@headershape'.
      Edit your file to choose a valid option.}
  \renewcommand{\baposterHeaderGetShape}{\baposter@box@headershape@rectangle}
  \renewcommand{\baposterHeaderDrawText}[1]{\baposter@box@headerdrawtext@rectangle{##1}}
  \renewcommand{\baposterHeaderDrawBorder}[1]{\baposter@box@headerdrawborder@rectangle{##1}}
}

% headerborder can be one of: open, closed, none
\define@choicekey*+[ba]{posterbox}{headerborder}%
    [\baposter@box@headerborder\baposter@box@headerbordernr]%
    {open,closed,none,hook} [hook] {%
  \debug{Header border: \baposter@box@headerborder}
%   \renewcommand{\baposterHeaderBorder}{
%       \csname baposter@headerborder@\baposter@box@headerborder\endcsname}
}{
  \PackageWarning{baposter}{Unknown headerborder style `\baposter@headerborder'.
      Edit your file to choose a valid option.}
%   \renewcommand{\baposterHeaderBorder}{\baposter@box@headerborder@rectangle}
}


\define@cmdkey[ba]{posterbox}[baposter@box@]{borderColor}           [KULeuvenFaculteit]      {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{headerColorOne}        [KULeuvenFaculteit] {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{headerColorTwo}        [brown]       {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{headerBorderColor}     [brown]       {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{headerFontColor}       [black]       {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{boxColorOne}           [magenta]     {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{boxColorTwo}           [cyan]        {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{headerFont}            [\scshape\Large]   {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{textfont}              [\helvetica]          {}

\define@cmdkey[ba]{posterbox}[baposter@box@]{linewidth}             [3pt]         {}

\define@cmdkey[ba]{posterbox}[baposter@box@]{below}  [notset]{}
\define@cmdkey[ba]{posterbox}[baposter@box@]{above}  [notset]{}
\define@cmdkey[ba]{posterbox}[baposter@box@]{aligned}[notset]{}
\define@cmdkey[ba]{posterbox}[baposter@box@]{bottomaligned}[notset]{}
\define@cmdkey[ba]{posterbox}[baposter@box@]{column} [0]     {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{row}    [0]     {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{span}   [1]     {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{height} [auto]  {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{name}   [noname]{}

% Set some default values, the poster and posterbox environments can override:
\setkeys[ba]{poster}{
  % Debug grid
  %PR removed grid=false,
  dutch=false,
  columns={},
  % Colours
  bgColorOne=baposter@silver,
  bgColorTwo=green,
  titleFontColor=black,
  titleBelow=true,
  %
  font=\helvetica,
  background=shadeLR,
  Faculteit=DeptCS
}{}
\setkeys[ba]{posterbox}{
  % Position
  column=0,row=0,span=1,
  below=notset,above=notset,
  bottomaligned=notset,
  aligned=notset,
  height=auto,
  % Name
  name=noname,
  % Box design: border:
  linewidth=\baposter@xheight/18,
  borderColor=KULeuvenLichtblauw,
  % text box:
  textfont=\sffamily,
  boxshade=plain,
  boxColorOne=white,
  boxColorTwo=cyan,
  textborder=rectangle,%none,%rectangle, %% for now, hook only gives a useful result with NO BACKGROUND
  % header
  headerFont=\baposter@font\Large\bfseries,% or headerFont=\color{white}\textsf\textbf
  headerFontColor=black,%white,
  headerColorOne=white,%KULeuvenLichtblauw,%Blauw,%white,%KULeuvenBlauw,%KULeuvenFaculteit!20!white,
  headerColorTwo=brown,
  headerBorderColor=white,%KULeuvenLichtblauw,
  headershape=rectangle,
  headershade=plain,
  headerborder=open,
  boxheaderheight=2.5em,
}{}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Background options and functions (one function for each possible value)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\definecolor{KULeuvenBlauw}{cmyk}{1.00,.64,.00,.38}
\definecolor{KULeuvenLichtblauw}{cmyk}{.59,.07,.00,.00}
\definecolor{KULeuvenSecundair}{cmyk}{.65,.00,.00,.35}
\definecolor{KULeuvenWetenschappen}{cmyk}{.42,.02,1.00,.00}
\definecolor{KULeuvenIngenieurswetenschappen}{cmyk}{.00,.70,1.00,.00}
\definecolor{KULeuvenDeptCS}{cmyk}{.65,.00,.00,.35}
\definecolor{KULeuvenBioingenieurswetenschappen}{cmyk}{0.40,.00,1.00,.38}
\definecolor{KULeuvenRechtsgeleerdheid}{cmyk}{.00,1.00,.65,.18}
%\definecolor{KULeuvenFaculteit}{RGB}{243,112,34} % a slightly off colour to match the paper aeroplane image...
%\definecolor{KULeuvenFaculteit}{cmyk}{0,0.54,.86,.05} % a slightly off colour to match the paper aeroplane image...
\definecolor{KULeuvenFaculteit}{cmyk}{.00,.70,1.00,.00}%{KULeuvenIngenieurswetenschappen}


\newcommand{\baposter@background@user}[2]{
  \debug{BAPOSTER: Using user background.}
  \baposter@backgroundCmd%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Return shape path of text box (depending on the box shape)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\baposter@box@boxshape@none}{\baposter@box@boxshape@rectangle}
\newcommand{\baposter@box@boxshape@bars}{
  (\baposter@box@name tnw) -- (\baposter@box@name sw) %
  (\baposter@box@name se) -- (\baposter@box@name tne)
}
\newcommand{\baposter@box@boxshape@coils}{\baposter@box@boxshape@bars}
\newcommand{\baposter@box@boxshape@triangles}{\baposter@box@boxshape@bars}
\newcommand{\baposter@box@boxshape@open}{
  (\baposter@box@name tnw) -- (\baposter@box@name sw) -- %
  (\baposter@box@name se) -- (\baposter@box@name tne)%
}
\newcommand{\baposter@box@boxshape@rectangle}{
  (\baposter@box@name tnw) -- (\baposter@box@name sw) -- %
  (\baposter@box@name se) -- (\baposter@box@name tne) -- cycle%
}
\newcommand{\baposter@box@boxshape@faded}{
  (\baposter@box@name tnw) -- (\baposter@box@name sw) %
  (\baposter@box@name tne) -- (\baposter@box@name se)
  }
\newcommand{\baposter@box@boxshape@rounded}{
  [rc] \baposter@box@boxshape@rectangle%
}
\newcommand{\baposter@box@boxshape@roundedsmall}{
  [src] \baposter@box@boxshape@rectangle
}
\newcommand{\baposter@box@boxshape@roundedleft}{
  (\baposter@box@name tnw) {[rc]-- (\baposter@box@name sw)} -- %
  (\baposter@box@name se) -- (\baposter@box@name tne)%
}
\newcommand{\baposter@box@boxshape@roundedright}{
  (\baposter@box@name tnw) -- (\baposter@box@name sw) {[rc]-- %
  (\baposter@box@name se)} -- (\baposter@box@name tne)%
}
\newcommand{\baposter@box@boxshape@hook}{
  ([xshift=0.28\baposter@xborder]\baposter@box@name tne) -- (\baposter@box@name tnw) -- (\baposter@box@name sw)
  (\baposter@box@name se) (\baposter@box@name tne) (\baposter@box@name sw)
}
\newcommand{\baposter@box@boxshape@hookbox}{
  (\baposter@box@name tne) -- (\baposter@box@name tnw) -- (\baposter@box@name sw)
  (\baposter@box@name se) (\baposter@box@name tne) (\baposter@box@name sw)
}
\newcommand{\baposter@box@boxshape@onlyleft}{
  (\baposter@box@name tnw) -- (\baposter@box@name sw) (\baposter@box@name se) (\baposter@box@name tne)
}
\newcommand{\baposter@box@boxshape@onlytop}{
  ([xshift=-0.28\baposter@xborder]\baposter@box@name tnw) -- ([xshift=0.28\baposter@xborder]\baposter@box@name tne) (\baposter@box@name se) (\baposter@box@name sw)
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Draw box background (one function for each possible value)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These functions take no arguments
\newcommand{\baposter@box@drawbackground@none}[2]{
  \tikzstyle{box colors}=[fill opacity=0,text opacity=1]
}
\newcommand{\baposter@box@drawbackground@plain}[2]{
		\tikzstyle{box colors}=[fill=#1]
		\fill[box colors] \baposterBoxGetShape;
}
\newcommand{\baposter@box@drawbackground@shadelr}[2]{
  \tikzstyle{box colors}=[shading=axis, left color=#1, right color=#2]%
  \fill[box colors] \baposterBoxGetShape;
}
\newcommand{\baposter@box@drawbackground@shadetb}[2]{
  \tikzstyle{box colors}=[shading=axis, top color=#1, bottom color=#2]%
  \fill[box colors] \baposterBoxGetShape;
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Draw box border
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These functions take two arguments: borderColor
\newcommand{\baposter@box@drawborder@none}[1]{}
\newcommand{\baposter@box@drawborder@bars}[1]{
  \draw[color=#1] \baposterBoxGetShape;%
}
\newcommand{\baposter@box@drawborder@coils}[1]{
  \draw[color=#1,segment amplitude=0.35em,segment length=0.4em,snake=coil] \baposterBoxGetShape;%
}
\newcommand{\baposter@box@drawborder@triangles}[1]{
  \draw[color=#1,segment amplitude=0.2em,segment length=0.4em,snake=triangles] \baposterBoxGetShape;%
}
\newcommand{\baposter@box@drawborder@open}[1]{
  \draw[color=#1] \baposterBoxGetShape;%
}
\newcommand{\baposter@box@drawborder@rectangle}[1]{
  \draw[color=#1] \baposterBoxGetShape;%
}
\newcommand{\baposter@box@drawborder@rounded}[1]{
  \draw[color=#1] \baposterBoxGetShape;%
}
\newcommand{\baposter@box@drawborder@roundedleft}[1]{
  \draw[color=#1] \baposterBoxGetShape;%
}
\newcommand{\baposter@box@drawborder@roundedright}[1]{
  \draw[color=#1] \baposterBoxGetShape;%
}
\newcommand{\baposter@box@drawborder@faded}[1]{
  % This is the right way to do it, but it does not work with evince, and has problems during printing, so instead we do
  %\draw[color=#1,path fading=south] \baposterBoxGetShape;%
  % this
  \foreach \x in {0,1,...,90} \draw[color=#1!\x] ($(\baposter@box@name tnw)!{(100-\x)/100}!(\baposter@box@name sw)$) -- ($(\baposter@box@name tnw)!{(100-(\x+10))/100}!(\baposter@box@name sw)$);%
  \foreach \x in {0,1,...,90} \draw[color=#1!\x] ($(\baposter@box@name tne)!{(100-\x)/100}!(\baposter@box@name se)$) -- ($(\baposter@box@name tne)!{(100-(\x+10))/100}!(\baposter@box@name se)$);%
}
\newcommand{\baposter@box@drawborder@roundedsmall}[1]{
  \draw[color=#1] \baposterBoxGetShape;%
}
\newcommand{\baposter@box@drawborder@hook}[1]{
  \draw[color=#1] \baposterBoxGetShape;%
}
\newcommand{\baposter@box@drawborder@hookbox}[1]{
  \draw[color=KULeuvenBlauw] (\baposter@box@name tne) -- (\baposter@box@name se) -- (\baposter@box@name sw);
  \draw[color=#1, line width=\baposter@xborder] ([xshift=.5\baposter@xborder]\baposter@box@name tne) -- (\baposter@box@name tnw) -- ([yshift=-.5\baposter@xborder]\baposter@box@name sw);%
}
\newcommand{\baposter@box@drawborder@onlyleft}[1]{
  \draw[color=#1] \baposterBoxGetShape;%
}
\newcommand{\baposter@box@drawborder@onlytop}[1]{
  \draw[color=#1] \baposterBoxGetShape;%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Return shape path of text box (depending on the box shape)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These functions take no arguments
% TODO: For headerborder==none, use (\baposter@box@name outer tnw) instead!
\newcommand{\baposter@box@headershape@rectangle}{%
  (\baposter@box@name tnw) -- (\baposter@box@name nw) -- %
  (\baposter@box@name ne) -- (\baposter@box@name tne)%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Header text drawing (one function for each possible value of headershape)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These functions take one argument: the header text
\newcommand{\baposter@box@headerdrawtext@rectangle}[1]{
  \path ($(\baposter@box@name nw)!.5!(\baposter@box@name ne)$) +(0em,-0.5\baposter@box@@boxheaderheight) node[anchor=mid,inner xsep=\baposter@box@@boxpadding,inner ysep=0.4em] {\raisebox{-0.25em}{#1}}% hard-coded central alignment of header text -- KWM
%  \path (\baposter@box@name nw) +(0em,-0.5\baposter@box@@boxheaderheight) node[anchor=west,inner xsep=\baposter@box@@boxpadding,inner ysep=0.4em] {#1}; 
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Header shade options and functions (one function for each possible value)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These functions take two arguments: headerColorOne, headerColorTwo and headerBorderColor
\newcommand{\baposter@box@headershade@shadelr}[3]{
    \debug{Header-Shade: Shade Left - Right}
    \tikzstyle{header colors}=[%
      color=#3,%
      shading=axis,%
      left color=#1,%
      right color=#2%
    ]%
}
\newcommand{\baposter@box@headershade@shadetb}[3]{
    \debug{Header-Shade: Shade Top - Bottom}
    \tikzstyle{header colors}=[%
      color=#3,%
      shading=axis,%
      top color=#1,%
      bottom color=#2%
    ]%
}
\newcommand{\baposter@box@headershade@shadetbinverse}[3]{
    \tikzstyle{header colors}=[%
      top color=#1!75!#2,%
      bottom color=#2!100!#1,%
      shading angle=20%
    ]%
    \colorlet{baposterHeaderFontColor}{white}%
}
\newcommand{\baposter@box@headershade@plain}[3]{
    \debug{Header-Shade: Plain}
    \tikzstyle{header colors}=[%
      color=#3,%
      fill=#1%
    ]%
}
\newcommand{\baposter@box@headershade@none}[3]{
    \debug{Header-Shade: none}
    \tikzstyle{header colors}=[
      fill opacity=0,
      text opacity=1
      ]
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define a macro that will fill the footer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% #1 Personal images, #2 Personal text, #3 Association images, #4 Department name, #5 Department images
\newcommand{\fillfooter}[2]{
  \begin{minipage}[b][\footerheight][c]{.33\paperwidth}
\baposter@font%
	\ifthenelse{\equal{\baposter@dutch}{true}}{
		\includegraphics[height=\footerheight]{images/beeldmerknlDeptCS.png}%
	}{
		\includegraphics[height=\footerheight]{images/beeldmerkDeptCS.png}%
	}
  \hspace{.025\footerheight}%
  \begin{minipage}[b][\footerheight][c]{.2\paperwidth}
  \raggedright%
\baposter@font%
\ifthenelse{\equal{\baposter@dutch}{true}}{
\fontsize{\footerfontsize}{1.2\footerfontsize}\selectfont
KU Leuven\\%
Departement Computerwetenschappen\\%
Celestijnenlaan 200A bus 2402\\%
3001 Leuven, Belgi\"e\\%
}{\fontsize{\footerfontsize}{1.2\footerfontsize}\selectfont
KU Leuven\\%
Department of Computer Science\\%
Celestijnenlaan 200A box 2402\\%
3001 Leuven, Belgium\\%
}
\end{minipage}%
\end{minipage}%

%% FOOTER PART 2 : UNIVERSITIES %%
%  \begin{minipage}[b][\footerheight][c]{.15\paperwidth}
%  \raggedleft
%\baposter@font%
%~%
%  \end{minipage}%
  \hspace{.01\paperwidth}%
  \begin{minipage}[b][\footerheight][c]{.33\paperwidth}
  \centering
\baposter@font%
	#1~%
  \end{minipage}%

	%% FOOTER PART 3 : FUNDING %%
  \begin{minipage}[b][\footerheight][c]{.33\paperwidth}
  \raggedleft%
\baposter@font%
\hspace{.01\paperwidth}
\ifthenelse{\equal{#2}{}}{\includegraphics[height=.8\footerheight]{images/NUMA_logo.jpeg}\hspace{1em}}{#2}
  \end{minipage}%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% The main poster environment
%%% \begin{baposter}{settings}{Eye Catcher}{Title}{Author}{University Logo}
%%%-----------------------------------------------------------------------------
%%% The settings are
%%%   - grid=true,[false]:Show grid to help with alignment
%%%   - colspacing=0.7em: Column spacing
%%%   - columns=4:        number of columns (default 4 in landscape and 3 in portrait format) (maximum number is 6)
%%%   - color=[orange]:   xcolor color definition used as the main color of the poster
%%%   - colortwo=[white]: The other color for gradient based layouts
%%%   - textborder=none,bars,coils,triangles,open,rectangle,rounded,roundedsmall,roundedleft,roundedright,[faded], hook, leftonly
%%%                       The style of the box around the text area
%%%   - headerborder=none,closed,open,hook, hookbox
%%%                       No extra border around box header, full border around box header or border that is open below.
%%%   - headershape=rectangle,rounded,roundedleft,roundedright
%%%                       Shape of the box-header region
%%%   %PR removed% - Faculteit=<Naam van KULeuven Faculteit> speaks for itself (in Dutch)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{poster}[6]{% #1 Options, #2 Title, #3 Authors, #4 Personal images, #5 Personal text, #6 Association text, #7 Association images, #8 Department name, #9 Department images
% PR added: #1 Number of columns, #2 Title, #3 Authors, #4 Association logos, #5  Funding logos, #6 dutch

  \thispagestyle{empty}% Suppress Page Number
  \debug{Poster Starts}%
  % This setkeys call parses all provided options and depending on the option
  % value, assigns different handler functions to the \baposter(Box|Header)*
  % functions. Once that is done, we don't have to care about particular
  % values for border, shading, etc. All we have to do is call the
  % handler functions and let them do their job.
  % This also allows the user to override the poster-wide defaults on a per-box
  % basis.
  %PR removed: we set the default options ourselfs%\setkeys[ba]{posterbox,poster}{#1}%
  \renewcommand{\baposter@columns}{#1} % PR added : #1 is now number of columns!
  \debug{Dutch: \baposter@dutch}
  \renewcommand{\baposter@dutch}{#6} % PR added
%
  % TODO: Move all those assignments to the key macros!
  % Parse Keys%
  \colorlet{bgColorOne}{\baposter@bgColorOne}
  \colorlet{bgColorTwo}{\baposter@bgColorTwo}
  %\colorlet{KULeuvenFaculteit}{KULeuven\baposter@Faculteit}
  % PR added: always use dept CS color
  \colorlet{KULeuvenFaculteit}{KULeuvenDeptCS}
  \colorlet{titleFontColor}{\baposter@titleFontColor}
%
  %% Boxes%
  \setlength{\colheight}{\textheight-\headerheight-\footerheight+\baposter@basemargin}% I add one margin, as it seems superfluous to have a margin at the top near the authors -- KWM
  \renewcommand{\@@previousbox}{notset}

  % a function to measure the available space
  \makeatletter
  \newcommand{\measureheaderfooter}{ % 
    \pgfextracty{\@tempdima}{\pgfpointdiff{\pgfpointanchor{authors}{south west}}
    {\pgfpointanchor{current page}{north west}}}
    \global\headerheight=\@tempdima
    \pgfextracty{\@tempdima}{\pgfpointdiff{\pgfpointanchor{footer}{south west}}
    {\pgfpointanchor{footer}{north west}}}
    \global\footerheight=\@tempdima
    \setlength\@tempdima{\textheight-\headerheight-\footerheight+\baposter@basemargin}
    \global\colheight=\@tempdima%
  }
  \makeatother

  \debug{Format}%
  % Set default for columns if unset (4 for landscape, 3 for portrait)
  \ifthenelse{\equal{\baposter@columns}{}}{%
    \renewcommand{\baposter@columns}{\if@landscape4\else3\fi}%
  }{}
%
  \debug{Columns: \baposter@columns}%
  \setlength{\baposter@@colspacing}{7\baposter@xmargin/5}%
  \setlength{\colwidth}{\textwidth}%
  \addtolength{\colwidth}{\baposter@@colspacing*(1-\baposter@columns)}%
  \ifcase\baposter@columns\relax
    \error{You need to have at least one column!}
  \or % 1
    \setlength{\colwidth}{\colwidth}%
  \or % 2
    \setlength{\colwidth}{0.5\colwidth}%
  \or % 3
    \setlength{\colwidth}{0.3333333333333\colwidth}%
  \or % 4
    \setlength{\colwidth}{0.25\colwidth}%
  \or % 5
    \setlength{\colwidth}{0.2\colwidth}%
  \or % 6
    \setlength{\colwidth}{0.16666666666\colwidth}%
  \else % >6
    \error{You do not want so many columns}
  \fi
%
  \newcommand{\baposter@reference}{north west}%
%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % A box with a header and some content. The basic unit of the poster%
  %---------------------------------------------------------------------------%
  % Each box has a name and can be placed absolutely or relatively.%
  % The only inconvenience is that you can only specify a relative position %
  % towards an already declared box. So if you have a box attached to the %
  % bottom, one to the top and a third one which should be inbetween, you %
  % have to specify the top and bottom boxes before you specify the middle %
  % box.%
  %%
  % below=  name of other node%
  % above=  name of other node%
  % aligned=name of other node%
  % bottomaligned=name of other node%
  % column= [0]     %
  % row=    [0]     %
  % span=   [1]     %
  % height= <size in percent of column height>,[auto]%
  % name=   [noname]%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % Backward-compatibility definition (\headerbox command uses posterbox env):
  \newcommand{\headerbox}[3]{%
    \begin{posterbox}[##2]{##1}
      ##3
    \end{posterbox}
  }
  
  % PR added "heavy" box
  % #1 Title
  % #2 Options
  % #3 Content
   \newcommand{\heavybox}[3]{%
    \begin{posterbox}[##2,
		boxColorOne=KULeuvenFaculteit!15!white,
		borderColor=KULeuvenFaculteit,
		headerColorOne=KULeuvenFaculteit,
		headerBorderColor=KULeuvenFaculteit,
		boxheaderheight=2em,
		headerFontColor=white]{##1}
      ##3
    \end{posterbox}
  }
  
  % PR added "light" box
  % #1 Title
  % #2 Options
  % #3 Content
   \newcommand{\lightbox}[3]{%
    \begin{posterbox}[##2,
		boxshade=none,
		headerColorOne=KULeuvenLichtblauw,
		headerBorderColor=KULeuvenLichtblauw,
		boxheaderheight=2em,
		headerFontColor=white]{##1}
      ##3
    \end{posterbox}
  }

   \newcommand{\whitebox}[3]{%
    \begin{posterbox}[##2,
                boxshade=none,
                boxColorOne=white,
                borderColor=white,
                headerColorOne=white,
                headerBorderColor=white,
                boxheaderheight=0em,
                headerFontColor=white]{##1}
      ##3
    \end{posterbox}
  }

  \newenvironment{posterbox}[2][]{%
    \debug{Poster box options: ##1}%
    % Override the poster-wide defaults on a per-box basis
    \setkeys[ba]{posterbox}{##1}%
%
    \def\baposter@box@title{{\hspace{-.5cm}##2}}
%
    \colorlet{borderColor}{\baposter@box@borderColor}
    \colorlet{headerColorOne}{\baposter@box@headerColorOne}
    \colorlet{headerColorTwo}{\baposter@box@headerColorTwo}
    \colorlet{headerBorderColor}{\baposter@box@headerBorderColor}
    \colorlet{headerFontColor}{\baposter@box@headerFontColor}
    \colorlet{boxColorOne}{\baposter@box@boxColorOne}
    \colorlet{boxColorTwo}{\baposter@box@boxColorTwo}
%
    \setlength{\baposter@box@@boxheaderheight}{\baposter@box@boxheaderheight}%


    %% The columns is always given absolute
    % boxstartx = column * colwidth + column * colspacing
    \setlength{\boxstartx}{(\colwidth+\baposter@@colspacing)*\baposter@box@column}%
%
    %% The width is gvien absolute
    % Box Width = span * colwidth + (span-1) * colspacing
    \setlength{\boxwidth}{\baposter@box@span\colwidth} %
    \addtolength{\boxwidth}{\baposter@@colspacing*(\baposter@box@span-1)}%
%
    %% Measure the content of the box%
    \setbox\baposter@box@content=\hbox\bgroup%
      \begin{pgfinterruptpicture}%
        \begin{minipage}[t]{\boxwidth-\baposter@box@@boxpadding*2}%
          \baposter@box@textfont\bgroup%
  }% End of posterbox preamble
  %%% HERE COME THE ACTUAL CONTENTS OF THE <POSTERBOX> NVIRONMENT -- <KWM>
  {% posterbox handling after contents (i.e. drawing everything)
          \egroup%
        \end{minipage}%
      \end{pgfinterruptpicture}%
    \egroup%
    \setlength{\boxheight}{\ht\baposter@box@content}%
    \addtolength{\boxheight}{\dp\baposter@box@content}%
    \addtolength{\boxheight}{\baposter@box@@boxheaderheight} % Header%
    \addtolength{\boxheight}{2\baposter@box@@boxpadding} % Inner Sep
%
    \ifthenelse{\equal{\baposter@box@height}{bottom}}{%
    }{\ifthenelse{\equal{\baposter@box@height}{auto}}{%
    }{ % Neither auto nor bottom%
      \setlength{\boxheight}{\baposter@box@height\colheight}%
    }}%
%
    %% Determine the box position%
    \debug{Setting Coordinates}%
    \debug{Upper Right}%
    \debug{\baposter@box@name}%
%
    %%% Upper Right Corner%
    % if below=auto, set it to the previous box
    % TODO: We should generalize this to the previous box of the used column,
    %       currently we use the previous box, which might be in a different column
    \ifthenelse{\equal{\baposter@box@below}{auto}}{%
        \edef\baposter@box@below{\@@previousbox}
        \debug{Box \baposter@box@name  has below=auto, placing it below box \baposter@box@below.}
    }{}
    \xdef\@@previousbox{\baposter@box@name}

    \ifthenelse{\not\equal{\baposter@box@below}{notset} }{%
      %% Below%
      \debug{Below}%
      \path[shape=coordinate] (\boxstartx,0pt |- \baposter@box@below se) ++(0pt,-\baposter@@colspacing) coordinate(\baposter@box@name nw);%
    }{%
      \ifthenelse{\not\equal{\baposter@box@aligned}{notset} }{%
        %% Aligned%
        \debug{Aligned: \baposter@box@aligned}%
        \path[shape=coordinate] (\boxstartx,0pt |- \baposter@box@aligned nw) coordinate(\baposter@box@name nw);%
      }{%
        %% Fixed%
        \debug{Fixed}%
        \setlength{\boxstarty}{\baposter@box@row\colheight}%
        \path[shape=coordinate] (\boxstartx,\footerheight+\colheight-\boxstarty) coordinate(\baposter@box@name nw);%
    }}%
%
    %% Lower Left Corner%
    \debug{Lower Left}%
    \ifthenelse{\equal{\baposter@box@above}{bottom}}{%
      %% Above = Bottom%
      \debug{Above bottom}%
      \ifthenelse{\equal{\baposter@box@below}{notset} \and \equal{\baposter@box@aligned}{notset}}{%
      \path[shape=coordinate] (\boxstartx,\footerheight+\boxheight)                                                              coordinate(\baposter@box@name nw);%
      }{}%
      \path[shape=coordinate] (\boxstartx+\boxwidth,\footerheight+0pt)                                                           coordinate(\baposter@box@name se);%
      }{\ifthenelse{\not \equal{\baposter@box@bottomaligned}{notset}}{%
        \path[shape=coordinate] (\boxstartx+\boxwidth,0pt |- \baposter@box@bottomaligned se)                       coordinate(\baposter@box@name se);%
      }{{\ifthenelse{\not \equal{\baposter@box@above}{notset}}{%
        %% Above = Node%
        \path[shape=coordinate] (\boxstartx+\boxwidth,0pt |- \baposter@box@above nw)  +(0pt,\baposter@@colspacing) coordinate(\baposter@box@name se);%
      }{%
        %% Above = notset%
        \debug{Above=not set}%
        \ifthenelse{\equal{\baposter@box@height}{bottom}}{%
          %% height=bottom%
          \debug{height=bottom}%
          \path[shape=coordinate] (\boxstartx+\boxwidth,0pt) coordinate(\baposter@box@name se);%
        }{ %% height=auto or fixed%
          \debug{height=auto or fixed}%
          \path[shape=coordinate] (\baposter@box@name nw) ++(\boxwidth,-\boxheight)                                coordinate(\baposter@box@name se);%
	  }}}}}%
%
        %
    % Set coordinates relative to nw,se%
    \debug{Fixing Coordinates}%
    \path[shape=coordinate]%
      (\baposter@box@name nw) +(0pt,-\baposter@box@@boxheaderheight)                coordinate(\baposter@box@name tnw)%
      (\baposter@box@name nw |- \baposter@box@name se)   coordinate(\baposter@box@name sw)%
      (\baposter@box@name se |- \baposter@box@name nw)   coordinate(\baposter@box@name ne)%
      (\baposter@box@name ne) +(0pt,-\baposter@box@@boxheaderheight)                coordinate(\baposter@box@name tne)%
%
      (\baposter@box@name nw)  +(-0.025em,0pt)           coordinate(\baposter@box@name outer nw)%
      (\baposter@box@name tnw) +(-0.025em,0pt)           coordinate(\baposter@box@name outer tnw)%
      (\baposter@box@name sw)  +(-0.025em,0pt)           coordinate(\baposter@box@name outer sw)%
%
      (\baposter@box@name ne)  +( 0.025em,0pt)           coordinate(\baposter@box@name outer ne)%
      (\baposter@box@name tne) +( 0.025em,0pt)           coordinate(\baposter@box@name outer tne)%
      (\baposter@box@name se)  +( 0.025em,0pt)           coordinate(\baposter@box@name outer se);%
%
      %% Setting the bg colors of the box header
      \baposterHeaderSetShade{headerColorOne}{headerColorTwo}{headerBorderColor}
%
      \tikzstyle{src}=[rounded corners=0.5em]%
%

    %% Now that everything is set up, draw the actual box, with bg and header
    \begin{scope}[line width=\baposter@box@linewidth]
      %% Header%
      \debug{Header}%
      \debug{Header-Shape: \baposter@box@headershape, header-border: \baposter@box@headerborder (\baposter@box@headerbordernr)}%
      % TODO: Also turn this last ifcase construct into a handler function
      %       We only need to determine (fill|shade)(draw|)...
%       \baposterHeaderDrawBackground{bgColorOne}{bgColorTwo}{borderColor}
%       \baposterHeaderDrawBorder{borderColor}
      \ifcase\baposter@box@headerbordernr\relax%
        % open
        \ifthenelse{\equal{\baposter@box@headershade}{plain}}{
          \filldraw  [style=header colors] \baposterHeaderGetShape;%
        }{
          \shadedraw [style=header colors] \baposterHeaderGetShape;%
        }
      \or
        % closed
        \ifthenelse{\equal{\baposter@box@headershade}{plain}}{
          \filldraw  [style=header colors] \baposterHeaderGetShape -- cycle;%
        }{
          \shadedraw [style=header colors] \baposterHeaderGetShape -- cycle;%
        }
      \or
        % none
        \ifthenelse{\equal{\baposter@box@headershade}{plain}}{
          \fill      [style=header colors] \baposterHeaderGetShape;%
        }{
          \shade     [style=header colors] \baposterHeaderGetShape;%
        }
      \or
        % hook
        \ifthenelse{\equal{\baposter@box@headershade}{plain}}{
          \fill [style=header colors] \baposterHeaderGetShape%
          \draw [style=header colors, line width=\baposter@xheight/10] (\baposter@box@name ne) -- (\baposter@box@name nw) -- (\baposter@box@name tnw)
        }{
          \shade [style=header colors] \baposterHeaderGetShape%
        }
      \fi
      %
      %% Draw the text inside the box header:
      \baposterHeaderDrawText{\color{headerFontColor}\baposter@box@headerFont{\baposter@box@title}};%
      %
      %% Text borders (border around boxes)
      \debug{Poster boxes}%
      % First set box shade
      \baposterBoxDrawBackground{boxColorOne}{boxColorTwo}
      \baposterBoxDrawBorder{borderColor}
      %%
      %% Text Box%
      \debug{Drawing Text}%
      \path (\baposter@box@name tnw) node(text) [anchor=north west,
            outer sep=-0.000em,text width=\boxwidth-2\baposter@box@@boxpadding,inner sep=\baposter@box@@boxpadding,
            text justified] {\usebox{\baposter@box@content}};%
    \end{scope}
    %
    % Finally store the box name as the previous box for the next call
%     \xdef\@@previousbox{\baposter@box@name}%
  }% END of posterbox definition
%

 % PR added: #1 Number of columns, #2 Title, #3 Authors, #4 Association logos, #5  Funding logos
   % (A possible subtitle can be added to either argument #2 or #3)
    \begin{tikzpicture}[remember picture ,overlay,outer sep=0pt]%
      \node (footer) [fill=white,minimum width=\paperwidth,align=center,anchor=south,line width=0pt, inner sep=0\baposter@xmargin, minimum height=9\baposter@xheight/10-0\baposter@xmargin] at (current page.south) {\fillfooter{#4}{#5}};
      \fill[KULeuvenFaculteit] ([xshift=-2cm]footer.north west) rectangle ([xshift=2cm,yshift={-9*\baposter@xheight/10}]current page.north east);% goes a little beyong the page on left and right, forp rinting purposes
      \draw ([xshift={\baposter@xheight/2},yshift={-\baposter@xheight/2}]current page.north west) node[anchor=north west,inner sep=0] (KULeuvenLogo) {
        \includegraphics[height=\baposter@xheight]{images/logo_KULeuven.pdf}
      };
      \draw ([xshift={-\baposter@xheight/2},yshift={-\baposter@xheight/2+0.06\baposter@xheight}]current page.north east) node[anchor=north east,inner sep=-1] (facultyLogo) {
        %\includegraphics[height=\baposter@xheight]{images/beeldmerk\baposter@Faculteit} % paperplan should at some point be replaced by beeldmerk\baposter@Faculteit
        %\includegraphics[height=\baposter@xheight]{images/Logo_dept_CS_zonder_figuur.eps}
        %\includegraphics[height=\baposter@xheight]{images/logo_tekst_white_CS-04.png}
        \includegraphics[height=\baposter@xheight]{images/Logo_cw_PJblauw-04.png}
      };
      \ifthenelse{\equal{\baposter@titleBelow}{true}}{%
        \node (title) [text width=\paperwidth - 4\baposter@xmargin,inner sep=\baposter@xmargin, align=center,anchor=north,minimum height=\baposter@xheight,fill=white] at ([yshift={-19*\baposter@xheight/10}]current page.north) {\baposter@font\color{titleFontColor}#2};
      }{%
        \node (title) [text width=.75\paperwidth,align=center,anchor=south,minimum height=\baposter@xheight] at ([yshift={-19*\baposter@xheight/10}]current page.north) {\baposter@font\color{titleFontColor}#2};
      }
%      \node (title) [fill=white,outer sep=0,minimum width=\paperwidth-2\baposter@xmargin,align=center,anchor=north,line width=3pt,minimum height=\baposter@xheight] at ([yshift={-19*\baposter@xheight/10}]current page.north) {\color{KULeuvenBlauw}#2};
      \node (authors) [text width=.75\paperwidth,fill=white,outer sep=0, minimum width=\paperwidth-2\baposter@xmargin,align=center,anchor=north,line width=3pt,minimum height=6*\baposter@xheight/10] at (title.south) {\baposter@font\color{titleFontColor}#3};
      \fill[white] ([yshift=\baposter@xmargin,xshift=\baposter@xmargin]footer.north west) rectangle (authors.south east);
      %\node[anchor=south east,inner sep=0pt,yshift=\baposter@xmargin] at (footer.north east -| authors.south east) {\includegraphics[width=0.6\textwidth]{images/sedes}};   
      \measureheaderfooter % this sets headerheight and footerheight to the correct value dependent on the size of the size of arguments #3 and #4 resp.
    \end{tikzpicture}%
  \hspace{-1.5em}%
% This is the tikzpicture that actually contains the poster. It is only defined here in the SOURCE, but is in fact executed in "run time" when the poster
% environment is defined, which is BEFORE the posterboxes (whose code is above) are created. -- KWM
  \begin{tikzpicture}[inner sep=0pt,outer sep=0pt]%
    \useasboundingbox (0,0) rectangle (\textwidth,\textheight);
%
}% END poster begin
% The body
{% BEGIN poster end
  % The end, I have axed the option to draw gridlines, it should be easy enough to reinstate, but it was "in the way" -- KWM
\end{tikzpicture}%
% \xkvview{}
\par
}% END poster end
