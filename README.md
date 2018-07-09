
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
#> Warning: package 'dplyr' was built under R version 3.4.4
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
knitr::kable(TOPN_CONTROL_LIST)
```

| CONTROL    | TEST     |   DIST\_Q|  DIST\_RANK|
|:-----------|:---------|---------:|-----------:|
| Michigan   | Colorado |  1.236311|           1|
| California | Colorado |  1.287618|           2|
| Missouri   | Colorado |  1.312741|           3|
| Arizona    | Colorado |  1.365031|           4|
| Nevada     | Colorado |  1.398859|           5|
| Oregon     | Colorado |  1.533198|           6|
| New Mexico | Colorado |  1.546744|           7|
| New York   | Colorado |  1.736339|           8|
| Washington | Colorado |  1.789792|           9|
| Illinois   | Colorado |  1.789832|          10|

**Top N without a Test List** Don't be concerned about the warning; I just wanted to let users know that it would use all the labels in the dataframe.

``` r
TOPN_CONTROL_LIST <- TestContR::topn_numeric(df, topN = 10)
#> Warning in TestContR::topn_numeric(df, topN = 10): If no dataframe provided for the "test_list" parameter, will use all the labels in the dataset.  Otherwise, please provide a dataframe for the "test_list" parameter with 1, or N, Test group(s) or individual(s) label(s) in a column named "TEST."
#> 
#>       See documentation for topn_numeric's test_list parameter
```

**Results of Top N selection without Test List:**

``` r
knitr::kable(TOPN_CONTROL_LIST)
```

| CONTROL        | TEST           |    DIST\_Q|  DIST\_RANK|
|:---------------|:---------------|----------:|-----------:|
| Louisiana      | Alabama        |  0.7722224|           1|
| Tennessee      | Alabama        |  0.8407489|           2|
| South Carolina | Alabama        |  0.9157968|           3|
| Georgia        | Alabama        |  1.1314351|           4|
| Mississippi    | Alabama        |  1.2831907|           5|
| Maryland       | Alabama        |  1.2896460|           6|
| Arkansas       | Alabama        |  1.2898102|           7|
| Virginia       | Alabama        |  1.4859733|           8|
| New Mexico     | Alabama        |  1.5993970|           9|
| North Carolina | Alabama        |  1.6043662|          10|
| New Mexico     | Alaska         |  2.0580889|           1|
| Michigan       | Alaska         |  2.1154937|           2|
| Maryland       | Alaska         |  2.2777590|           3|
| Colorado       | Alaska         |  2.3265187|           4|
| Tennessee      | Alaska         |  2.3362541|           5|
| Nevada         | Alaska         |  2.3443182|           6|
| Missouri       | Alaska         |  2.5360573|           7|
| South Carolina | Alaska         |  2.5640542|           8|
| Oregon         | Alaska         |  2.6990696|           9|
| Arizona        | Alaska         |  2.7006429|          10|
| New Mexico     | Arizona        |  1.0376848|           1|
| New York       | Arizona        |  1.0725219|           2|
| Illinois       | Arizona        |  1.0825512|           3|
| Michigan       | Arizona        |  1.1940906|           4|
| Maryland       | Arizona        |  1.2117356|           5|
| California     | Arizona        |  1.3104842|           6|
| Colorado       | Arizona        |  1.3650307|           7|
| Missouri       | Arizona        |  1.5958731|           8|
| Texas          | Arizona        |  1.6448574|           9|
| Florida        | Arizona        |  1.7493928|          10|
| Wyoming        | Arkansas       |  0.9912639|           1|
| Virginia       | Arkansas       |  0.9971035|           2|
| Kentucky       | Arkansas       |  1.0598104|           3|
| Montana        | Arkansas       |  1.2290066|           4|
| Alabama        | Arkansas       |  1.2898102|           5|
| Oklahoma       | Arkansas       |  1.4224574|           6|
| Tennessee      | Arkansas       |  1.4254486|           7|
| Indiana        | Arkansas       |  1.4450503|           8|
| Kansas         | Arkansas       |  1.5718411|           9|
| Missouri       | Arkansas       |  1.6717500|          10|
| Nevada         | California     |  1.1968261|           1|
| Colorado       | California     |  1.2876185|           2|
| Arizona        | California     |  1.3104842|           3|
| Michigan       | California     |  1.5146739|           4|
| New York       | California     |  1.6787069|           5|
| New Mexico     | California     |  1.8010201|           6|
| Illinois       | California     |  1.9117469|           7|
| Florida        | California     |  2.0250039|           8|
| Texas          | California     |  2.1698156|           9|
| Maryland       | California     |  2.2312581|          10|
| Michigan       | Colorado       |  1.2363108|           1|
| California     | Colorado       |  1.2876185|           2|
| Missouri       | Colorado       |  1.3127406|           3|
| Arizona        | Colorado       |  1.3650307|           4|
| Nevada         | Colorado       |  1.3988595|           5|
| Oregon         | Colorado       |  1.5331980|           6|
| New Mexico     | Colorado       |  1.5467439|           7|
| New York       | Colorado       |  1.7363385|           8|
| Washington     | Colorado       |  1.7897920|           9|
| Illinois       | Colorado       |  1.7898322|          10|
| Pennsylvania   | Connecticut    |  0.8721491|           1|
| Massachusetts  | Connecticut    |  0.9468199|           2|
| Minnesota      | Connecticut    |  0.9843793|           3|
| Wisconsin      | Connecticut    |  1.0354597|           4|
| Rhode Island   | Connecticut    |  1.0756115|           5|
| Nebraska       | Connecticut    |  1.2116949|           6|
| Kansas         | Connecticut    |  1.2280424|           7|
| Utah           | Connecticut    |  1.2825907|           8|
| Hawaii         | Connecticut    |  1.3843291|           9|
| Ohio           | Connecticut    |  1.4443671|          10|
| Oklahoma       | Delaware       |  1.1802929|           1|
| Wyoming        | Delaware       |  1.2586225|           2|
| Virginia       | Delaware       |  1.4088230|           3|
| Massachusetts  | Delaware       |  1.4382527|           4|
| Kansas         | Delaware       |  1.5510864|           5|
| Illinois       | Delaware       |  1.5584719|           6|
| New Jersey     | Delaware       |  1.5808719|           7|
| Ohio           | Delaware       |  1.5838515|           8|
| Pennsylvania   | Delaware       |  1.5894850|           9|
| Rhode Island   | Delaware       |  1.6230495|          10|
| New Mexico     | Florida        |  1.2965798|           1|
| Michigan       | Florida        |  1.3357020|           2|
| Maryland       | Florida        |  1.4355204|           3|
| New York       | Florida        |  1.5730970|           4|
| Arizona        | Florida        |  1.7493928|           5|
| Louisiana      | Florida        |  1.7529677|           6|
| Illinois       | Florida        |  1.7711863|           7|
| Texas          | Florida        |  1.8537984|           8|
| Nevada         | Florida        |  1.9500388|           9|
| California     | Florida        |  2.0250039|          10|
| Louisiana      | Georgia        |  0.8592544|           1|
| Tennessee      | Georgia        |  1.0122252|           2|
| Alabama        | Georgia        |  1.1314351|           3|
| South Carolina | Georgia        |  1.3970074|           4|
| Mississippi    | Georgia        |  1.5828594|           5|
| Texas          | Georgia        |  1.7575559|           6|
| Maryland       | Georgia        |  1.8388691|           7|
| New Mexico     | Georgia        |  1.9015384|           8|
| Michigan       | Georgia        |  1.9185489|           9|
| Missouri       | Georgia        |  2.1021909|          10|
| Utah           | Hawaii         |  1.0709720|           1|
| Ohio           | Hawaii         |  1.1494313|           2|
| Pennsylvania   | Hawaii         |  1.2119256|           3|
| Massachusetts  | Hawaii         |  1.3276676|           4|
| Connecticut    | Hawaii         |  1.3843291|           5|
| Kansas         | Hawaii         |  1.4648766|           6|
| Minnesota      | Hawaii         |  1.4673850|           7|
| New Jersey     | Hawaii         |  1.5050500|           8|
| Washington     | Hawaii         |  1.5452901|           9|
| Indiana        | Hawaii         |  1.5460727|          10|
| Nebraska       | Idaho          |  0.7515014|           1|
| South Dakota   | Idaho          |  0.8070290|           2|
| Montana        | Idaho          |  0.8286936|           3|
| Maine          | Idaho          |  0.8486112|           4|
| Iowa           | Idaho          |  0.8584962|           5|
| New Hampshire  | Idaho          |  0.9249563|           6|
| Minnesota      | Idaho          |  1.0124936|           7|
| Wyoming        | Idaho          |  1.1687896|           8|
| Kansas         | Idaho          |  1.2103118|           9|
| Wisconsin      | Idaho          |  1.2105401|          10|
| New York       | Illinois       |  0.3502188|           1|
| Texas          | Illinois       |  0.8241352|           2|
| Arizona        | Illinois       |  1.0825512|           3|
| New Mexico     | Illinois       |  1.3393276|           4|
| Maryland       | Illinois       |  1.3429997|           5|
| Missouri       | Illinois       |  1.3552973|           6|
| Michigan       | Illinois       |  1.3959090|           7|
| New Jersey     | Illinois       |  1.4562775|           8|
| Delaware       | Illinois       |  1.5584719|           9|
| Louisiana      | Illinois       |  1.6535178|          10|
| Kansas         | Indiana        |  0.4287712|           1|
| Oklahoma       | Indiana        |  0.5303259|           2|
| Virginia       | Indiana        |  0.6127246|           3|
| Ohio           | Indiana        |  0.6976320|           4|
| Pennsylvania   | Indiana        |  0.8412900|           5|
| Nebraska       | Indiana        |  0.8570429|           6|
| Wyoming        | Indiana        |  0.8898783|           7|
| Montana        | Indiana        |  1.0033431|           8|
| Washington     | Indiana        |  1.1405746|           9|
| Oregon         | Indiana        |  1.1780815|          10|
| New Hampshire  | Iowa           |  0.2058539|           1|
| Wisconsin      | Iowa           |  0.6318069|           2|
| Maine          | Iowa           |  0.6457158|           3|
| Minnesota      | Iowa           |  0.7644384|           4|
| Idaho          | Iowa           |  0.8584962|           5|
| Nebraska       | Iowa           |  0.9821819|           6|
| South Dakota   | Iowa           |  0.9886706|           7|
| North Dakota   | Iowa           |  1.0534375|           8|
| Montana        | Iowa           |  1.2403561|           9|
| Kansas         | Iowa           |  1.4699265|          10|
| Indiana        | Kansas         |  0.4287712|           1|
| Oklahoma       | Kansas         |  0.5198728|           2|
| Nebraska       | Kansas         |  0.5279092|           3|
| Pennsylvania   | Kansas         |  0.5456840|           4|
| Wyoming        | Kansas         |  0.7588728|           5|
| Ohio           | Kansas         |  0.7817000|           6|
| Virginia       | Kansas         |  0.8351949|           7|
| Montana        | Kansas         |  0.9170466|           8|
| Minnesota      | Kansas         |  0.9745872|           9|
| Washington     | Kansas         |  1.1579118|          10|
| Montana        | Kentucky       |  0.8523702|           1|
| Arkansas       | Kentucky       |  1.0598104|           2|
| Wyoming        | Kentucky       |  1.0694408|           3|
| Virginia       | Kentucky       |  1.0918624|           4|
| Indiana        | Kentucky       |  1.1790552|           5|
| Kansas         | Kentucky       |  1.3020180|           6|
| Nebraska       | Kentucky       |  1.4219429|           7|
| Oklahoma       | Kentucky       |  1.4623483|           8|
| South Dakota   | Kentucky       |  1.5114990|           9|
| West Virginia  | Kentucky       |  1.5236299|          10|
| Alabama        | Louisiana      |  0.7722224|           1|
| Georgia        | Louisiana      |  0.8592544|           2|
| Tennessee      | Louisiana      |  1.1298534|           3|
| Maryland       | Louisiana      |  1.2739137|           4|
| South Carolina | Louisiana      |  1.3151908|           5|
| Texas          | Louisiana      |  1.3325285|           6|
| New Mexico     | Louisiana      |  1.4911656|           7|
| Mississippi    | Louisiana      |  1.6268879|           8|
| Illinois       | Louisiana      |  1.6535178|           9|
| Michigan       | Louisiana      |  1.6677999|          10|
| New Hampshire  | Maine          |  0.4995971|           1|
| Iowa           | Maine          |  0.6457158|           2|
| North Dakota   | Maine          |  0.7305609|           3|
| South Dakota   | Maine          |  0.7812991|           4|
| Idaho          | Maine          |  0.8486112|           5|
| Wisconsin      | Maine          |  1.1485830|           6|
| West Virginia  | Maine          |  1.1818120|           7|
| Minnesota      | Maine          |  1.2980362|           8|
| Nebraska       | Maine          |  1.3218907|           9|
| Montana        | Maine          |  1.3271199|          10|
| New Mexico     | Maryland       |  0.5353893|           1|
| Michigan       | Maryland       |  1.0800988|           2|
| Arizona        | Maryland       |  1.2117356|           3|
| Louisiana      | Maryland       |  1.2739137|           4|
| Alabama        | Maryland       |  1.2896460|           5|
| Illinois       | Maryland       |  1.3429997|           6|
| Florida        | Maryland       |  1.4355204|           7|
| New York       | Maryland       |  1.4362170|           8|
| Tennessee      | Maryland       |  1.5202431|           9|
| Texas          | Maryland       |  1.5431868|          10|
| New Jersey     | Massachusetts  |  0.7977642|           1|
| Utah           | Massachusetts  |  0.9015809|           2|
| Rhode Island   | Massachusetts  |  0.9440940|           3|
| Connecticut    | Massachusetts  |  0.9468199|           4|
| Pennsylvania   | Massachusetts  |  1.1337883|           5|
| Ohio           | Massachusetts  |  1.1567960|           6|
| Hawaii         | Massachusetts  |  1.3276676|           7|
| Oklahoma       | Massachusetts  |  1.3383233|           8|
| Washington     | Massachusetts  |  1.3472994|           9|
| Kansas         | Massachusetts  |  1.4343401|          10|
| New Mexico     | Michigan       |  0.5782474|           1|
| Maryland       | Michigan       |  1.0800988|           2|
| Arizona        | Michigan       |  1.1940906|           3|
| Colorado       | Michigan       |  1.2363108|           4|
| Nevada         | Michigan       |  1.2609417|           5|
| Texas          | Michigan       |  1.2888621|           6|
| New York       | Michigan       |  1.2897453|           7|
| Florida        | Michigan       |  1.3357020|           8|
| Illinois       | Michigan       |  1.3959090|           9|
| Missouri       | Michigan       |  1.4068840|          10|
| Wisconsin      | Minnesota      |  0.4940832|           1|
| Nebraska       | Minnesota      |  0.6083415|           2|
| Iowa           | Minnesota      |  0.7644384|           3|
| New Hampshire  | Minnesota      |  0.9279247|           4|
| Kansas         | Minnesota      |  0.9745872|           5|
| Connecticut    | Minnesota      |  0.9843793|           6|
| Pennsylvania   | Minnesota      |  1.0106613|           7|
| Idaho          | Minnesota      |  1.0124936|           8|
| Montana        | Minnesota      |  1.2662635|           9|
| Maine          | Minnesota      |  1.2980362|          10|
| South Carolina | Mississippi    |  0.7865674|           1|
| North Carolina | Mississippi    |  1.1826891|           2|
| Alabama        | Mississippi    |  1.2831907|           3|
| Georgia        | Mississippi    |  1.5828594|           4|
| Louisiana      | Mississippi    |  1.6268879|           5|
| Tennessee      | Mississippi    |  1.8269569|           6|
| Arkansas       | Mississippi    |  1.9318631|           7|
| Maryland       | Mississippi    |  2.2992240|           8|
| Kentucky       | Mississippi    |  2.3898884|           9|
| Virginia       | Mississippi    |  2.5383053|          10|
| Virginia       | Missouri       |  0.9787310|           1|
| Oregon         | Missouri       |  0.9974171|           2|
| Oklahoma       | Missouri       |  1.0927654|           3|
| Ohio           | Missouri       |  1.1327425|           4|
| Texas          | Missouri       |  1.1654171|           5|
| Indiana        | Missouri       |  1.2203931|           6|
| Tennessee      | Missouri       |  1.2413874|           7|
| Washington     | Missouri       |  1.2502752|           8|
| Colorado       | Missouri       |  1.3127406|           9|
| Illinois       | Missouri       |  1.3552973|          10|
| Nebraska       | Montana        |  0.7389936|           1|
| Wyoming        | Montana        |  0.8150071|           2|
| Idaho          | Montana        |  0.8286936|           3|
| Kentucky       | Montana        |  0.8523702|           4|
| South Dakota   | Montana        |  0.8857149|           5|
| Kansas         | Montana        |  0.9170466|           6|
| Indiana        | Montana        |  1.0033431|           7|
| Virginia       | Montana        |  1.1556682|           8|
| Oklahoma       | Montana        |  1.2225315|           9|
| Arkansas       | Montana        |  1.2290066|          10|
| Kansas         | Nebraska       |  0.5279092|           1|
| Minnesota      | Nebraska       |  0.6083415|           2|
| Montana        | Nebraska       |  0.7389936|           3|
| Idaho          | Nebraska       |  0.7515014|           4|
| Pennsylvania   | Nebraska       |  0.8483058|           5|
| Indiana        | Nebraska       |  0.8570429|           6|
| Wyoming        | Nebraska       |  0.9268202|           7|
| Oklahoma       | Nebraska       |  0.9674809|           8|
| Wisconsin      | Nebraska       |  0.9719877|           9|
| Iowa           | Nebraska       |  0.9821819|          10|
| California     | Nevada         |  1.1968261|           1|
| Michigan       | Nevada         |  1.2609417|           2|
| Colorado       | Nevada         |  1.3988595|           3|
| New Mexico     | Nevada         |  1.7234839|           4|
| Arizona        | Nevada         |  1.9260292|           5|
| Florida        | Nevada         |  1.9500388|           6|
| New York       | Nevada         |  2.1674148|           7|
| Maryland       | Nevada         |  2.2551337|           8|
| Texas          | Nevada         |  2.2765693|           9|
| Alaska         | Nevada         |  2.3443182|          10|
| Iowa           | New Hampshire  |  0.2058539|           1|
| Maine          | New Hampshire  |  0.4995971|           2|
| Wisconsin      | New Hampshire  |  0.7155628|           3|
| North Dakota   | New Hampshire  |  0.9231894|           4|
| Idaho          | New Hampshire  |  0.9249563|           5|
| Minnesota      | New Hampshire  |  0.9279247|           6|
| South Dakota   | New Hampshire  |  0.9874611|           7|
| Nebraska       | New Hampshire  |  1.1300720|           8|
| Montana        | New Hampshire  |  1.3329504|           9|
| West Virginia  | New Hampshire  |  1.4648924|          10|
| Massachusetts  | New Jersey     |  0.7977642|           1|
| Ohio           | New Jersey     |  1.1099823|           2|
| Utah           | New Jersey     |  1.3141843|           3|
| Pennsylvania   | New Jersey     |  1.4216058|           4|
| Illinois       | New Jersey     |  1.4562775|           5|
| Rhode Island   | New Jersey     |  1.4668378|           6|
| Oklahoma       | New Jersey     |  1.4711183|           7|
| Hawaii         | New Jersey     |  1.5050500|           8|
| Washington     | New Jersey     |  1.5759539|           9|
| Delaware       | New Jersey     |  1.5808719|          10|
| Maryland       | New Mexico     |  0.5353893|           1|
| Michigan       | New Mexico     |  0.5782474|           2|
| Arizona        | New Mexico     |  1.0376848|           3|
| Florida        | New Mexico     |  1.2965798|           4|
| New York       | New Mexico     |  1.3324096|           5|
| Illinois       | New Mexico     |  1.3393276|           6|
| Texas          | New Mexico     |  1.4418241|           7|
| Missouri       | New Mexico     |  1.4579057|           8|
| Louisiana      | New Mexico     |  1.4911656|           9|
| Colorado       | New Mexico     |  1.5467439|          10|
| Illinois       | New York       |  0.3502188|           1|
| Texas          | New York       |  0.8457697|           2|
| Arizona        | New York       |  1.0725219|           3|
| Michigan       | New York       |  1.2897453|           4|
| New Mexico     | New York       |  1.3324096|           5|
| Maryland       | New York       |  1.4362170|           6|
| Missouri       | New York       |  1.5284764|           7|
| Florida        | New York       |  1.5730970|           8|
| New Jersey     | New York       |  1.6344744|           9|
| California     | New York       |  1.6787069|          10|
| South Carolina | North Carolina |  1.0476313|           1|
| Mississippi    | North Carolina |  1.1826891|           2|
| Alabama        | North Carolina |  1.6043662|           3|
| Louisiana      | North Carolina |  1.9868618|           4|
| Maryland       | North Carolina |  2.0542355|           5|
| Arkansas       | North Carolina |  2.0717938|           6|
| Georgia        | North Carolina |  2.3351307|           7|
| Tennessee      | North Carolina |  2.3374653|           8|
| New Mexico     | North Carolina |  2.5348334|           9|
| Delaware       | North Carolina |  2.7475286|          10|
| Maine          | North Dakota   |  0.7305609|           1|
| New Hampshire  | North Dakota   |  0.9231894|           2|
| Vermont        | North Dakota   |  0.9824857|           3|
| South Dakota   | North Dakota   |  1.0324944|           4|
| Iowa           | North Dakota   |  1.0534375|           5|
| West Virginia  | North Dakota   |  1.2716808|           6|
| Idaho          | North Dakota   |  1.4144557|           7|
| Wisconsin      | North Dakota   |  1.6216339|           8|
| Minnesota      | North Dakota   |  1.8065731|           9|
| Montana        | North Dakota   |  1.8291157|          10|
| Oklahoma       | Ohio           |  0.6483903|           1|
| Indiana        | Ohio           |  0.6976320|           2|
| Pennsylvania   | Ohio           |  0.7781298|           3|
| Kansas         | Ohio           |  0.7817000|           4|
| Washington     | Ohio           |  0.9725013|           5|
| Virginia       | Ohio           |  0.9774388|           6|
| Utah           | Ohio           |  1.0154223|           7|
| New Jersey     | Ohio           |  1.1099823|           8|
| Missouri       | Ohio           |  1.1327425|           9|
| Hawaii         | Ohio           |  1.1494313|          10|
| Kansas         | Oklahoma       |  0.5198728|           1|
| Indiana        | Oklahoma       |  0.5303259|           2|
| Virginia       | Oklahoma       |  0.5646254|           3|
| Ohio           | Oklahoma       |  0.6483903|           4|
| Wyoming        | Oklahoma       |  0.7366465|           5|
| Pennsylvania   | Oklahoma       |  0.8180221|           6|
| Washington     | Oklahoma       |  0.9586525|           7|
| Nebraska       | Oklahoma       |  0.9674809|           8|
| Oregon         | Oklahoma       |  1.0734082|           9|
| Missouri       | Oklahoma       |  1.0927654|          10|
| Washington     | Oregon         |  0.5935343|           1|
| Missouri       | Oregon         |  0.9974171|           2|
| Oklahoma       | Oregon         |  1.0734082|           3|
| Indiana        | Oregon         |  1.1780815|           4|
| Ohio           | Oregon         |  1.2407607|           5|
| Virginia       | Oregon         |  1.2664430|           6|
| Utah           | Oregon         |  1.2825152|           7|
| Kansas         | Oregon         |  1.3426890|           8|
| Colorado       | Oregon         |  1.5331980|           9|
| Nebraska       | Oregon         |  1.5727910|          10|
| Kansas         | Pennsylvania   |  0.5456840|           1|
| Ohio           | Pennsylvania   |  0.7781298|           2|
| Oklahoma       | Pennsylvania   |  0.8180221|           3|
| Indiana        | Pennsylvania   |  0.8412900|           4|
| Nebraska       | Pennsylvania   |  0.8483058|           5|
| Connecticut    | Pennsylvania   |  0.8721491|           6|
| Minnesota      | Pennsylvania   |  1.0106613|           7|
| Wyoming        | Pennsylvania   |  1.0684605|           8|
| Massachusetts  | Pennsylvania   |  1.1337883|           9|
| Virginia       | Pennsylvania   |  1.1769236|          10|
| Massachusetts  | Rhode Island   |  0.9440940|           1|
| Connecticut    | Rhode Island   |  1.0756115|           2|
| New Jersey     | Rhode Island   |  1.4668378|           3|
| Delaware       | Rhode Island   |  1.6230495|           4|
| Pennsylvania   | Rhode Island   |  1.6369255|           5|
| Utah           | Rhode Island   |  1.7565845|           6|
| Ohio           | Rhode Island   |  1.9659747|           7|
| Oklahoma       | Rhode Island   |  1.9746699|           8|
| Kansas         | Rhode Island   |  2.0087021|           9|
| Minnesota      | Rhode Island   |  2.0310592|          10|
| Mississippi    | South Carolina |  0.7865674|           1|
| Alabama        | South Carolina |  0.9157968|           2|
| North Carolina | South Carolina |  1.0476313|           3|
| Louisiana      | South Carolina |  1.3151908|           4|
| Georgia        | South Carolina |  1.3970074|           5|
| Tennessee      | South Carolina |  1.4375120|           6|
| Maryland       | South Carolina |  1.6165582|           7|
| Arkansas       | South Carolina |  1.7074195|           8|
| New Mexico     | South Carolina |  1.9596343|           9|
| Virginia       | South Carolina |  2.2636538|          10|
| West Virginia  | South Dakota   |  0.7108812|           1|
| Maine          | South Dakota   |  0.7812991|           2|
| Idaho          | South Dakota   |  0.8070290|           3|
| Montana        | South Dakota   |  0.8857149|           4|
| New Hampshire  | South Dakota   |  0.9874611|           5|
| Iowa           | South Dakota   |  0.9886706|           6|
| North Dakota   | South Dakota   |  1.0324944|           7|
| Vermont        | South Dakota   |  1.0856574|           8|
| Nebraska       | South Dakota   |  1.2591419|           9|
| Minnesota      | South Dakota   |  1.4990317|          10|
| Alabama        | Tennessee      |  0.8407489|           1|
| Georgia        | Tennessee      |  1.0122252|           2|
| Louisiana      | Tennessee      |  1.1298534|           3|
| Missouri       | Tennessee      |  1.2413874|           4|
| Virginia       | Tennessee      |  1.3514491|           5|
| Arkansas       | Tennessee      |  1.4254486|           6|
| South Carolina | Tennessee      |  1.4375120|           7|
| Texas          | Tennessee      |  1.4712840|           8|
| Maryland       | Tennessee      |  1.5202431|           9|
| New Mexico     | Tennessee      |  1.5528304|          10|
| Illinois       | Texas          |  0.8241352|           1|
| New York       | Texas          |  0.8457697|           2|
| Missouri       | Texas          |  1.1654171|           3|
| Michigan       | Texas          |  1.2888621|           4|
| Louisiana      | Texas          |  1.3325285|           5|
| New Mexico     | Texas          |  1.4418241|           6|
| Tennessee      | Texas          |  1.4712840|           7|
| Maryland       | Texas          |  1.5431868|           8|
| New Jersey     | Texas          |  1.6226525|           9|
| Arizona        | Texas          |  1.6448574|          10|
| Washington     | Utah           |  0.6940667|           1|
| Massachusetts  | Utah           |  0.9015809|           2|
| Ohio           | Utah           |  1.0154223|           3|
| Hawaii         | Utah           |  1.0709720|           4|
| Oklahoma       | Utah           |  1.2372916|           5|
| Pennsylvania   | Utah           |  1.2529078|           6|
| Kansas         | Utah           |  1.2751603|           7|
| Oregon         | Utah           |  1.2825152|           8|
| Connecticut    | Utah           |  1.2825907|           9|
| New Jersey     | Utah           |  1.3141843|          10|
| North Dakota   | Vermont        |  0.9824857|           1|
| West Virginia  | Vermont        |  1.0380554|           2|
| South Dakota   | Vermont        |  1.0856574|           3|
| Maine          | Vermont        |  1.4253680|           4|
| New Hampshire  | Vermont        |  1.6716127|           5|
| Iowa           | Vermont        |  1.7298425|           6|
| Idaho          | Vermont        |  1.7797462|           7|
| Montana        | Vermont        |  1.9261350|           8|
| Nebraska       | Vermont        |  2.2952287|           9|
| Wisconsin      | Vermont        |  2.3518637|          10|
| Oklahoma       | Virginia       |  0.5646254|           1|
| Indiana        | Virginia       |  0.6127246|           2|
| Wyoming        | Virginia       |  0.7038309|           3|
| Kansas         | Virginia       |  0.8351949|           4|
| Ohio           | Virginia       |  0.9774388|           5|
| Missouri       | Virginia       |  0.9787310|           6|
| Arkansas       | Virginia       |  0.9971035|           7|
| Kentucky       | Virginia       |  1.0918624|           8|
| Montana        | Virginia       |  1.1556682|           9|
| Pennsylvania   | Virginia       |  1.1769236|          10|
| Oregon         | Washington     |  0.5935343|           1|
| Utah           | Washington     |  0.6940667|           2|
| Oklahoma       | Washington     |  0.9586525|           3|
| Ohio           | Washington     |  0.9725013|           4|
| Indiana        | Washington     |  1.1405746|           5|
| Kansas         | Washington     |  1.1579118|           6|
| Missouri       | Washington     |  1.2502752|           7|
| Massachusetts  | Washington     |  1.3472994|           8|
| Virginia       | Washington     |  1.3809295|           9|
| Nebraska       | Washington     |  1.3859985|          10|
| South Dakota   | West Virginia  |  0.7108812|           1|
| Vermont        | West Virginia  |  1.0380554|           2|
| Maine          | West Virginia  |  1.1818120|           3|
| North Dakota   | West Virginia  |  1.2716808|           4|
| Montana        | West Virginia  |  1.2758193|           5|
| Idaho          | West Virginia  |  1.4398440|           6|
| New Hampshire  | West Virginia  |  1.4648924|           7|
| Kentucky       | West Virginia  |  1.5236299|           8|
| Iowa           | West Virginia  |  1.5256890|           9|
| Nebraska       | West Virginia  |  1.8117833|          10|
| Minnesota      | Wisconsin      |  0.4940832|           1|
| Iowa           | Wisconsin      |  0.6318069|           2|
| New Hampshire  | Wisconsin      |  0.7155628|           3|
| Nebraska       | Wisconsin      |  0.9719877|           4|
| Connecticut    | Wisconsin      |  1.0354597|           5|
| Maine          | Wisconsin      |  1.1485830|           6|
| Idaho          | Wisconsin      |  1.2105401|           7|
| Pennsylvania   | Wisconsin      |  1.2204658|           8|
| Kansas         | Wisconsin      |  1.3242947|           9|
| Montana        | Wisconsin      |  1.4916365|          10|
| Virginia       | Wyoming        |  0.7038309|           1|
| Oklahoma       | Wyoming        |  0.7366465|           2|
| Kansas         | Wyoming        |  0.7588728|           3|
| Montana        | Wyoming        |  0.8150071|           4|
| Indiana        | Wyoming        |  0.8898783|           5|
| Nebraska       | Wyoming        |  0.9268202|           6|
| Arkansas       | Wyoming        |  0.9912639|           7|
| Pennsylvania   | Wyoming        |  1.0684605|           8|
| Kentucky       | Wyoming        |  1.0694408|           9|
| Idaho          | Wyoming        |  1.1687896|          10|

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
knitr::kable(TOPN_CONTROL_LIST)
```

| CONTROL    | TEST     |    DIST\_Q|  DIST\_RANK|
|:-----------|:---------|----------:|-----------:|
| Arizona    | Colorado |  0.1106264|           1|
| Nevada     | Colorado |  0.1325795|           2|
| New Mexico | Colorado |  0.1588753|           3|
| Utah       | Colorado |  0.2025942|           4|
| Wyoming    | Colorado |  0.2231019|           5|
| Montana    | Colorado |  0.2879513|           6|
| Missouri   | Colorado |  0.3124434|           7|
| California | Colorado |  0.3164550|           8|
| Michigan   | Colorado |  0.3176979|           9|
| Idaho      | Colorado |  0.3293606|          10|

**Top N Mixed without a Test List** Don't be concerned about the warning; I just wanted to let users know that it would use all the labels in the dataframe.

``` r
TOPN_CONTROL_LIST <- TestContR::topn_mixed(df, topN = 10)
#> Warning in TestContR::topn_mixed(df, topN = 10): If no dataframe provided for the "test_list" parameter, will use all the labels in the dataset.  Otherwise, please provide a dataframe for the "test_list" parameter with 1, or N, Test group(s) or individual(s) label(s) in a column named "TEST."
#> 
#>       See documentation for topn_numeric's test_list parameter
```

**Results of Top N selection without Test List:**

``` r
knitr::kable(TOPN_CONTROL_LIST)
```

| CONTROL        | TEST           |    DIST\_Q|  DIST\_RANK|
|:---------------|:---------------|----------:|-----------:|
| Tennessee      | Alabama        |  0.0657239|           1|
| Mississippi    | Alabama        |  0.1193394|           2|
| Kentucky       | Alabama        |  0.1748170|           3|
| Louisiana      | Alabama        |  0.2676967|           4|
| South Carolina | Alabama        |  0.2845265|           5|
| Georgia        | Alabama        |  0.2982780|           6|
| Arkansas       | Alabama        |  0.3204231|           7|
| Texas          | Alabama        |  0.3267952|           8|
| Virginia       | Alabama        |  0.3309542|           9|
| Maryland       | Alabama        |  0.3313442|          10|
| California     | Alaska         |  0.1868701|           1|
| Oregon         | Alaska         |  0.2756384|           2|
| Washington     | Alaska         |  0.3324305|           3|
| Nevada         | Alaska         |  0.3536566|           4|
| Michigan       | Alaska         |  0.3674951|           5|
| New Mexico     | Alaska         |  0.3705949|           6|
| South Carolina | Alaska         |  0.3776660|           7|
| Maryland       | Alaska         |  0.3917168|           8|
| Colorado       | Alaska         |  0.3973812|           9|
| Arkansas       | Alaska         |  0.4004365|          10|
| New Mexico     | Arizona        |  0.0855065|           1|
| Colorado       | Arizona        |  0.1106264|           2|
| Nevada         | Arizona        |  0.1590739|           3|
| Utah           | Arizona        |  0.2200747|           4|
| Wyoming        | Arizona        |  0.2541417|           5|
| Maryland       | Arizona        |  0.3032691|           6|
| Illinois       | Arizona        |  0.3048780|           7|
| New York       | Arizona        |  0.3092038|           8|
| California     | Arizona        |  0.3100727|           9|
| Michigan       | Arizona        |  0.3164327|          10|
| Oklahoma       | Arkansas       |  0.1168193|           1|
| Texas          | Arkansas       |  0.1872249|           2|
| Louisiana      | Arkansas       |  0.1881198|           3|
| Virginia       | Arkansas       |  0.2771715|           4|
| Kentucky       | Arkansas       |  0.2896400|           5|
| Wyoming        | Arkansas       |  0.2980127|           6|
| Montana        | Arkansas       |  0.3154046|           7|
| Alabama        | Arkansas       |  0.3204231|           8|
| Tennessee      | Arkansas       |  0.3231333|           9|
| Missouri       | Arkansas       |  0.3233867|          10|
| Alaska         | California     |  0.1868701|           1|
| Oregon         | California     |  0.2692884|           2|
| Washington     | California     |  0.2854025|           3|
| Arizona        | California     |  0.3100727|           4|
| Colorado       | California     |  0.3164550|           5|
| Nevada         | California     |  0.3167979|           6|
| New York       | California     |  0.3322543|           7|
| Hawaii         | California     |  0.3346576|           8|
| Michigan       | California     |  0.3377839|           9|
| Illinois       | California     |  0.3482674|          10|
| Arizona        | Colorado       |  0.1106264|           1|
| Nevada         | Colorado       |  0.1325795|           2|
| New Mexico     | Colorado       |  0.1588753|           3|
| Utah           | Colorado       |  0.2025942|           4|
| Wyoming        | Colorado       |  0.2231019|           5|
| Montana        | Colorado       |  0.2879513|           6|
| Missouri       | Colorado       |  0.3124434|           7|
| California     | Colorado       |  0.3164550|           8|
| Michigan       | Colorado       |  0.3176979|           9|
| Idaho          | Colorado       |  0.3293606|          10|
| Rhode Island   | Connecticut    |  0.0934090|           1|
| Massachusetts  | Connecticut    |  0.0939574|           2|
| New Hampshire  | Connecticut    |  0.1302144|           3|
| Maine          | Connecticut    |  0.1381408|           4|
| Vermont        | Connecticut    |  0.2087779|           5|
| Pennsylvania   | Connecticut    |  0.2754717|           6|
| Utah           | Connecticut    |  0.2792055|           7|
| Wisconsin      | Connecticut    |  0.2863134|           8|
| Minnesota      | Connecticut    |  0.2901827|           9|
| Nebraska       | Connecticut    |  0.2962821|          10|
| Virginia       | Delaware       |  0.1433212|           1|
| Maryland       | Delaware       |  0.1864907|           2|
| North Carolina | Delaware       |  0.2464262|           3|
| South Carolina | Delaware       |  0.2464731|           4|
| Georgia        | Delaware       |  0.2494049|           5|
| West Virginia  | Delaware       |  0.2554000|           6|
| Florida        | Delaware       |  0.2912190|           7|
| Pennsylvania   | Delaware       |  0.2998814|           8|
| Oklahoma       | Delaware       |  0.3032875|           9|
| Wyoming        | Delaware       |  0.3052947|          10|
| Maryland       | Florida        |  0.1386266|           1|
| South Carolina | Florida        |  0.2074577|           2|
| Georgia        | Florida        |  0.2083491|           3|
| North Carolina | Florida        |  0.2305833|           4|
| Delaware       | Florida        |  0.2912190|           5|
| New Mexico     | Florida        |  0.3173712|           6|
| Arizona        | Florida        |  0.3206852|           7|
| Virginia       | Florida        |  0.3212435|           8|
| Michigan       | Florida        |  0.3314300|           9|
| Louisiana      | Florida        |  0.3564909|          10|
| South Carolina | Georgia        |  0.1404522|           1|
| Maryland       | Georgia        |  0.1685176|           2|
| Virginia       | Georgia        |  0.1814262|           3|
| Florida        | Georgia        |  0.2083491|           4|
| North Carolina | Georgia        |  0.2402901|           5|
| Delaware       | Georgia        |  0.2494049|           6|
| Tennessee      | Georgia        |  0.2754304|           7|
| Louisiana      | Georgia        |  0.2890674|           8|
| Alabama        | Georgia        |  0.2982780|           9|
| Texas          | Georgia        |  0.3328228|          10|
| Washington     | Hawaii         |  0.1483769|           1|
| Oregon         | Hawaii         |  0.1834822|           2|
| Utah           | Hawaii         |  0.3001091|           3|
| Ohio           | Hawaii         |  0.3081015|           4|
| Massachusetts  | Hawaii         |  0.3083260|           5|
| Pennsylvania   | Hawaii         |  0.3178224|           6|
| Kansas         | Hawaii         |  0.3246906|           7|
| New Jersey     | Hawaii         |  0.3302726|           8|
| Indiana        | Hawaii         |  0.3339333|           9|
| Minnesota      | Hawaii         |  0.3341508|          10|
| Montana        | Idaho          |  0.0632574|           1|
| Wyoming        | Idaho          |  0.1062587|           2|
| Utah           | Idaho          |  0.1403257|           3|
| Nebraska       | Idaho          |  0.2718156|           4|
| Iowa           | Idaho          |  0.2738115|           5|
| Maine          | Idaho          |  0.2746110|           6|
| South Dakota   | Idaho          |  0.2754891|           7|
| Minnesota      | Idaho          |  0.2783771|           8|
| New Hampshire  | Idaho          |  0.2802438|           9|
| Wisconsin      | Idaho          |  0.3041394|          10|
| Michigan       | Illinois       |  0.1124643|           1|
| Ohio           | Illinois       |  0.1662609|           2|
| Indiana        | Illinois       |  0.2082257|           3|
| New York       | Illinois       |  0.2328806|           4|
| Texas          | Illinois       |  0.2785090|           5|
| Arizona        | Illinois       |  0.3048780|           6|
| Maryland       | Illinois       |  0.3196504|           7|
| New Mexico     | Illinois       |  0.3226340|           8|
| Louisiana      | Illinois       |  0.3271704|           9|
| Missouri       | Illinois       |  0.3312708|          10|
| Ohio           | Indiana        |  0.0419648|           1|
| Wisconsin      | Indiana        |  0.1526206|           2|
| Illinois       | Indiana        |  0.2082257|           3|
| Kansas         | Indiana        |  0.2347214|           4|
| Oklahoma       | Indiana        |  0.2485938|           5|
| Virginia       | Indiana        |  0.2534448|           6|
| Michigan       | Indiana        |  0.2596731|           7|
| Pennsylvania   | Indiana        |  0.2708913|           8|
| Nebraska       | Indiana        |  0.2758993|           9|
| Montana        | Indiana        |  0.2816481|          10|
| Minnesota      | Iowa           |  0.0660961|           1|
| South Dakota   | Iowa           |  0.0882550|           2|
| North Dakota   | Iowa           |  0.0891413|           3|
| Nebraska       | Iowa           |  0.1006306|           4|
| Kansas         | Iowa           |  0.1513279|           5|
| New Hampshire  | Iowa           |  0.2145819|           6|
| Wisconsin      | Iowa           |  0.2399665|           7|
| Maine          | Iowa           |  0.2581248|           8|
| Idaho          | Iowa           |  0.2738115|           9|
| Vermont        | Iowa           |  0.2907420|          10|
| Nebraska       | Kansas         |  0.0506973|           1|
| Minnesota      | Kansas         |  0.0852318|           2|
| South Dakota   | Kansas         |  0.1444289|           3|
| Missouri       | Kansas         |  0.1455678|           4|
| Iowa           | Kansas         |  0.1513279|           5|
| Indiana        | Kansas         |  0.2347214|           6|
| North Dakota   | Kansas         |  0.2404692|           7|
| Pennsylvania   | Kansas         |  0.2461385|           8|
| Oklahoma       | Kansas         |  0.2490020|           9|
| Montana        | Kansas         |  0.2564461|          10|
| Tennessee      | Kentucky       |  0.1747874|           1|
| Alabama        | Kentucky       |  0.1748170|           2|
| Mississippi    | Kentucky       |  0.2111012|           3|
| Montana        | Kentucky       |  0.2484849|           4|
| Arkansas       | Kentucky       |  0.2896400|           5|
| Indiana        | Kentucky       |  0.3012174|           6|
| Wyoming        | Kentucky       |  0.3012924|           7|
| Nebraska       | Kentucky       |  0.3047867|           8|
| Kansas         | Kentucky       |  0.3049311|           9|
| Virginia       | Kentucky       |  0.3066768|          10|
| Texas          | Louisiana      |  0.1299187|           1|
| Arkansas       | Louisiana      |  0.1881198|           2|
| Oklahoma       | Louisiana      |  0.1912966|           3|
| Alabama        | Louisiana      |  0.2676967|           4|
| Georgia        | Louisiana      |  0.2890674|           5|
| South Carolina | Louisiana      |  0.2951635|           6|
| Mississippi    | Louisiana      |  0.3162159|           7|
| Tennessee      | Louisiana      |  0.3163051|           8|
| Maryland       | Louisiana      |  0.3166595|           9|
| Illinois       | Louisiana      |  0.3271704|          10|
| New Hampshire  | Maine          |  0.0435429|           1|
| Vermont        | Maine          |  0.1071553|           2|
| Connecticut    | Maine          |  0.1381408|           3|
| Rhode Island   | Maine          |  0.2026093|           4|
| Massachusetts  | Maine          |  0.2320982|           5|
| Iowa           | Maine          |  0.2581248|           6|
| North Dakota   | Maine          |  0.2680028|           7|
| South Dakota   | Maine          |  0.2687155|           8|
| Idaho          | Maine          |  0.2746110|           9|
| Wisconsin      | Maine          |  0.2929234|          10|
| Florida        | Maryland       |  0.1386266|           1|
| South Carolina | Maryland       |  0.1435299|           2|
| Georgia        | Maryland       |  0.1685176|           3|
| North Carolina | Maryland       |  0.1808658|           4|
| Virginia       | Maryland       |  0.1826169|           5|
| Delaware       | Maryland       |  0.1864907|           6|
| New Mexico     | Maryland       |  0.2438705|           7|
| Michigan       | Maryland       |  0.3019154|           8|
| Arizona        | Maryland       |  0.3032691|           9|
| New York       | Maryland       |  0.3071088|          10|
| Rhode Island   | Massachusetts  |  0.0772948|           1|
| Connecticut    | Massachusetts  |  0.0939574|           2|
| New Hampshire  | Massachusetts  |  0.2241717|           3|
| Maine          | Massachusetts  |  0.2320982|           4|
| New Jersey     | Massachusetts  |  0.2694731|           5|
| Utah           | Massachusetts  |  0.2853785|           6|
| Washington     | Massachusetts  |  0.2993998|           7|
| Vermont        | Massachusetts  |  0.3017017|           8|
| Pennsylvania   | Massachusetts  |  0.3036466|           9|
| Oklahoma       | Massachusetts  |  0.3046245|          10|
| Illinois       | Michigan       |  0.1124643|           1|
| Ohio           | Michigan       |  0.2244879|           2|
| New Mexico     | Michigan       |  0.2580449|           3|
| Indiana        | Michigan       |  0.2596731|           4|
| Nevada         | Michigan       |  0.2833192|           5|
| New York       | Michigan       |  0.2999227|           6|
| Maryland       | Michigan       |  0.3019154|           7|
| Texas          | Michigan       |  0.3141666|           8|
| Arizona        | Michigan       |  0.3164327|           9|
| Colorado       | Michigan       |  0.3176979|          10|
| Nebraska       | Minnesota      |  0.0616531|           1|
| Iowa           | Minnesota      |  0.0660961|           2|
| Kansas         | Minnesota      |  0.0852318|           3|
| South Dakota   | Minnesota      |  0.1048812|           4|
| North Dakota   | Minnesota      |  0.1552375|           5|
| Missouri       | Minnesota      |  0.2307995|           6|
| Wisconsin      | Minnesota      |  0.2354071|           7|
| Idaho          | Minnesota      |  0.2783771|           8|
| New Hampshire  | Minnesota      |  0.2793082|           9|
| Pennsylvania   | Minnesota      |  0.2870001|          10|
| Alabama        | Mississippi    |  0.1193394|           1|
| Tennessee      | Mississippi    |  0.1850633|           2|
| Kentucky       | Mississippi    |  0.2111012|           3|
| South Carolina | Mississippi    |  0.2756469|           4|
| North Carolina | Mississippi    |  0.2993318|           5|
| Louisiana      | Mississippi    |  0.3162159|           6|
| Georgia        | Mississippi    |  0.3477379|           7|
| Arkansas       | Mississippi    |  0.3679542|           8|
| Maryland       | Mississippi    |  0.4191768|           9|
| Alaska         | Mississippi    |  0.4313951|          10|
| Kansas         | Missouri       |  0.1455678|           1|
| Nebraska       | Missouri       |  0.1962651|           2|
| Minnesota      | Missouri       |  0.2307995|           3|
| Oregon         | Missouri       |  0.2782655|           4|
| Virginia       | Missouri       |  0.2835811|           5|
| South Dakota   | Missouri       |  0.2899966|           6|
| Oklahoma       | Missouri       |  0.2965657|           7|
| Iowa           | Missouri       |  0.2968957|           8|
| Tennessee      | Missouri       |  0.3014582|           9|
| Washington     | Missouri       |  0.3033491|          10|
| Idaho          | Montana        |  0.0632574|           1|
| Wyoming        | Montana        |  0.0731182|           2|
| Utah           | Montana        |  0.1663863|           3|
| Kentucky       | Montana        |  0.2484849|           4|
| Nebraska       | Montana        |  0.2563017|           5|
| Kansas         | Montana        |  0.2564461|           6|
| Pennsylvania   | Montana        |  0.2778280|           7|
| Indiana        | Montana        |  0.2816481|           8|
| Colorado       | Montana        |  0.2879513|           9|
| South Dakota   | Montana        |  0.2879827|          10|
| Kansas         | Nebraska       |  0.0506973|           1|
| Minnesota      | Nebraska       |  0.0616531|           2|
| South Dakota   | Nebraska       |  0.0937316|           3|
| Iowa           | Nebraska       |  0.1006306|           4|
| North Dakota   | Nebraska       |  0.1897719|           5|
| Missouri       | Nebraska       |  0.1962651|           6|
| Montana        | Nebraska       |  0.2563017|           7|
| Pennsylvania   | Nebraska       |  0.2690032|           8|
| Idaho          | Nebraska       |  0.2718156|           9|
| Indiana        | Nebraska       |  0.2758993|          10|
| Colorado       | Nevada         |  0.1325795|           1|
| New Mexico     | Nevada         |  0.1413641|           2|
| Arizona        | Nevada         |  0.1590739|           3|
| Michigan       | Nevada         |  0.2833192|           4|
| California     | Nevada         |  0.3167979|           5|
| Utah           | Nevada         |  0.3216144|           6|
| New York       | Nevada         |  0.3344144|           7|
| Illinois       | Nevada         |  0.3442163|           8|
| Texas          | Nevada         |  0.3502886|           9|
| Alaska         | Nevada         |  0.3536566|          10|
| Maine          | New Hampshire  |  0.0435429|           1|
| Vermont        | New Hampshire  |  0.0975107|           2|
| Connecticut    | New Hampshire  |  0.1302144|           3|
| Rhode Island   | New Hampshire  |  0.2070859|           4|
| Iowa           | New Hampshire  |  0.2145819|           5|
| Massachusetts  | New Hampshire  |  0.2241717|           6|
| Wisconsin      | New Hampshire  |  0.2493805|           7|
| North Dakota   | New Hampshire  |  0.2759293|           8|
| Minnesota      | New Hampshire  |  0.2793082|           9|
| Idaho          | New Hampshire  |  0.2802438|          10|
| Pennsylvania   | New Jersey     |  0.1273365|           1|
| New York       | New Jersey     |  0.1575424|           2|
| Massachusetts  | New Jersey     |  0.2694731|           3|
| Ohio           | New Jersey     |  0.2888115|           4|
| Oklahoma       | New Jersey     |  0.2925060|           5|
| Virginia       | New Jersey     |  0.3132625|           6|
| Rhode Island   | New Jersey     |  0.3195100|           7|
| Wyoming        | New Jersey     |  0.3234413|           8|
| Indiana        | New Jersey     |  0.3266419|           9|
| Utah           | New Jersey     |  0.3290118|          10|
| Arizona        | New Mexico     |  0.0855065|           1|
| Nevada         | New Mexico     |  0.1413641|           2|
| Colorado       | New Mexico     |  0.1588753|           3|
| Maryland       | New Mexico     |  0.2438705|           4|
| Michigan       | New Mexico     |  0.2580449|           5|
| Wyoming        | New Mexico     |  0.2595228|           6|
| Utah           | New Mexico     |  0.2932524|           7|
| New York       | New Mexico     |  0.3100924|           8|
| Florida        | New Mexico     |  0.3173712|           9|
| Missouri       | New Mexico     |  0.3223584|          10|
| New Jersey     | New York       |  0.1575424|           1|
| Illinois       | New York       |  0.2328806|           2|
| Pennsylvania   | New York       |  0.2645400|           3|
| Texas          | New York       |  0.2790182|           4|
| Michigan       | New York       |  0.2999227|           5|
| Maryland       | New York       |  0.3071088|           6|
| Arizona        | New York       |  0.3092038|           7|
| New Mexico     | New York       |  0.3100924|           8|
| California     | New York       |  0.3322543|           9|
| Nevada         | New York       |  0.3344144|          10|
| South Carolina | North Carolina |  0.0998379|           1|
| Maryland       | North Carolina |  0.1808658|           2|
| Florida        | North Carolina |  0.2305833|           3|
| Georgia        | North Carolina |  0.2402901|           4|
| Delaware       | North Carolina |  0.2464262|           5|
| Virginia       | North Carolina |  0.2629790|           6|
| Mississippi    | North Carolina |  0.2993318|           7|
| West Virginia  | North Carolina |  0.3187754|           8|
| Alabama        | North Carolina |  0.3420121|           9|
| Arkansas       | North Carolina |  0.3858076|          10|
| Iowa           | North Dakota   |  0.0891413|           1|
| South Dakota   | North Dakota   |  0.0960404|           2|
| Minnesota      | North Dakota   |  0.1552375|           3|
| Nebraska       | North Dakota   |  0.1897719|           4|
| Kansas         | North Dakota   |  0.2404692|           5|
| Maine          | North Dakota   |  0.2680028|           6|
| New Hampshire  | North Dakota   |  0.2759293|           7|
| Vermont        | North Dakota   |  0.2797553|           8|
| West Virginia  | North Dakota   |  0.3109787|           9|
| Wisconsin      | North Dakota   |  0.3198303|          10|
| Indiana        | Ohio           |  0.0419648|           1|
| Illinois       | Ohio           |  0.1662609|           2|
| Wisconsin      | Ohio           |  0.1878058|           3|
| Michigan       | Ohio           |  0.2244879|           4|
| Oklahoma       | Ohio           |  0.2606306|           5|
| Pennsylvania   | Ohio           |  0.2653985|           6|
| Kansas         | Ohio           |  0.2671668|           7|
| Utah           | Ohio           |  0.2740987|           8|
| Virginia       | Ohio           |  0.2834109|           9|
| Washington     | Ohio           |  0.2884682|          10|
| Arkansas       | Oklahoma       |  0.1168193|           1|
| Texas          | Oklahoma       |  0.1768423|           2|
| Louisiana      | Oklahoma       |  0.1912966|           3|
| Virginia       | Oklahoma       |  0.2468829|           4|
| Indiana        | Oklahoma       |  0.2485938|           5|
| Kansas         | Oklahoma       |  0.2490020|           6|
| Wyoming        | Oklahoma       |  0.2591166|           7|
| Ohio           | Oklahoma       |  0.2606306|           8|
| Pennsylvania   | Oklahoma       |  0.2743523|           9|
| Oregon         | Oklahoma       |  0.2774132|          10|
| Washington     | Oregon         |  0.0567921|           1|
| Hawaii         | Oregon         |  0.1834822|           2|
| California     | Oregon         |  0.2692884|           3|
| Alaska         | Oregon         |  0.2756384|           4|
| Oklahoma       | Oregon         |  0.2774132|           5|
| Missouri       | Oregon         |  0.2782655|           6|
| Virginia       | Oregon         |  0.3034321|           7|
| Kansas         | Oregon         |  0.3051778|           8|
| Indiana        | Oregon         |  0.3088914|           9|
| Wyoming        | Oregon         |  0.3187913|          10|
| New Jersey     | Pennsylvania   |  0.1273365|           1|
| Kansas         | Pennsylvania   |  0.2461385|           2|
| New York       | Pennsylvania   |  0.2645400|           3|
| Ohio           | Pennsylvania   |  0.2653985|           4|
| Nebraska       | Pennsylvania   |  0.2690032|           5|
| Indiana        | Pennsylvania   |  0.2708913|           6|
| Oklahoma       | Pennsylvania   |  0.2743523|           7|
| Connecticut    | Pennsylvania   |  0.2754717|           8|
| Montana        | Pennsylvania   |  0.2778280|           9|
| Minnesota      | Pennsylvania   |  0.2870001|          10|
| Massachusetts  | Rhode Island   |  0.0772948|           1|
| Connecticut    | Rhode Island   |  0.0934090|           2|
| Maine          | Rhode Island   |  0.2026093|           3|
| New Hampshire  | Rhode Island   |  0.2070859|           4|
| Vermont        | Rhode Island   |  0.3021870|           5|
| New Jersey     | Rhode Island   |  0.3195100|           6|
| Utah           | Rhode Island   |  0.3385769|           7|
| Delaware       | Rhode Island   |  0.3635632|           8|
| Pennsylvania   | Rhode Island   |  0.3664711|           9|
| Washington     | Rhode Island   |  0.3670560|          10|
| North Carolina | South Carolina |  0.0998379|           1|
| Georgia        | South Carolina |  0.1404522|           2|
| Maryland       | South Carolina |  0.1435299|           3|
| Florida        | South Carolina |  0.2074577|           4|
| Virginia       | South Carolina |  0.2154807|           5|
| Delaware       | South Carolina |  0.2464731|           6|
| Mississippi    | South Carolina |  0.2756469|           7|
| Alabama        | South Carolina |  0.2845265|           8|
| Louisiana      | South Carolina |  0.2951635|           9|
| Tennessee      | South Carolina |  0.3368138|          10|
| Iowa           | South Dakota   |  0.0882550|           1|
| Nebraska       | South Dakota   |  0.0937316|           2|
| North Dakota   | South Dakota   |  0.0960404|           3|
| Minnesota      | South Dakota   |  0.1048812|           4|
| Kansas         | South Dakota   |  0.1444289|           5|
| West Virginia  | South Dakota   |  0.2647431|           6|
| Maine          | South Dakota   |  0.2687155|           7|
| Idaho          | South Dakota   |  0.2754891|           8|
| Montana        | South Dakota   |  0.2879827|           9|
| Missouri       | South Dakota   |  0.2899966|          10|
| Alabama        | Tennessee      |  0.0657239|           1|
| Kentucky       | Tennessee      |  0.1747874|           2|
| Mississippi    | Tennessee      |  0.1850633|           3|
| Georgia        | Tennessee      |  0.2754304|           4|
| Texas          | Tennessee      |  0.2933498|           5|
| Missouri       | Tennessee      |  0.3014582|           6|
| Louisiana      | Tennessee      |  0.3163051|           7|
| Arkansas       | Tennessee      |  0.3231333|           8|
| Virginia       | Tennessee      |  0.3241450|           9|
| Maryland       | Tennessee      |  0.3313737|          10|
| Louisiana      | Texas          |  0.1299187|           1|
| Oklahoma       | Texas          |  0.1768423|           2|
| Arkansas       | Texas          |  0.1872249|           3|
| Illinois       | Texas          |  0.2785090|           4|
| New York       | Texas          |  0.2790182|           5|
| Tennessee      | Texas          |  0.2933498|           6|
| Missouri       | Texas          |  0.3081835|           7|
| Michigan       | Texas          |  0.3141666|           8|
| Alabama        | Texas          |  0.3267952|           9|
| Georgia        | Texas          |  0.3328228|          10|
| Idaho          | Utah           |  0.1403257|           1|
| Montana        | Utah           |  0.1663863|           2|
| Wyoming        | Utah           |  0.1769784|           3|
| Colorado       | Utah           |  0.2025942|           4|
| Arizona        | Utah           |  0.2200747|           5|
| Washington     | Utah           |  0.2675449|           6|
| Ohio           | Utah           |  0.2740987|           7|
| Connecticut    | Utah           |  0.2792055|           8|
| Massachusetts  | Utah           |  0.2853785|           9|
| New Mexico     | Utah           |  0.2932524|          10|
| New Hampshire  | Vermont        |  0.0975107|           1|
| Maine          | Vermont        |  0.1071553|           2|
| Connecticut    | Vermont        |  0.2087779|           3|
| North Dakota   | Vermont        |  0.2797553|           4|
| Iowa           | Vermont        |  0.2907420|           5|
| South Dakota   | Vermont        |  0.2976410|           6|
| West Virginia  | Vermont        |  0.2983193|           7|
| Massachusetts  | Vermont        |  0.3017017|           8|
| Rhode Island   | Vermont        |  0.3021870|           9|
| Wisconsin      | Vermont        |  0.3255654|          10|
| Delaware       | Virginia       |  0.1433212|           1|
| Georgia        | Virginia       |  0.1814262|           2|
| Maryland       | Virginia       |  0.1826169|           3|
| South Carolina | Virginia       |  0.2154807|           4|
| West Virginia  | Virginia       |  0.2253755|           5|
| Oklahoma       | Virginia       |  0.2468829|           6|
| Indiana        | Virginia       |  0.2534448|           7|
| Wyoming        | Virginia       |  0.2604327|           8|
| North Carolina | Virginia       |  0.2629790|           9|
| Arkansas       | Virginia       |  0.2771715|          10|
| Oregon         | Washington     |  0.0567921|           1|
| Hawaii         | Washington     |  0.1483769|           2|
| Utah           | Washington     |  0.2675449|           3|
| Oklahoma       | Washington     |  0.2844254|           4|
| California     | Washington     |  0.2854025|           5|
| Ohio           | Washington     |  0.2884682|           6|
| Massachusetts  | Washington     |  0.2993998|           7|
| Missouri       | Washington     |  0.3033491|           8|
| Kansas         | Washington     |  0.3107504|           9|
| Indiana        | Washington     |  0.3144641|          10|
| Virginia       | West Virginia  |  0.2253755|           1|
| Delaware       | West Virginia  |  0.2554000|           2|
| South Dakota   | West Virginia  |  0.2647431|           3|
| Maine          | West Virginia  |  0.2931733|           4|
| Vermont        | West Virginia  |  0.2983193|           5|
| Montana        | West Virginia  |  0.3069427|           6|
| North Dakota   | West Virginia  |  0.3109787|           7|
| New Hampshire  | West Virginia  |  0.3184726|           8|
| North Carolina | West Virginia  |  0.3187754|           9|
| Iowa           | West Virginia  |  0.3306448|          10|
| Indiana        | Wisconsin      |  0.1526206|           1|
| Ohio           | Wisconsin      |  0.1878058|           2|
| Minnesota      | Wisconsin      |  0.2354071|           3|
| Iowa           | Wisconsin      |  0.2399665|           4|
| New Hampshire  | Wisconsin      |  0.2493805|           5|
| Connecticut    | Wisconsin      |  0.2863134|           6|
| Maine          | Wisconsin      |  0.2929234|           7|
| Nebraska       | Wisconsin      |  0.2970603|           8|
| Idaho          | Wisconsin      |  0.3041394|           9|
| South Dakota   | Wisconsin      |  0.3185829|          10|
| Montana        | Wyoming        |  0.0731182|           1|
| Idaho          | Wyoming        |  0.1062587|           2|
| Utah           | Wyoming        |  0.1769784|           3|
| Colorado       | Wyoming        |  0.2231019|           4|
| Arizona        | Wyoming        |  0.2541417|           5|
| Oklahoma       | Wyoming        |  0.2591166|           6|
| New Mexico     | Wyoming        |  0.2595228|           7|
| Virginia       | Wyoming        |  0.2604327|           8|
| Kansas         | Wyoming        |  0.2738875|           9|
| Nebraska       | Wyoming        |  0.2819623|          10|

------------------------------------------------------------------------

------------------------------------------------------------------------

### Conclusion

Depending on your experiment, it may be prudent to add categorical metrics/variables that will help align your data better. In the above examples, when only using the numerical data Alabama's nearest match is Louisiana, but once region is taken into consideration, Alabama's nearest match is Tennessee. Now you have the tools to create a list of nearest matches for your data whether it is numeric or mixed.

------------------------------------------------------------------------

------------------------------------------------------------------------
