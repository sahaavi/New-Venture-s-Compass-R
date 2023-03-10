# R script to run author supplied code, typically used to install additional R packages
# contains placeholders which are inserted by the compile script
# NOTE: this script is executed in the chroot context; check paths!

r <- getOption('repos')
r['CRAN'] <- 'http://cloud.r-project.org'
options(repos=r)

# ======================================================================

# packages go here
install.packages(c('readr', 'here', 'ggthemes', 'remotes', 'dashCoreComponents', 'dashHtmlComponents', 'ggplot2'))
remotes::install_github("plotly/dashR", upgrade = "always")
remotes::install_github('facultyai/dash-bootstrap-components@r-release')


# Example R code to install packages if not already installed

my_packages = c("tidyr", "plotly")

install_if_missing = function(p) {
  if (p %in% rownames(installed.packages()) == FALSE) {
    install.packages(p)
  }
} 

invisible(sapply(my_packages, install_if_missing))