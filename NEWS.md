# TestContR 1.1.0
  - Added the 2 functions below to account for factors, or categorical variables in the distance matrix.
  - match_mixed - added Gower distance matrix with cluster::daisy() to account for factor variables. Removed stats::dist() because daisy() already uses range for standardization of numeric variables.
  - topn_mixed - added Gower distance matrix with cluster::daisy() to account for factor variables.  Removed stats::dist() because daisy() already uses range for standardization of numeric variables.
  - Total 4 functions available, 2 for numeric variables, 2 for mixed variables

# TestContR 1.0.2 
  - Error: $ cannot be used with vector.  Fixed by removing $TEST, using ['TEST'] - COMPLETED
  - Fixed warning for CRAN submission. - COMPLETED
  - improve topn_numeric() for more than 1 group (in development). - COMPLETED

# TestContR 1.0.1
  - Main development complete, released on GitHub. 
  - match_numeric() - creates randomized test and control groups based on "n" number of test desired 
  - topn_numeric() - provides the top "n" for 1 group/individual.  Can use purrr to loop over several groups individually, but
    this takes a long time as it has to build the distance matrix in each iteration.
