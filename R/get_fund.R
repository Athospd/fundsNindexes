#' extract_funds_by_cnpj_list
#'
#' Extrai o valor de cota de fundos listados em um intervalo de tempo
#'
#' @param ini_date
#' @param end_date
#' @param cnpj_list
#'
#' @return
#' @export
#'
#' @examples
#' @importFrom lubridate `%m+%`
extract_funds_by_cnpj_list = function(ini_date, end_date, cnpj_list){
  x = lubridate::interval(as.Date(paste0("01",substr(ini_date,3,10)),"%d/%m/%Y"), as.Date(paste0("01",substr(end_date,3,10)), "%d/%m/%Y"))
  diff_dates = lubridate::time_length(x,"month") %>% ceiling()


  raw = c()
  for(m in 0:diff_dates){
    ref_date = as.Date(ini_date,"%d/%m/%Y") %m+% months(m)
    ref_yearmon = lubridate::year(ref_date)*100+lubridate::month(ref_date)
    message(paste0('### Extracting month ',ref_yearmon))
    url = paste0('http://dados.cvm.gov.br/dados/FI/DOC/INF_DIARIO/DADOS/inf_diario_fi_',ref_yearmon,'.csv')
    raw_temp = url %>%
      read.csv(.,sep = ";",stringsAsFactors = F) %>%
      dplyr::filter(CNPJ_FUNDO %in% cnpj_list)
    raw = rbind(raw,raw_temp)
    rm(raw_temp)
    gc()
  }

  df_out = raw %>%
    dplyr::filter(DT_COMPTC >= as.Date(ini_date,"%d/%m/%Y") & DT_COMPTC <= as.Date(end_date,"%d/%m/%Y") ) %>%
    .[,c(1,2,4)]

  df_out[,2] <- df_out[,2] %>% as.Date(.,"%Y-%m-%d")

  names(df_out)[2] = "date"

  df_out %>% return
}



#' get_funds_at_least
#'
#' Gera uma lista com os fundos que tenham um número mínimo de cotistas e de PL.
#'
#' @param min_cotistas
#' @param min_pl
#'
#' @return
#' @export
#'
#' @examples
get_funds_at_least = function(min_cotistas,min_pl){
  url = paste0('http://dados.cvm.gov.br/dados/FI/DOC/INF_DIARIO/DADOS/inf_diario_fi_',lubridate::year(Sys.time())*100+lubridate::month(Sys.time()),'.csv')
  all_funds = url %>%
    read.csv(.,sep = ";",stringsAsFactors = F)

  all_funds = all_funds %>% dplyr::filter(DT_COMPTC == max(all_funds$DT_COMPTC))

  ix_at_least = which(all_funds$NR_COTST > min_cotistas & all_funds$VL_PATRIM_LIQ > min_pl)

  return(all_funds$CNPJ_FUNDO[ix_at_least])
}
