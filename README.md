# priceindex_calculator

[![Crates.io](https://img.shields.io/crates/l/rustc-serialize.svg?style=social)](https://github.com/manolo20/cpi_dashboard_StatCan/blob/master/LICENSE.md)

# :maple_leaf: :maple_leaf: Personal Price Index Calculator :maple_leaf: :maple_leaf:

This application compares the Canadian Consumer Price Index (CPI) vs. a personalized price index.

The personalized price index is calculated using the inputed monthly expeditures. 

The shiny app is hosted at https://mmala027.shinyapps.io/personal_calculator/

To run the application:

```
## Installing missing packages
pkgs <- c("shiny", "ggplot2", "plotly")

pkgs_needed <- pkgs[!(pkgs %in% installed.packages()[,"Package"])]

if(length(pkgs_needed)) install.packages(pkgs_needed)

## Run app from Github repo
shiny::runGitHub('manolo20/priceindex_calculator') '''
