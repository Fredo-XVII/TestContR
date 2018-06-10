# New Release
  > If I have errors, please suggest google terms or code that will help me resolve the issue.  Thank you!
  
## Test environments 
* local Windows install, R 3.5.0
* ubuntu 12.04 (on travis-ci), R 3.5.0

## R CMD check results
There were no ERRORs or WARNINGs. 

NOTES: 1

  - Explanation: The base command used are 'dist', '%>%', and 'na.omit'.  The others are objects, dataframes and variables, that are used to build the matches.  This do not interfere with the users environment and are not created outside of the function.

Note:
"
checking R code for possible problems ... NOTE
match_numeric: no visible global function definition for 'dist'
match_numeric: no visible global function definition for '%>%'
match_numeric: no visible global function definition for 'na.omit'
match_numeric: no visible binding for global variable 'TEST'
match_numeric: no visible binding for global variable 'DIST_Q'
match_numeric: no visible binding for global variable 'CONTROL'
match_numeric: no visible binding for global variable 'DIST_RANK'
match_numeric: no visible binding for global variable 'control_cnt'
match_numeric: no visible binding for global variable 'CONTROL.x'
... 7 lines ...
topn_numeric: no visible global function definition for 'na.omit'
topn_numeric: no visible binding for global variable 'TEST'
topn_numeric: no visible binding for global variable 'DIST_Q'
topn_numeric: no visible binding for global variable 'CONTROL'
topn_numeric: no visible binding for global variable 'DIST_RANK'
Undefined global functions or variables:
  %>% CONTROL CONTROL.x CONTROL.y DIST_Q DIST_Q.x DIST_Q.y DIST_RANK
  GROUP TEST control_cnt dist na.omit
Consider adding
  importFrom("stats", "dist", "na.omit")
to your NAMESPACE file.
"
  

## Test environments - built with the below install with no errors or warnings, and 1 note.
* local Windows install, R 3.4.3
* ubuntu 12.04 (on travis-ci), R 3.4.3

## R CMD check results
There were no ERRORs or WARNINGs. 

NOTES: 1

  - Explanation: The base command used are 'dist', '%>%', and 'na.omit'.  The others are objects, dataframes and variables, that are used to build the matches.  This do not interfere with the users environment and are not created outside of the function.

Note:
"
checking R code for possible problems ... NOTE
match_numeric: no visible global function definition for 'dist'
match_numeric: no visible global function definition for '%>%'
match_numeric: no visible global function definition for 'na.omit'
match_numeric: no visible binding for global variable 'TEST'
match_numeric: no visible binding for global variable 'DIST_Q'
match_numeric: no visible binding for global variable 'CONTROL'
match_numeric: no visible binding for global variable 'DIST_RANK'
match_numeric: no visible binding for global variable 'control_cnt'
match_numeric: no visible binding for global variable 'CONTROL.x'
... 7 lines ...
topn_numeric: no visible global function definition for 'na.omit'
topn_numeric: no visible binding for global variable 'TEST'
topn_numeric: no visible binding for global variable 'DIST_Q'
topn_numeric: no visible binding for global variable 'CONTROL'
topn_numeric: no visible binding for global variable 'DIST_RANK'
Undefined global functions or variables:
  %>% CONTROL CONTROL.x CONTROL.y DIST_Q DIST_Q.x DIST_Q.y DIST_RANK
  GROUP TEST control_cnt dist na.omit
Consider adding
  importFrom("stats", "dist", "na.omit")
to your NAMESPACE file.
"

## Downstream dependencies
There are currently no downstream dependencies for this package for TestContR.
