## General R resources
* [R for data science](https://r4ds.had.co.nz/)
* [RStudio4edu](https://rstudio4edu.github.io/rstudio4edu-book/)
* [Advanced R](https://adv-r.hadley.nz/index.html) by Hadley Wickham
* [R ladies Tunis YouTube channel](https://www.youtube.com/channel/UCfoktGmvJ6rnME7mSP_Ww2g/videos)

## Building Apps in R

* [Shiny from RStudio](https://shiny.rstudio.com/) - Shiny is an R package that makes it easy to build interactive web apps straight from R. You can host standalone apps on a webpage or embed them in R Markdown documents or build dashboards. You can also extend your Shiny apps with CSS themes, htmlwidgets, and JavaScript actions.
* [Mastering Shiny (book)](https://mastering-shiny.org/) - Build interactive apps, reports and dashboards powered by R
* [Flex Dashboard](https://pkgs.rstudio.com/flexdashboard/) - Easy interactive dashboards for R

## R Markdown
* Practical [beginner R RMarkdown workshop](https://www.youtube.com/watch?v=zuYHCl3bSF4) with a statistical focus
* [Writing dynamic and reproducible documents](https://oliviergimenez.github.io/intro_rmarkdown/#1) - and introduction to R-markdown by Olivier Gimenez ([GitHub repository](https://github.com/oliviergimenez/intro_rmarkdown))
* [R Markdown](https://slides.djnavarro.net/starting-rmarkdown/#1) by Danielle Navarro (beginner)
* [Rmarkdown examples/blogs/tutorials](https://www.one-tab.com/page/d00HO6mxTTuqo2o7aGCffQ) 
* [RMarkdown Driven Development](https://rstudio.com/resources/rstudioconf-2020/rmarkdown-driven-development/) (Into to RMarkdown, projects and packages) 

## R Markdown presentations
* Packages: 
  * [xaringan](https://github.com/yihui/xaringan) (see [slides](https://rmarkdown-shilaan.netlify.app/#1) by Shilaan Alzahawi) 
    * [xaringanExtra](https://github.com/gadenbuie/xaringanExtra/) (see [slides](https://slides.garrickadenbuie.com/extra-special-xaringan/#1) and [presentation](https://www.youtube.com/watch?v=RPFh3y9UAX4&list=PL4IzsxWztPdnCC_kMCYKrd_t6cViMhBrD&index=2) by Garrick Aden-Buie et al.)
  * [revealjs](https://github.com/rstudio/revealjs) (see [slides](https://github.com/bebatut-slides/2019) by Bérénice Batut) 
  * [remark](https://github.com/gnab/remark)
  * [slidev](https://github.com/slidevjs/slidev)
* Add alt-text to code chunks (using option fig.alt =) 
    * see [slides](https://encuesta-user2021-en.netlify.app/#6) by Virginia A. García Alonso et al. for great examples of alt-text using xarigan)
    * see [slides](https://github.com/spcanelon/csvConf2021) by Silvia Canelón and Liz Hare on accessibility 
* Add emojis using the [emo package](https://github.com/hadley/emo) (use ji_name or the [emojilib](https://unpkg.com/emojilib@3.0.4/dist/emoji-en-US.json) for an overview of available emojis)
* [Deploying xaringan Slides with GitHub Pages](https://rviews.rstudio.com/2021/11/18/deploying-xaringan-slides-a-ten-step-github-pages-workflow/)

## Building Websites in R

* [Blogdown](https://github.com/rstudio/blogdown) - Provides a powerful and customizable website output format for R Markdown
* [Build a website with blogdown](https://websiteinr.netlify.app/) by Tatjana Kecojevic
* [Binder](https://mybinder.org/) - Have a repository full of Jupyter notebooks? With Binder, open those notebooks in an executable environment, making your code immediately reproducible by anyone, anywhere.
* [Netlify](https://www.netlify.com/) - Build, deploy & scale modern web projects

## Dependency management

* [PackRat](https://rstudio.github.io/packrat/) - a dependency management system for R
* [renv](https://rstudio.github.io/renv/articles/renv.html) - a new effort to bring project-local R dependency management to your projects. The goal is for renv to be a robust, stable replacement for the Packrat package, with fewer surprises and better default behaviors.
  * [Renv package explained](https://kevinushey-2020-rstudio-conf.netlify.app/slides.html) by Kevin Ushey   
* [Requirements.txt-like file for R (Stack Overflow)](https://stackoverflow.com/questions/38928326/is-there-something-like-requirements-txt-for-r) - various suggestions for creating a dependency file for your R project.

## Data Visualisation
* [Fundamentals of Data Visualization](https://clauswilke.com/dataviz/) by Claus O. Wilke
* [Data Visualization, A practical introduction](https://socviz.co/) by Kieran Healy
* [Data visualisation in R](http://satrdayjoburg.djnavarro.net/) by Danielle Navarro (intermediate)
* [What They Forgot to Teach You About R](https://rstats.wtf/index.html) by Jennifer Bryan and Jim Hester


### Ggplot2
* [ggplot2 book](https://ggplot2-book.org/) by Hadley Wickham, Danielle Navarro, and Thomas Lin Pedersen
* ggplot2 workshop [part 1](https://www.youtube.com/watch?v=h29g21z0a68) and [2](https://www.youtube.com/watch?v=0m4yywqNPVY) by Thomas Lin Pedersen (YouTube)
* [ggplot 2 tutorial for beginners](https://ggplot2tutor.com/beginner_tutorial/beginner_tutorial/)
* [A ggplot2 tutorial for beautiful plotting in R](https://www.cedricscherer.com/2019/08/05/a-ggplot2-tutorial-for-beautiful-plotting-in-r/) by Cedric Scherer
* [Creating and using custom ggplot2 themes](https://themockup.blog/posts/2020-12-26-creating-and-using-custom-ggplot2-themes/) by Thomas Mock
* [ggplot2 scales](https://ggplot2tor.com/scales/)
* [Multiple ggplot2 plots](https://gotellilab.github.io/GotelliLabMeetingHacks/NickGotelli/ggplotPatchwork.html)
* [Nordmann et al. 2021 ggplot2 tutorial](https://doi.org/10.31234/osf.io/4huvw)

### Colours
* [Color boxes](https://www.garrickadenbuie.com/blog/little-inline-color-boxes/)
* [ColorBrewer](https://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3) or [viridis](https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html) for pretty colour schemes with colour-blind friendly options
* You can also google ‘hex colour picker’ to find hex codes for colours 
* [Awesome List Of 657 R Color Names](https://www.datanovia.com/en/blog/awesome-list-of-657-r-color-names/)
* [Palettes](https://www.r-graph-gallery.com/38-rcolorbrewers-palettes.html)
* [ggplot2 colour reference list](http://sape.inf.usi.ch/quick-reference/ggplot2/colour)
* [Colors in R](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf)


## Data validation
* [Missing values](https://allisonhorst.shinyapps.io/missingexplorer/) by Allison Horst (beginner) ([video](https://ucsb.app.box.com/s/pr2z7ygeycrfwefmsdknrq3lurzka5ux); [slides](https://docs.google.com/presentation/d/1EzMU6be01aicPGeBcbXrXy1iX8CdWhBz1o2pJDPsXBM/edit#slide=id.p))
* [The Data Validation Cookbook](https://data-cleaning.github.io/validate/) by Mark P.J. van der Loo
* [Exploring missing values in naniar](https://allisonhorst.shinyapps.io/missingexplorer/#section-introduction) by Allison Horst

## dplyr
* [Dive into dplyr](https://www.kaggle.com/jessemostipak/dive-into-dplyr-tutorial-1)
* [dplyr tutorial](https://allisonhorst.shinyapps.io/dplyr-learnr/) by Allison Horst (beginner)

## Integrations with other Software

* [Using R and Tableau](https://www.tableau.com/learn/whitepapers/using-r-and-tableau) - Tableau Desktop can now connect to R through calculated fields and take advantage of R functions, libraries, packages and even saved models. These calculations dynamically invoke the R engine and pass values to R via the Rserve package, and are returned back to Tableau.
* [Exploratory.io](https://exploratory.io/) -  Exploratory Desktop provides a Simple and Modern UI experience to access various Data Science functionalities including Data Wrangling, Visualization, Statistics, Machine Learning, Reporting, and Dashboard. It is built on R so you can easily Extend it with thousands of open source packages to meet your needs.
* [JASP](https://jasp-stats.org/) - GUI based in R that allows you to conduct statistical analyses in seconds, without programming. Offers both frequentist and Bayesian analysis methods.
* [Jamovi](https://www.jamovi.org/) - free and open statistical software built on R. Would you like the R code for your analyses? Jamovi can provide that too.
* [JAMOVI / JASP / R / Rmarkdown collaborative manual](https://docs.google.com/document/d/1A9BbOCsrg1ikLaBltKhXVKj-eetlrBqR-1u-2V99I2c/edit#) by Gilad Feldman

## R + Python

* [Reticulate](https://rstudio.github.io/reticulate/) - R interface to Python
* [Python and R for the Modern Data Scientist (book)](https://www.oreilly.com/library/view/python-and-r/9781492093398/) - This book guides data scientists from the Python and R communities along the path to becoming bilingual. By recognizing the strengths of both languages, you'll discover new ways to accomplish data science tasks and expand your skill set.

## R + GitHub
* [Happy Git and GitHub for the useR](https://happygitwithr.com/)
  * See [here for a shorter version](https://rfortherestofus.com/2021/02/how-to-use-git-github-with-r/)
* [WORCS, Workflow for Open Reproducible Code in Science](https://www.youtube.com/watch?v=uzjpN_yFeUU) (+ [longer presentation involving the broader context that WORCS fit in](https://www.youtube.com/watch?v=uKd6HoK_iS0))
* [GEOG 712 Reproducible Research Workflow](https://github.com/paezha/Reproducible-Research-Workflow) with GitHub and R


## R package repositories
* [ROpenSci](https://ropensci.org/) - help develop R packages for the sciences via community driven learning, review and maintenance of contributed software in the R ecosystem.

## R for Reproducible Research

* [PsyTeachR](https://psyteachr.github.io/) - curriculum that emphasizes essential ‘data science’ graduate skills that have been overlooked in traditional approaches to teaching, including programming skills, data visualisation, data wrangling and reproducible reports.
* [R for Reproducible Research](https://annakrystalli.me/rrresearch/) - This course focuses on data and project management through R and Rstudio, will introduce students to best practice and equip them with modern tools and techniques for managing data and computational workflows to their full potential. 
* [Reproducible Research in R](https://r-cubed.rostools.org/) - An introductory workshop on modern data analyses and workflows.
* [Reproducible Analyses in R](https://n8cir.org.uk/events/event-resource/analyses-r/) (beginner)
* [Reproducible Research with R](https://ropensci.org/commcalls/2019-07-30/) (research compendia and rrtools, Holepunch and Binder, ReproHack)
* [Reproducible research with workflowr](https://www.youtube.com/watch?v=3yX73UBN2SU)
* [Reproducible Science with R and Rstudio](https://github.com/oliviergimenez/reproducible-science) by Olivier Gimenez
* [Improve your workflow for reproducible science](https://www.youtube.com/watch?v=JA-vLsN-sic&feature=youtu.be) (intermediate)
* https://workflowr.io/, a central website for discovering and sharing reproducible research projects created with the #rstats package
* [Tidy data](http://dx.doi.org/10.18637/jss.v059.i10), paper by Hadley Wickham explaining a central concept of the tidyverse
* [Filling your bag of workflow tricks](https://mpaulacaldas.github.io/r-ladies-workflow/#1) by María Paula Cadras


## R beginner materials

* [R data science and visualisation videos](https://www.youtube.com/c/DanielleNavarro77) by Danielle Navarro
* [Slides from R seminars](https://slides.djnavarro.net/) by Danielle Navarro
* [25 days of chRistmas](https://kiirstio.wixsite.com/kowen/post/the-25-days-of-christmas-an-r-advent-calendar) by Kiirsti Owen, with [videos by Jason Winget](https://www.youtube.com/watch?v=ms7u9jvkjNI&list=PLXjgHAp5I5UhV7nw1eY61_Uil68KhmBKe) 
* [Intro to R](https://github.com/andrw-jns/intro_r) by Andrew Jones and Ozayr Mohammed 
* [R for beginners](https://www.rensvandeschoot.com/tutorials/r-for-beginners/) by Ihnwhi Heo, Duco Veen, and Rens van de Schoot
* [R for Excel users](https://rstudio-conf-2020.github.io/r-for-excel/) by Julie Lowndes & Allison Horst

## R & Statistics
* [R videos by Kelly Bodwin](https://www.youtube.com/user/SuperKrazy2000)  
* [Learning Statistics with R](https://bookdown.org/ekothe/navarro26/preface.html) by Danielle Navarro
* Statistical analyses using R with Amelia McNamara using [base R](https://www.youtube.com/playlist?list=PLik6fAQnSI90bHK9fapPS-eZCUhgROh6S) and the [tidyverse](https://www.youtube.com/playlist?list=PLik6fAQnSI93eBVuAONFBCVdOd7VFhKQX)
* [COMP/STAT 112](https://ds112-lendway.netlify.app/) by Lisa Lendway (Intermediate)

## Spatial
* Drawing beautiful maps programmatically with R, sf and ggplot2 — [Part 1: Basics](https://r-spatial.org/r/2018/10/25/ggplot2-sf.html)
* [7 Draw maps](https://socviz.co/maps.html#maps)
* [Introduction to GIS in R](https://annakrystalli.me/intro-r-gis/index.html) by Anna Krystalli

## Other
* [Structuring R projects](https://chrisvoncsefalvay.com/2018/08/09/structuring-r-projects/)
* [{ggxmean}](https://github.com/EvaMaeRey/ggxmean) lets you put a [vertical line at the mean of x](https://evamaerey.github.io/rendered_templates/templates/ggxmean_template#1)
* [automated R course](https://github.com/rstudio/rstudio-conf/tree/master/2021/minecetinkayarundel)
* Package to help you share code to ask questions: [reprex](https://github.com/tidyverse/reprex)
* [Text mining with tidy data principles](https://juliasilge.shinyapps.io/learntidytext/) by Julia Silge
* [A Zotero Workflow for R](https://www.anthonyschmidt.co/post/2021-10-25-a-zotero-workflow-for-r/)
* [Quantitative Methods in R](https://uoftcoders.github.io/rcourse/) for Biology
* [R package development](http://archaeoinformatics.net/r-package-development/) by Sophie Schmidt
