# TestContR 1.1.4
 - Tested the package for R 4.0.x
 - Installed Rtools 4.0
 - Add appveyor.yml
 - Submit to CRAN

# TestContR 1.1.003
  - Bug fix - Fixing the error below. This will allow the package to pass the CMD checks for upload to CRAN.
  - ERROR: Writing R Packages: no visible binding for global variable.
  - Solution found @: https://github.com/STAT545-UBC/Discussion/issues/451
  
# TestContR 1.1.002
  - Bug fix - fixed it so that the test_list parameter in the functions will accept any name for the column of the test list.

# TestContR 1.1.001
  - Bug Fix - fixed the bug with the daisy dissimilarity distance matrix.  Would not pull the correct labels from the data, instead using row number, creating matches for data that didn't exists when the labels where numeric.  Added attr(df,"Label") <- as.factor(df[,1]) to ensure that the correct labels would be used in the reporting of the matching.
  - Updated documentation
  - Changes to Code: Changed the parameter "n" to "topN" in the topN_* functions. (RENAMED)
  - Will also update the READ.md file to include new variables.
  
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
