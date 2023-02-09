# Organising research as an R package

**Pros:** pre-defined structure with helper functions (usethis, testthat, devtools), documentation, dependencies, think functional programming (more efficient), pkgdown, automated workflows (R check, pages, etc.)

**Cons:** R-specific, learning curve (if not already an R-user).

## Pre-defined structure

Strict(ish) rules about organisation of an R package prevents ambiguity about the
organisation of a research compendium. Packages such as **rrtools** and **usethis**
make it easy to create the structure and add dependencies.

Dependencies added via **renv** and/or DESCRIPTION (`rrtools::add_dependencies_to_description()` or `usethis::use_package()`).
Dependencies are provided to the user when installing the package.

Load functions via library(package) (after running devtools::install())

## Getting started

Required packages:

```r
devtools::install_github("benmarwick/rrtools")
install.packages(c("renv", "here", "tidyverse", "devtools"))
```

create a simple research compendium structure:

```r
rrtools::create_compendium("./myCompendium")
# remove .Rprofile if present
```

Some files will need to be modified.

You can add your information to the `DESCRIPTION` file under `Authors@R`, as
well as the `Title` of your package and a brief `Description`.

The created `LICENSE(.md)` files may need modification as well, if the
`create_compendium()` function added your Git username to the copyright.

Loading required packages:

```r
library(readr)
library(devtools)
```

The `rrtools::create_compendium()` function only provides the README.Rmd file.
This will need to be rendered to a *.md* file if you want it to show nicely
on a GitHub repository.

You will need to modify the `README.Rmd` file to include the title of your
project, and the publication and citation information.

Render `README.Rmd`:

```r
devtools::build_readme()
```

:warning: **Only make changes to `README.Rmd`. Then knit it to `README.md`. Any
changes you make to `README.md` will be lost when you knit `README.Rmd`.**

## Analysis

### Data

Let's generate a fake data frame and add it to the `analysis/data/raw_data/`
folder.

```r
raw_metrics <- data.frame(
  "height"= rnorm(100, 175, 20),
  "weight" = rnorm(100, 70, 10)
  )
  
#write.csv(raw_metrics, "analysis/data/raw_data/raw-metrics.csv", row.names = FALSE) #base-R
write_csv(raw_metrics, "analysis/data/raw_data/raw-metrics.csv")
```

### Code

Add code to calculate and plot BMI as a code chunk in `analysis/paper/paper.qmd`,

```r
library(here)
library(readr)

data <- read_csv(here("analysis/data/raw_data/raw-metrics.csv"))
height_m <- data$height / 100
weight <- data$weight
data$bmi <- weight / height_m ** 2

plot(height ~ weight, data)
```

Then add **readr** as a dependency:

```
usethis::use_package("readr")
# or
rrtools::add_dependencies_to_description()
```

Render the document.

Congratulations! You have created a basic reproducible research compendium! 🎉

There are some caveats to this approach:

- there is no real R functionality (we are just using the structure)
- data in analysis is not included when installing as an R package
- project can only be reproduced when the project is cloned/downloaded
- documenting the code and data still needs to be done somewhere
- too much code may clutter your `paper.qmd` file.


## Modifications to the structure

### Code

Too much code that will clutter your `paper.qmd` file? No problem.

The code can be added to `R/` in the root of your project. If you are familiar
with the R package structure, this is where you store functions in an R package.

```r
dir.create("./R")
file.create("./R/bmi_calc.R")
```

Now add the code to calculate BMI to `R/bmi_calc.R` and remove it from `paper.qmd`.

Render. Works just as before.

But we can do one better. Instead of just moving the script, we can instead
create a function to calculate BMI, and document it in `R/bmi_calc.R`.

```r
#' BMI calculator
#'
#' @param data A data frame with height and weight
#' @return data frame with height, weight, and bmi.
#' @export
bmi_calc <- function(data){
  height_m <- data$height / 100
  weight <- data$weight
  data$bmi <- weight / height_m ** 2
  return(data)
}
```

Now get R to automatically generate the documentation.

```r
devtools::document()
```

Check it out with `?bmi_calc`.

Add the call to the function in `paper.qmd` (and remove any code not related
to the function from `R/bmi_calc.R`. Make sure the data is imported into
`paper.qmd`.

**Note:** scripts placed in R/ need to be able to install (cannot rely on external data).

### Data

As mentioned above, adding data to `analysis/` will not make them available with
R-console install, only when the repo is cloned/downloaded.

To make the data available, they can instead be added to `inst/extdata/` or
`data-raw/` or `data/`.

This will then have implications on how they are available in the package.

- `inst/extdata/`: Raw data in custom format (e.g. *.csv*) available to user
- `data-raw/`: Raw data in custom format (e.g. *.csv*) available to user
- `data/`: Available as *.rda* files when package is installed

I'm not actually sure what the best option is here...

For now:

```r
usethis::use_data_raw("raw_metrics")
```

Then in the generated `data-raw/raw_metrics.R`, add (above the already included code):

```r
raw_metrics <- read_csv("analysis/data/raw_data/raw-metrics.csv")
```

Run the script. The raw data is now added to `data/`.

Add documentation to `R/data.R`

```r
file.create("R/data.R")
```

```r
#' Height and weight data
#'
#' \describe{
#'  \item{height}{Height in cm.}
#'  \item{weight}{Weight in kg.}
"raw_metrics"
```

Generate documentation with `devtools::document()`.

You can now access the raw data with `packagename::raw_metrics`, and you can
add `devtools::load_all()` to `paper.qmd` instead of a call to `read_csv`.

### Reports

Vignettes! For example see `vignette("pivot")`. Now imagine your analysis done
as a vignette. This could be your supplementary materials!

## End-user experience

The structure you choose can depend on how you want the end-user to interact
with you project.

What does the end-user need (data, functions, reports, etc.)? And how should they
be able to access it? Without R? Is R needed? Should R be needed?

When cloning/downloading:

- all files are available no matter where they are stored
- package/files stored where user wants them

when installing from R console (i.e., `devtools::install_github("username/reponame")`:

- using library(package), code and data will only be available if stored in `R/` and `data/`, respectively
- raw data are stored in less than convenient location

Think about what the end-user needs on install (not clone). It is possible to
rename `analysis` to `inst` and make everything available on console-install, but
the package can quickly
become unwieldy and install-heavy if too much is included.

- using `inst/` to place data and manuscripts will allow them to be downloaded
along with the package
- `analysis/` makes more sense for a research compendium (more generic language)

Combination of clone/download and R console compatibility is probably best.

- Place essential functions in R/
- Place derived data in data/ (`usethis::use_data()`) and raw data in csv (if not too large)
in data-raw (`usethis::use_data_raw()`) (along with R scripts to process to derived data)
  - derived data will be .rda files
- Place derived data in inst/data/derived_data and raw data in inst/data/raw_data and scripts to process from raw to derived in inst/scripts/
- Place all data in `inst/extdata/` and the script to clean data in data-raw/
- e.g. [palmerpenguins](https://github.com/allisonhorst/palmerpenguins)


## Reproducibility

To include a reproducible [binder](https://mybinder.org/), you can add a
`Dockerfile`.

```r
rrtools::use_dockerfile()
```

The `.binder/Dockerfile` and `./Dockerfile` will need some modification.

`.binder/Dockerfile`

Change the email and the link to the GitHub repo (you may also need to change
'master' to 'main').

```
LABEL maintainer='Your Name <your_email@somewhere.com>' # optional

...

RUN wget https://github.com/<USERNAME>/<REPO>/raw/master/DESCRIPTION && R --vanilla -s -e 
```

and add your email in `.Dockerfile` (optional).

```
...
# required
MAINTAINER Your Name <your_email@somewhere.com>
```

Change the link in `README.Rmd`.

```
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/<USERNAME>/<REPO>/main?urlpath=rstudio)
```

Re-build the README with `devtools::build_readme()`.

You will also need to activate **renv**.

```r
renv::init()
#renv::snapshot()
```

