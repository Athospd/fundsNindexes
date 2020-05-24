
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fundsNindexes

<!-- badges: start -->

<!-- badges: end -->

Generate data.frame with selected funds quota and some daily indexes
quotes.

## Installation

``` r
# install.packages("devtools")
devtools::install_github("Athospd/fundsNindexes")
```

## Example

``` r
library(fundsNindexes)

ini_date = '18/05/2020'
end_date = '20/05/2020'

cnpj_list = get_funds_at_least(1e3,1e9)

df_funds = extract_funds_by_cnpj_list(ini_date,end_date,cnpj_list)
#> ### Extracting month 202005
df_index = spawn_index_dataframe(ini_date,end_date)
#> ## Extracting IMA
#> ## Extracting USD/BRL
#> ## Extracting IBOV
#> ## Extracting S&P 500

df_joined = merge(df_funds
                  ,df_index
                  ,by = "date")
```

``` r
dplyr::glimpse(df_joined)
#> Rows: 711
#> Columns: 15
#> $ date           <date> 2020-05-18, 2020-05-18, 2020-05-18, 2020-05-18, 2020-…
#> $ CNPJ_FUNDO     <chr> "00.071.477/0001-68", "07.214.377/0001-92", "03.737.18…
#> $ VL_QUOTA       <dbl> 10.012854, 4.428839, 7.177111, 7794.571957, 4.730933, …
#> $ ibov_close     <dbl> 81194.29, 81194.29, 81194.29, 81194.29, 81194.29, 8119…
#> $ usdbrl_close   <dbl> 5.7204, 5.7204, 5.7204, 5.7204, 5.7204, 5.7204, 5.7204…
#> $ irf_m1p        <dbl> 15699.5, 15699.5, 15699.5, 15699.5, 15699.5, 15699.5, …
#> $ irf_m          <dbl> 13922.85, 13922.85, 13922.85, 13922.85, 13922.85, 1392…
#> $ ima_b5         <dbl> 6505.31, 6505.31, 6505.31, 6505.31, 6505.31, 6505.31, …
#> $ ima_b5p        <dbl> 8611.403, 8611.403, 8611.403, 8611.403, 8611.403, 8611…
#> $ ima_b          <dbl> 7233.982, 7233.982, 7233.982, 7233.982, 7233.982, 7233…
#> $ ima_c          <dbl> 7674.902, 7674.902, 7674.902, 7674.902, 7674.902, 7674…
#> $ ima_s          <dbl> 4735.545, 4735.545, 4735.545, 4735.545, 4735.545, 4735…
#> $ ima_geral_ex_c <dbl> 5874.55, 5874.55, 5874.55, 5874.55, 5874.55, 5874.55, …
#> $ ima_geral      <dbl> 5932.878, 5932.878, 5932.878, 5932.878, 5932.878, 5932…
#> $ sp500_close    <dbl> 2953.91, 2953.91, 2953.91, 2953.91, 2953.91, 2953.91, …
```

## Available Indexes

  - USD/BRL - closing day
  - S\&P 500 - closing day
  - IBOV - closing day
  - IMA family
      - IRF-M
      - IRF-M 1
      - IRF-M 1+
      - IMA-B
      - IMA-B 5
      - IMA-B 5+
      - IMA-C
      - IMA-S
      - IMA-GERAL
      - IMA-GERAL ex-C
