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
? table
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
remotes::install_github('xmarquez/AuthoritarianismBook')
demdat <- democracyData
library(democracyData)
library(AuthoritarianismBook)
polityIV
democracyData$gwf
?  ? democracyData
gwf <- redownload_gwf()
head(gwf)
gwf
gwf_extend <- gwf_all_extended
str(gwf)
table(gwf$gwf_nonautocracy)
table(gwf$gwf_regimetype)
table(gwf$year)
gwf_personalism <- read_csv("GWF+personalism-scores.csv")
spec(gwf_personalism)
head(gwf_personalism)
archigos <- archigos
kailitz <- kailitz_yearly
magaloni <- magaloni_extended
wahman <- wahman_teorell
vdem <- vdem
unique(data_fa$year)
table(gwf_autocratic_extended$year)
Japan <- gwf_autocratic_extended %>%
  filter(gwf_cowcode == "740")
vic_fa_gwf <- gwf_extend %>%
  filter(year %in% data_fa$year, gwf_cowcode %in% data_fa$vicid)
perp_fa_gwf <- gwf_extend %>%
  filter(year %in% data_fa$year, gwf_cowcode %in% data_fa$perpid)

vic_fa_gwf <- rename(vic_fa_gwf, vicid = gwf_cowcode)
perp_fa_gwf <- rename(perp_fa_gwf, perpid = gwf_cowcode)

data_fa_regime <- data_fa %>%
  left_join(vic_fa_gwf, by = c("vicid", "year"))

data_fa_regime <- data_fa_regime %>% 
  mutate(vic_regimetype = coalesce(gwf_regimetype,gwf_nonautocracy))
data_fa_regime <- data_fa_regime %>%
  left_join(perp_fa_gwf, by = c("perpid", "year"))
data_fa_regime <- data_fa_regime %>% 
  mutate(perp_regimetype = coalesce(gwf_regimetype.y,gwf_nonautocracy.y))
data_fa_regime <- data_fa_regime %>%
  select(victim,
         perp,
         year,
         territory,
         retaliatory,
         vic_regimetype,
         perp_regimetype)
view(data_fa_regime)

vic_fa_personalism <- gwf_personalism %>%
  filter(year %in% data_fa$year,
         gwf_casename %in% data_fa_regime$gwf_casename.x)
perp_fa_personalism <- gwf_personalism %>%
  filter(year %in% data_fa$year,
         gwf_casename %in% data_fa_regime$gwf_casename.y)
data_fa_regime <-
  rename(data_fa_regime, gwf_casename = gwf_casename.x)
data_fa_regime <- data_fa_regime %>%
  left_join(vic_fa_personalism, by = c("gwf_casename", "year"))
data_fa_regime <-
  rename(data_fa_regime, vic_gwf_casename = gwf_casename)
data_fa_regime <-
  rename(data_fa_regime, gwf_casename = gwf_casename.y)
data_fa_regime <- data_fa_regime %>%
  left_join(perp_fa_personalism, by = c("gwf_casename", "year"))
data_fa_regime <-
  rename(data_fa_regime, perp_gwf_casename = gwf_casename)
data_fa_regime <-
  rename(data_fa_regime, vic_latent_personalism = latent_personalism.x)
data_fa_regime <-
  rename(data_fa_regime, perp_latent_personalism = latent_personalism.y)
data_fa_regime <- data_fa_regime %>%
  select(
    victim,
    perp,
    year,
    territory,
    retaliatory,
    vic_regimetype,
    perp_regimetype,
    vic_latent_personalism,
    perp_latent_personalism
  )
table(data_fa_regime$vic_regimetype,
      data_fa_regime$perp_regimetype)
