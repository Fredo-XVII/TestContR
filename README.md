
<!-- README.md is generated from README.Rmd. Please edit that file -->
TestContR
=========

The primary goal of TestContR is to select randomized Test groups/individuals and matched them with Control groups/individuals using Euclidian distance. You also have the option to provide a list of test stores and generate a list of control stores.

Example
-------

R contains a crime data set for the all 50 states. This data set contains data on murder rates, assaults, urban population and the occurances of rape. The TestContR can be used to match states that have crime rates that are very similar.

``` r
library(tidyverse)
library(TestContR)
```

### Random Selection of Test and Control groups/individuals

``` r
set.seed(1977)
df <- datasets::USArrests %>% dplyr::mutate(state = base::row.names(USArrests)) %>%
                               dplyr::select(state, everything())
#> Warning: package 'bindrcpp' was built under R version 3.4.4

TEST_CONTROL_LIST <- TestContR::match_numeric(df)
#> [1] "The 1th de-duping iteration started"
#> Joining, by = "CONTROL"
#> Joining, by = c("CONTROL", "TEST", "DIST_Q", "GROUP")
#> [1] "The 1th de-duping iteration complete."
```

``` r
TEST_CONTROL_LIST
#> # A tibble: 10 x 4
#>    CONTROL        TEST         DIST_Q GROUP
#>    <fct>          <fct>         <dbl> <int>
#>  1 Pennsylvania   Connecticut   0.872     1
#>  2 South Carolina Georgia       1.40      2
#>  3 Montana        Kentucky      0.852     3
#>  4 Alabama        Louisiana     0.772     4
#>  5 New Hampshire  Maine         0.500     5
#>  6 New Mexico     Maryland      0.535     6
#>  7 Virginia       Missouri      0.979     7
#>  8 Kansas         Nebraska      0.528     8
#>  9 Vermont        North Dakota  0.982     9
#> 10 Arkansas       Tennessee     1.43     10
```

<br></br>

### Providing a list of Test Groups/Individuals

``` r
TEST_GRP <- tribble(~'TEST','Colorado','Minnesota','Florida','South Carolina')
TEST_GRP
#> # A tibble: 4 x 1
#>   TEST          
#>   <chr>         
#> 1 Colorado      
#> 2 Minnesota     
#> 3 Florida       
#> 4 South Carolina
```

``` r
set.seed(1977)
TEST_CONTROL_LIST <- TestContR::match_numeric(df, test_list = TEST_GRP)
```

``` r
TEST_CONTROL_LIST
#> # A tibble: 4 x 4
#>   CONTROL     TEST           DIST_Q GROUP
#>   <fct>       <fct>           <dbl> <int>
#> 1 Michigan    Colorado        1.24      1
#> 2 New Mexico  Florida         1.30      2
#> 3 Wisconsin   Minnesota       0.494     3
#> 4 Mississippi South Carolina  0.787     4
```
