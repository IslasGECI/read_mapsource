FROM islasgeci/base:1.0.0
COPY . /workdir

RUN R -e "install.packages(c('comprehenr'), repos='http://cran.rstudio.com')"
RUN R -e "remotes::install_github('IslasGECI/testtools', build_vignettes=FALSE, upgrade = 'always')"
