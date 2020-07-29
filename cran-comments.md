# New Release
  > If I have errors, please suggest google terms or code that will help me resolve the issue.  Thank you!
  
## Test environments 
* local Windows install, R 4.0.2
* ubuntu 12.04 (on travis-ci), R 4.0.2
* server Windows (on appveyor), R 4.0.2

## R CMD check results
There were no ERRORs or WARNINGs. 

NOTE: 1

  - Explanation: R can't find installed pandoc software, but not relevant to the functions in the package.

Note:
"
* checking top-level files ... NOTE
Files 'README.md' or 'NEWS.md' cannot be checked without 'pandoc' being installed.
"

NOTE: 2

  - Explanation: CRAN checking maintainer of package

Note:
"
* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Alfredo G Marquez <Alfredo.G.Marquez@gmail.com>'
"

## Downstream dependencies
There are currently no downstream dependencies for this package for TestContR.
