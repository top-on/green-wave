FROM rocker/rstudio:3.5.0

# load shiny into rstudio image (see https://github.com/rocker-org/shiny/pull/31/)
EXPOSE 3838

RUN export ADD="shiny" && \
    bash /etc/cont-init.d/add

COPY ./src /srv/shiny-server/src

# install system package needed for some R packages
RUN apt-get update && apt-get install -y --no-install-recommends libssl-dev apt-utils

# install R packages so that they are cached (in opposite to installing them via R)
RUN install2.r --error envDocument dplyr assertthat lubridate tidyr DBI plotly RSQLite ggplot2 chron darksky RCurl shinycssloaders brms

RUN Rscript -e "source('/srv/shiny-server/src/000_run_pipeline.R')"

CMD ["/usr/bin/shiny-server"]

