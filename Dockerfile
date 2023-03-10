FROM islasgeci/base:1.0.0
COPY . /workdir

RUN R -e "install.packages(c('comprehenr'), repos='http://cran.rstudio.com')"
