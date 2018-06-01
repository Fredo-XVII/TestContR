# TestContR 1.0.2 - in Development
  - Error: $ cannot be used with vector.  Fixed by removing $TEST, using ['TEST']
  - improve topn_numeric() for more than 1 group (in development).

# TestContR 1.0.1
  - Main development complete, released on GitHub. 
  - match_numeric() - creates randomized test and control groups based on "n" number of test desired 
  - topn_numeric() - provides the top "n" for 1 group/individual.  Can use purrr to loop over several groups individually, but
    this takes a long time as it has to build the distance matrix in each iteration.
