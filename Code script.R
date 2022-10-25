require(tidyverse)
require(tabbycat)
require(stargazer)
require(jtools)
require(gtsummary)
require(multcomp)
require(ggpubr)
require(rstatix)
require(xtable)

data_fa <- read_csv("Land Grabs v1.1.csv")
head(data_fa)
?table
table(data_fa$retaliatory)
table(data_fa$cowwar)

install.packages("haven")
install.packages("remotes")
library(haven)
library(remotes)
mconquest <- read_dta("Conquest REP.dta")
mconquest
str(mconquest)
remotes::install_github('xmarquez/democracyData')
demdat <- democracyData
library(democracyData)
polityIV
democracyData$gwf
??democracyData
gwf <- redownload_gwf()
head(gwf)
gwf
str(gwf)
table(gwf$gwf_nonautocracy)
table(gwf$gwf_regimetype)
table(gwf$year)

unique(data_fa$year)
table(gwf_autocratic_extended$year)
Japan <- gwf_autocratic_extended %>% 
  filter(gwf_cowcode == "740")
vic_fa_gwf <- gwf_autocratic_extended %>% 
  filter(year %in% data_fa$year, gwf_cowcode %in% data_fa$vicid)
perp_fa_gwf <- gwf_autocratic_extended %>% 
  filter(year %in% data_fa$year, gwf_cowcode %in% data_fa$perpid)
rm(data_fa_gwf)
vic_fa_gwf <- rename(vic_fa_gwf, vicid = gwf_cowcode)
perp_fa_gwf <- rename(perp_fa_gwf, perpid = gwf_cowcode)
data_fa_regime <- data_fa %>% 
  left_join(vic_fa_gwf, by = c("vicid","year"))
data_fa_regime <- rename(data_fa_regime,vic_regimetype = gwf_regimetype)
data_fa_regime <- data_fa_regime %>% 
  left_join(perp_fa_gwf, by = c("perpid","year"))
data_fa_regime <- rename(data_fa_regime, perp_regimetype = gwf_regimetype)
data_fa_regime <- data_fa_regime %>% 
  select(victim,perp,year,territory,retaliatory,vic_regimetype,perp_regimetype)
view(data_fa_regime)

Japan <- gwf_all_extended %>% 
  filter(gwf_cowcode == "740")
gwf

install.packages("gitcreds")
gitcreds::gitcreds_set()


