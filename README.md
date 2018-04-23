
<!-- README.md is generated from README.Rmd. Please edit that file -->
TestContR
=========

The primary goal of TestContR is to select randomized Test groups/individuals and matched them with Control groups/individuals using Euclidian distance. You also have the option to provide a list of test groups/individuals where by you can generate a list of control groups/individuals.

Example
-------

R contains a crime data set for the all 50 states. This data set contains data on murder rates, assaults, urban population and the occurances of rape. The TestContR can be used to match states that have similar crime rates.

``` r
library(tidyverse)
library(TestContR)
```

### Random Selection of Test and Control groups/individuals

``` r
df <- datasets::USArrests %>% dplyr::mutate(state = base::row.names(USArrests)) %>%
                               dplyr::select(state, everything())
```

Expected data set layout with labels/names/id in the first column:

``` r
knitr::kable(df)
```

| state          |  Murder|  Assault|  UrbanPop|  Rape|
|:---------------|-------:|--------:|---------:|-----:|
| Alabama        |    13.2|      236|        58|  21.2|
| Alaska         |    10.0|      263|        48|  44.5|
| Arizona        |     8.1|      294|        80|  31.0|
| Arkansas       |     8.8|      190|        50|  19.5|
| California     |     9.0|      276|        91|  40.6|
| Colorado       |     7.9|      204|        78|  38.7|
| Connecticut    |     3.3|      110|        77|  11.1|
| Delaware       |     5.9|      238|        72|  15.8|
| Florida        |    15.4|      335|        80|  31.9|
| Georgia        |    17.4|      211|        60|  25.8|
| Hawaii         |     5.3|       46|        83|  20.2|
| Idaho          |     2.6|      120|        54|  14.2|
| Illinois       |    10.4|      249|        83|  24.0|
| Indiana        |     7.2|      113|        65|  21.0|
| Iowa           |     2.2|       56|        57|  11.3|
| Kansas         |     6.0|      115|        66|  18.0|
| Kentucky       |     9.7|      109|        52|  16.3|
| Louisiana      |    15.4|      249|        66|  22.2|
| Maine          |     2.1|       83|        51|   7.8|
| Maryland       |    11.3|      300|        67|  27.8|
| Massachusetts  |     4.4|      149|        85|  16.3|
| Michigan       |    12.1|      255|        74|  35.1|
| Minnesota      |     2.7|       72|        66|  14.9|
| Mississippi    |    16.1|      259|        44|  17.1|
| Missouri       |     9.0|      178|        70|  28.2|
| Montana        |     6.0|      109|        53|  16.4|
| Nebraska       |     4.3|      102|        62|  16.5|
| Nevada         |    12.2|      252|        81|  46.0|
| New Hampshire  |     2.1|       57|        56|   9.5|
| New Jersey     |     7.4|      159|        89|  18.8|
| New Mexico     |    11.4|      285|        70|  32.1|
| New York       |    11.1|      254|        86|  26.1|
| North Carolina |    13.0|      337|        45|  16.1|
| North Dakota   |     0.8|       45|        44|   7.3|
| Ohio           |     7.3|      120|        75|  21.4|
| Oklahoma       |     6.6|      151|        68|  20.0|
| Oregon         |     4.9|      159|        67|  29.3|
| Pennsylvania   |     6.3|      106|        72|  14.9|
| Rhode Island   |     3.4|      174|        87|   8.3|
| South Carolina |    14.4|      279|        48|  22.5|
| South Dakota   |     3.8|       86|        45|  12.8|
| Tennessee      |    13.2|      188|        59|  26.9|
| Texas          |    12.7|      201|        80|  25.5|
| Utah           |     3.2|      120|        80|  22.9|
| Vermont        |     2.2|       48|        32|  11.2|
| Virginia       |     8.5|      156|        63|  20.7|
| Washington     |     4.0|      145|        73|  26.2|
| West Virginia  |     5.7|       81|        39|   9.3|
| Wisconsin      |     2.6|       53|        66|  10.8|
| Wyoming        |     6.8|      161|        60|  15.6|

``` r
set.seed(99)
TEST_CONTROL_LIST <- TestContR::match_numeric(df)
#> [1] "The 1th de-duping iteration started"
#> Joining, by = "CONTROL"
#> Joining, by = c("CONTROL", "TEST", "DIST_Q", "GROUP")
#> [1] "The 1th de-duping iteration complete."
#> [1] "The 2th de-duping iteration started"
#> Joining, by = "CONTROL"
#> Joining, by = c("CONTROL", "TEST", "DIST_Q", "GROUP")
#> [1] "The 2th de-duping iteration complete."
```

Results of random selection option:

``` r
knitr::kable(TEST_CONTROL_LIST)
```

| CONTROL        | TEST           |    DIST\_Q|  GROUP|
|:---------------|:---------------|----------:|------:|
| Michigan       | Colorado       |  1.2363108|      1|
| Oklahoma       | Delaware       |  1.1802929|      2|
| New York       | Illinois       |  0.3502188|      3|
| Indiana        | Kansas         |  0.4287712|      4|
| Texas          | Missouri       |  1.1654171|      5|
| Massachusetts  | New Jersey     |  0.7977642|      6|
| South Carolina | North Carolina |  1.0476313|      7|
| Ohio           | Utah           |  1.0154223|      8|
| Oregon         | Washington     |  0.5935343|      9|
| Virginia       | Wyoming        |  0.7038309|     10|
| <br></br>      |                |           |       |

### Providing a list of Test Groups/Individuals

``` r
TEST_GRP <- tribble(~'TEST','Colorado','Minnesota','Florida','South Carolina')
```

Example of data frame for the test input parameter:

``` r
knitr::kable(TEST_GRP)
```

| TEST           |
|:---------------|
| Colorado       |
| Minnesota      |
| Florida        |
| South Carolina |

``` r
set.seed(99)
TEST_CONTROL_LIST <- TestContR::match_numeric(df, test_list = TEST_GRP)
```

``` r
knitr::kable(TEST_CONTROL_LIST)
```

| CONTROL     | TEST           |    DIST\_Q|  GROUP|
|:------------|:---------------|----------:|------:|
| Michigan    | Colorado       |  1.2363108|      1|
| New Mexico  | Florida        |  1.2965798|      2|
| Wisconsin   | Minnesota      |  0.4940832|      3|
| Mississippi | South Carolina |  0.7865674|      4|
