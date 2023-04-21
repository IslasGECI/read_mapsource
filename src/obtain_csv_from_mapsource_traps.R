library(tidyverse)
library(lubridate)
library(readMS)
type_of_traps <- "cepos"
mapsource_path <- "data/IG_TRAMPAS_16ABR2023.txt"

write_position_tramps_csv(mapsource_path, type_of_traps)