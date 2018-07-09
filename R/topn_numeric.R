#' Top N Control Selector for 1 or more Test Group(s)/Individual(s).
#'
#' Selects n nearest control groups/individuals for 1 or more test group(s)/individual(s)
#'
#' @details
#' Providing a complete list of the groups/individuals to df, and suppling a data frame
#' with 1 or more TEST group(s)/individual(s) to the parameter test_list, the function will provide
#' you with an "N" list of control groups/individuals. If more than 1 group/individual
#' is provided there is a good chance of duplicates. This function ignores duplicates
#' in the control for more than 1 TEST group, resulting in a dataframe with Labels x N rows.
#' This function can handle only numeric data.
#'
#' @param df data frame of numeric inputs. First column must have group/individuals names, 1 line per group/individuals.
#' @param topN size of the top "N" of groups/individuals that match the test group/individuals. Defaults to 5.
#' @param test_list df with one column named "TEST," and one row for each label for each group/individual. Defaults to NULL, but be aware if test_list
#' is left blank, the function will use all the unique labels in the first column of the dataframe, resulting in labels x topN rows dataframe.
#' @examples
#' library(dplyr)
#' library(magrittr)
#' df <- datasets::USArrests %>% dplyr::mutate(state = base::row.names(datasets::USArrests)) %>%
#'                               dplyr::select(state, dplyr::everything())
#' test_list <- dplyr::tribble(~"TEST","Colorado")
#' TOPN_CONTROL_LIST <- TestContR::topn_numeric(df, topN = 5, test_list = test_list)
#' @importFrom magrittr %>%
#' @export



##----PART #1---------------------------------------------------------

# CREATE A RANKED LIST OF MATCHES BASED ON DISTANCE.

# Libraries loaded in BUILD_METRICS.R script
# require(reshape2)
# require(tidyverse)

topn_numeric <- function ( df, topN = 5 , test_list = NULL ) {

  # Prep for Distance: Convert column #1 to rownames and scale the dataset

  rownames(df) <- df[,1]
  df_scaled <- scale(df[,-1])

  #---- Build the Distant Matrix----
  DF_DIST <- stats::dist(df_scaled , method = "euclidian")

  # Convert to Matrix
  DF_RANK_BASE <- as.matrix(DF_DIST)

  # Keep the full matrix for addressing duplicates: Force NA to diagonal
  diag(DF_RANK_BASE) <- NA

  #----Produce list of one to one distance Metric----
  DF_RANK_BASE_1 <- reshape2::melt(DF_RANK_BASE)
  names(DF_RANK_BASE_1) <- c("CONTROL","TEST","DIST_Q")

  DF_DIST_FINAL <- DF_RANK_BASE_1 %>% stats::na.omit() %>%
    dplyr::arrange(TEST,DIST_Q,CONTROL)


  ##----PART #2----------------------------------------------------------

  # RANDOMLY SELECT THE TOP N LIST/DF OF THE CONTROL GROUPS FOR 1 TEST GROUP

  #set.seed(17)
  if( is.null(test_list)) {
    warning( 'If no dataframe provided for the "test_list" parameter, will use all the labels in the dataset.  Otherwise, please provide a dataframe for the "test_list" parameter with 1, or N, Test group(s) or individual(s) label(s) in a column named "TEST."\n
      See documentation for topn_numeric\'s test_list parameter'
    )
    DF_TEST <- data.frame("TEST" = df[,1])
  } else {
    DF_TEST <- as.data.frame(test_list['TEST'])
  }
  # Test and Control List

  for (k in 1:nrow(DF_TEST)) {
    DF_DIST_REDUCED <- DF_DIST_FINAL %>% dplyr::filter(!CONTROL %in% (DF_TEST[k,1])) %>%
      dplyr::filter(TEST %in% (DF_TEST[k,1]))

    CONTROL_STR_LIST_1 <- DF_DIST_REDUCED %>%
      dplyr::group_by(TEST) %>%
      dplyr::arrange(DIST_Q, CONTROL) %>%
      dplyr::mutate(DIST_RANK = dplyr::min_rank(DIST_Q)) %>%
      dplyr::filter(DIST_RANK <= topN) %>%
      dplyr::ungroup()

    CONTROL_STR_LIST <- if (exists('CONTROL_STR_LIST')) {
      rbind(CONTROL_STR_LIST,CONTROL_STR_LIST_1)
    } else {
      CONTROL_STR_LIST_1
    }
  }
  # Output list of Test and Controls
  return(CONTROL_STR_LIST)
  # assign( CONTROL_STR_LIST, paste0("Randomized Selection_seed_",rand_num), envir = .GlobalEnv #)
}
