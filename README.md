
<!-- README.md is generated from README.Rmd. Please edit that file -->
![GitHub Logo](inst/logo/TestContR_150w.png)

TestContR ![](https://travis-ci.org/Fredo-XVII/TestContR.svg?branch=master)
===========================================================================

The primary goal of TestContR is to select randomized Test groups/individuals and matched them with Control groups/individuals using Euclidian distance. You also have the option to provide a list of test groups/individuals where by you can generate a list of control groups/individuals.

------------------------------------------------------------------------

------------------------------------------------------------------------

Example - Randomised Sample match\_\*
-------------------------------------

R contains a crime data set for the all 50 states. This data set contains data on murder rates, assaults, urban population and the occurances of rape. The TestContR can be used to match states that have similar crime rates.

``` r
library(dplyr)
#> Warning: package 'dplyr' was built under R version 3.5.1
library(TestContR)
```

### match\_numeric(): Random Selection of Test and Control groups/individuals for numeric metrics/variables.

``` r
df <- datasets::USArrests %>% dplyr::mutate(state = base::row.names(USArrests)) %>%
                               dplyr::select(state, everything())
```

**Expected data set layout with labels/names/id in the first column:**

``` r
knitr::kable(head(df, n = 10))
```

| state       |  Murder|  Assault|  UrbanPop|  Rape|
|:------------|-------:|--------:|---------:|-----:|
| Alabama     |    13.2|      236|        58|  21.2|
| Alaska      |    10.0|      263|        48|  44.5|
| Arizona     |     8.1|      294|        80|  31.0|
| Arkansas    |     8.8|      190|        50|  19.5|
| California  |     9.0|      276|        91|  40.6|
| Colorado    |     7.9|      204|        78|  38.7|
| Connecticut |     3.3|      110|        77|  11.1|
| Delaware    |     5.9|      238|        72|  15.8|
| Florida     |    15.4|      335|        80|  31.9|
| Georgia     |    17.4|      211|        60|  25.8|

**Build Test and Control list**

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

**Results of random selection option:**

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

#### Providing a list of Test Groups/Individuals

``` r
TEST_GRP <- tribble(~'TEST','Colorado','Minnesota','Florida','South Carolina')
```

**Example of data frame for the "test\_list" input parameter:**

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

**Results for the "test\_list" input parameter:**

``` r
knitr::kable(TEST_CONTROL_LIST)
```

| CONTROL     | TEST           |    DIST\_Q|  GROUP|
|:------------|:---------------|----------:|------:|
| Michigan    | Colorado       |  1.2363108|      1|
| New Mexico  | Florida        |  1.2965798|      2|
| Wisconsin   | Minnesota      |  0.4940832|      3|
| Mississippi | South Carolina |  0.7865674|      4|

### match\_mixed(): Random Select of Test and Control groups/individuals with mixed metrics/variables.

``` r
df <- datasets::USArrests %>% dplyr::mutate(state = base::row.names(datasets::USArrests)) %>%
  base::cbind(datasets::state.division) %>%
  dplyr::select(state, dplyr::everything())
```

**Expected data set layout with labels/names/id in the first column:**

``` r
knitr::kable(head(df, n = 10))
```

| state       |  Murder|  Assault|  UrbanPop|  Rape| datasets::state.division |
|:------------|-------:|--------:|---------:|-----:|:-------------------------|
| Alabama     |    13.2|      236|        58|  21.2| East South Central       |
| Alaska      |    10.0|      263|        48|  44.5| Pacific                  |
| Arizona     |     8.1|      294|        80|  31.0| Mountain                 |
| Arkansas    |     8.8|      190|        50|  19.5| West South Central       |
| California  |     9.0|      276|        91|  40.6| Pacific                  |
| Colorado    |     7.9|      204|        78|  38.7| Mountain                 |
| Connecticut |     3.3|      110|        77|  11.1| New England              |
| Delaware    |     5.9|      238|        72|  15.8| South Atlantic           |
| Florida     |    15.4|      335|        80|  31.9| South Atlantic           |
| Georgia     |    17.4|      211|        60|  25.8| South Atlantic           |

**Build Test and Control list from mixed metrics**

``` r
set.seed(99)
TEST_CONTROL_LIST <- TestContR::match_mixed(df)
#> [1] "The 1th de-duping iteration started"
#> Joining, by = "CONTROL"
#> Joining, by = c("CONTROL", "TEST", "DIST_Q", "GROUP")
#> [1] "The 1th de-duping iteration complete."
```

**Results of random selection option:**

``` r
knitr::kable(TEST_CONTROL_LIST)
```

| CONTROL        | TEST           |    DIST\_Q|  GROUP|
|:---------------|:---------------|----------:|------:|
| Arizona        | Colorado       |  0.1106264|      1|
| Virginia       | Delaware       |  0.1433212|      2|
| Michigan       | Illinois       |  0.1124643|      3|
| Nebraska       | Kansas         |  0.0506973|      4|
| Minnesota      | Missouri       |  0.2307995|      5|
| Pennsylvania   | New Jersey     |  0.1273365|      6|
| South Carolina | North Carolina |  0.0998379|      7|
| Idaho          | Utah           |  0.1403257|      8|
| Oregon         | Washington     |  0.0567921|      9|
| Montana        | Wyoming        |  0.0731182|     10|

------------------------------------------------------------------------

#### Providing a list of Test Groups/Individuals

``` r
TEST_GRP <- tribble(~'TEST','Colorado','Minnesota','Florida','South Carolina')
```

**Example of data frame for the "test\_list" input parameter:**

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
TEST_CONTROL_LIST <- TestContR::match_mixed(df, test_list = TEST_GRP)
```

**Results for the "test\_list" input parameter:**

``` r
knitr::kable(TEST_CONTROL_LIST)
```

| CONTROL        | TEST           |    DIST\_Q|  GROUP|
|:---------------|:---------------|----------:|------:|
| Arizona        | Colorado       |  0.1106264|      1|
| Maryland       | Florida        |  0.1386266|      2|
| Nebraska       | Minnesota      |  0.0616531|      3|
| North Carolina | South Carolina |  0.0998379|      4|

------------------------------------------------------------------------

------------------------------------------------------------------------

Example - topn\_\* selection for individuals or groups
------------------------------------------------------

### topn\_numeric(): Select Top N Controls for a group or individual

Topn\_numeric() is used in the situation where you have 1 test group/individual and you are looking for Top N nearest matches using Euclidian distance. - Note: You can provide more than one group, but the function does not remove duplicates in the control list for the more than 1 group or individual. First, create a dataframe (1x1) as below with the label of the group/individual of interest.

``` r
test_list <- tribble(~"TEST","Colorado")
```

Numeric only dataframe:

``` r
df <- datasets::USArrests %>% dplyr::mutate(state = base::row.names(USArrests)) %>%
                               dplyr::select(state, everything())
```

**Build the list of Top N matches ** Provide the test\_list dataframe to the test\_list parameter in the function as below.

``` r
TOPN_CONTROL_LIST <- TestContR::topn_numeric(df, topN = 10, test_list = test_list)
```

**Results of Top N selection option:**

``` r
knitr::kable(TOPN_CONTROL_LIST) %>% head(20)
#>  [1] "CONTROL      TEST          DIST_Q   DIST_RANK"
#>  [2] "-----------  ---------  ---------  ----------"
#>  [3] "Michigan     Colorado    1.236311           1"
#>  [4] "California   Colorado    1.287618           2"
#>  [5] "Missouri     Colorado    1.312741           3"
#>  [6] "Arizona      Colorado    1.365031           4"
#>  [7] "Nevada       Colorado    1.398859           5"
#>  [8] "Oregon       Colorado    1.533198           6"
#>  [9] "New Mexico   Colorado    1.546744           7"
#> [10] "New York     Colorado    1.736339           8"
#> [11] "Washington   Colorado    1.789792           9"
#> [12] "Illinois     Colorado    1.789832          10"
```

**Top N without a Test List** Don't be concerned about the warning; I just wanted to let users know that it would use all the labels in the dataframe.

``` r
TOPN_CONTROL_LIST <- TestContR::topn_numeric(df, topN = 10)
#> Warning in TestContR::topn_numeric(df, topN = 10): If no dataframe provided for the "test_list" parameter, will use all the labels in the dataset.  Otherwise, please provide a dataframe for the "test_list" parameter with 1, or N, Test group(s) or individual(s) label(s) in a column named "TEST."
#> 
#>       See documentation for topn_numeric's test_list parameter
```

**Results of Top N selection without Test List:**

``` r
knitr::kable(TOPN_CONTROL_LIST) %>% head(20)
#>  [1] "CONTROL          TEST                 DIST_Q   DIST_RANK"
#>  [2] "---------------  ---------------  ----------  ----------"
#>  [3] "Louisiana        Alabama           0.7722224           1"
#>  [4] "Tennessee        Alabama           0.8407489           2"
#>  [5] "South Carolina   Alabama           0.9157968           3"
#>  [6] "Georgia          Alabama           1.1314351           4"
#>  [7] "Mississippi      Alabama           1.2831907           5"
#>  [8] "Maryland         Alabama           1.2896460           6"
#>  [9] "Arkansas         Alabama           1.2898102           7"
#> [10] "Virginia         Alabama           1.4859733           8"
#> [11] "New Mexico       Alabama           1.5993970           9"
#> [12] "North Carolina   Alabama           1.6043662          10"
#> [13] "New Mexico       Alaska            2.0580889           1"
#> [14] "Michigan         Alaska            2.1154937           2"
#> [15] "Maryland         Alaska            2.2777590           3"
#> [16] "Colorado         Alaska            2.3265187           4"
#> [17] "Tennessee        Alaska            2.3362541           5"
#> [18] "Nevada           Alaska            2.3443182           6"
#> [19] "Missouri         Alaska            2.5360573           7"
#> [20] "South Carolina   Alaska            2.5640542           8"
```

<br></br>

### topN\_mixed(): Random Select of Test and Control groups/individuals with mixed metrics/variables.

``` r
df <- datasets::USArrests %>% dplyr::mutate(state = base::row.names(datasets::USArrests)) %>%
  base::cbind(datasets::state.division) %>%
  dplyr::select(state, dplyr::everything())
```

**Expected data set layout with labels/names/id in the first column:**

``` r
knitr::kable(head(df, n = 10))
```

| state       |  Murder|  Assault|  UrbanPop|  Rape| datasets::state.division |
|:------------|-------:|--------:|---------:|-----:|:-------------------------|
| Alabama     |    13.2|      236|        58|  21.2| East South Central       |
| Alaska      |    10.0|      263|        48|  44.5| Pacific                  |
| Arizona     |     8.1|      294|        80|  31.0| Mountain                 |
| Arkansas    |     8.8|      190|        50|  19.5| West South Central       |
| California  |     9.0|      276|        91|  40.6| Pacific                  |
| Colorado    |     7.9|      204|        78|  38.7| Mountain                 |
| Connecticut |     3.3|      110|        77|  11.1| New England              |
| Delaware    |     5.9|      238|        72|  15.8| South Atlantic           |
| Florida     |    15.4|      335|        80|  31.9| South Atlantic           |
| Georgia     |    17.4|      211|        60|  25.8| South Atlantic           |

**Build Test and Control list from mixed metrics**

``` r
set.seed(99)
TOPN_CONTROL_LIST <- TestContR::topn_mixed(df, topN = 10, test_list = test_list)
```

**Results of Top N selection without Test List:**

``` r
knitr::kable(TOPN_CONTROL_LIST) %>% head(20)
#>  [1] "CONTROL      TEST           DIST_Q   DIST_RANK"
#>  [2] "-----------  ---------  ----------  ----------"
#>  [3] "Arizona      Colorado    0.1106264           1"
#>  [4] "Nevada       Colorado    0.1325795           2"
#>  [5] "New Mexico   Colorado    0.1588753           3"
#>  [6] "Utah         Colorado    0.2025942           4"
#>  [7] "Wyoming      Colorado    0.2231019           5"
#>  [8] "Montana      Colorado    0.2879513           6"
#>  [9] "Missouri     Colorado    0.3124434           7"
#> [10] "California   Colorado    0.3164550           8"
#> [11] "Michigan     Colorado    0.3176979           9"
#> [12] "Idaho        Colorado    0.3293606          10"
```

**Top N Mixed without a Test List** Don't be concerned about the warning; I just wanted to let users know that it would use all the labels in the dataframe.

``` r
TOPN_CONTROL_LIST <- TestContR::topn_mixed(df, topN = 10)
#> Warning in TestContR::topn_mixed(df, topN = 10): If no dataframe provided for the "test_list" parameter, will use all the labels in the dataset.  Otherwise, please provide a dataframe for the "test_list" parameter with 1, or N, Test group(s) or individual(s) label(s) in a column named "TEST."
#> 
#>       See documentation for topn_numeric's test_list parameter
```

**Results of Top N selection without Test List:**

``` r
knitr::kable(TOPN_CONTROL_LIST) %>% head(20)
#>  [1] "CONTROL          TEST                 DIST_Q   DIST_RANK"
#>  [2] "---------------  ---------------  ----------  ----------"
#>  [3] "Tennessee        Alabama           0.0657239           1"
#>  [4] "Mississippi      Alabama           0.1193394           2"
#>  [5] "Kentucky         Alabama           0.1748170           3"
#>  [6] "Louisiana        Alabama           0.2676967           4"
#>  [7] "South Carolina   Alabama           0.2845265           5"
#>  [8] "Georgia          Alabama           0.2982780           6"
#>  [9] "Arkansas         Alabama           0.3204231           7"
#> [10] "Texas            Alabama           0.3267952           8"
#> [11] "Virginia         Alabama           0.3309542           9"
#> [12] "Maryland         Alabama           0.3313442          10"
#> [13] "California       Alaska            0.1868701           1"
#> [14] "Oregon           Alaska            0.2756384           2"
#> [15] "Washington       Alaska            0.3324305           3"
#> [16] "Nevada           Alaska            0.3536566           4"
#> [17] "Michigan         Alaska            0.3674951           5"
#> [18] "New Mexico       Alaska            0.3705949           6"
#> [19] "South Carolina   Alaska            0.3776660           7"
#> [20] "Maryland         Alaska            0.3917168           8"
```

------------------------------------------------------------------------

------------------------------------------------------------------------

### Conclusion

Depending on your experiment, it may be prudent to add categorical metrics/variables that will help align your data better. In the above examples, when only using the numerical data Alabama's nearest match is Louisiana, but once region is taken into consideration, Alabama's nearest match is Tennessee. Now you have the tools to create a list of nearest matches for your data whether it is numeric or mixed.

------------------------------------------------------------------------

------------------------------------------------------------------------
