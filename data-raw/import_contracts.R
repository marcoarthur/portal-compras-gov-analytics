## Prepare `contracts` dataset

library(readr)
library(tidyverse)

# datasets (main and auxiliary ones)
tipos <- read_csv("inst/tipo_contrato.csv")
names(tipos) <- c("codigo", "tipo_contrato")
modalidades <- read_csv("inst/modalidades.csv")
names(modalidades) <- c("codigo", "modalidade")
# from 2000 to date
compras_contracts <- read_csv("inst/contracts.csv") %>%
    filter( data_assinatura > '2000-01-01')

# replacing id by label
compras_contracts <-
    compras_contracts %>%
    inner_join( modalidades, by = c( "modalidade_licitacao" = "codigo")) %>% 
    inner_join( tipos, by = c( "codigo_contrato" = "codigo"))

# remove unwanted columns and auxiliary datasets
compras_contracts <- compras_contracts %>%
    select( -cnpj_contratada, -modalidade_licitacao , -codigo_contrato, -codigo_contrato )
rm(tipos, modalidades)

# export data
usethis::use_data(compras_contracts, overwrite = TRUE)
