install.packages("tidyverse")
install.packages("sjmisc")
install.packages("kableExtra")
install.packages("ggcorrplot")

library(tidyverse)
library(sjmisc)
library(kableExtra)
library(ggplot2)



vdem <- readRDS("_clases/vdem.rds")

vdem_subset <- vdem %>% 
  select(country_name, v2x_partipdem, 
         v2x_cspart, v2elmulpar, v2psprlnks, e_peedgini, 
         e_regionpol, e_gdppc, e_pop) %>% 
  group_by(country_name) %>% 
  summarise_all(function(x)  mean(x, na.rm = T))


## Describe Data ##
library(skimr)
# describe data
skimr::skim(vdem_subset) 

# subset of skim
skim(vdem_subset) %>% yank("numeric")
help(yank)


## Correlacion ##
library(ggcorrplot)
colnames(vdem_subset)

corr_vdem <- vdem_subset %>% 
  select(2:6, 8) %>% 
  cor(use = "pairwise") %>% 
  round(1)

ggcorrplot(corr_vdem, type = "lower", lab = T, show.legend = F)
