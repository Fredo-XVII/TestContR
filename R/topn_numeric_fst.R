topn_numeric_fst <- function(df, topN, test_list) {
  library(collapse)
  
  # Extract the states from the test list
  test_states <- test_list$TEST
  
  # Filter the dataframe for the states in the test list
  filtered_df <- df[df$state %in% test_states, ]
  
  # Select the top N rows based on the first numeric column
  numeric_cols <- sapply(filtered_df, is.numeric)
  first_numeric_col <- which(numeric_cols)[1]
  
  top_rows <- head(filtered_df[order(-filtered_df[[first_numeric_col]]), ], topN)
  
  return(top_rows)
}
