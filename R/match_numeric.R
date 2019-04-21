#' Test and Control Selector for Groups/Individuals, Numeric Input Variables/Metrics.
#'
#' Randomly select test groups/individuals and create matching control
#' groups/individuals by using Euclidean distance on scaled numeric variables.
#' The data frame must contain the group/individual labels in the first column
#' and the other variables must be in levels, in other words not scaled.
#'
#' @details In the case where duplicates arise in the Control, the function iterates
#' through the test control list until there are no duplicates in the Control.
#' In each iteration, it re-ranks the remaining possible control groups/individuals
#' and matches to the test on the lowest distance.
#'
#' You can supply a data frame of pre-selected test groups/individuals to the
#' parameter test_list and the function will provide you with a list of control
#' groups/individuals.
#'
#' @param df data frame of numeric inputs. First column must have group/individuals names, 1 line per group/individuals.
#' @param n size of the test group, and matching control group. Defaults to 10. Defaults to 10. Will be ignored if df provide to the "test_list" parameter.
#' @param test_list df with one column named "TEST." This has a list of members in the current test. Defaults to NULL.
#' @return If the "n" parameter is used, the function outputs a data frame with a list of randomized test groups/individuals from the supplied df with matching control groups/individuals, a 1 to 1 match.
#' If a data frame is supplied to the "test_list" parameter, 1 to 1 matching control stores will be created for the groups/individuals in the "TEST" column supplied to the "test_list" parameter.
#' @examples
#' library(dplyr)
#' library(magrittr)
#' df <- datasets::USArrests %>% dplyr::mutate(state = base::row.names(datasets::USArrests)) %>%
#'                               dplyr::select(state, dplyr::everything())
#'
#' TEST_CONTROL_LIST <- TestContR::match_numeric(df, n = 15)
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export



##----PART #1---------------------------------------------------------

# CREATE A RANKED LIST OF MATCHES BASED ON DISTANCE.

# Libraries loaded in BUILD_METRICS.R script
#require(reshape2)
#require(tidyverse)


match_numeric <- function ( df, n = 10 , test_list = NULL ) {

    # Prep for Distance: Convert column #1 to rownames and scale the dataset

    df <- as.data.frame(df)
    rownames(df) <- df[,1]
    df_scaled <- scale(df[,-1], center = TRUE, scale = TRUE)

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
      dplyr::arrange(.data$TEST,.data$DIST_Q,.data$CONTROL)


    ##----PART #2----------------------------------------------------------

    # RANDOMLY SELECT THE LIST/DF OF THE TEST AND CONTROL GROUPS

    #set.seed(17)
    if( is.null((test_list)) ) {
      DF_TEST <- df %>% dplyr::sample_n(size = n) # Sample size of test
    } else {
      names(test_list) <- c("TEST")
      DF_TEST <- as.data.frame(test_list['TEST'])
    }
    # Test and Control List

    DF_DIST_REDUCED <- DF_DIST_FINAL %>% dplyr::filter(!.data$CONTROL %in% (DF_TEST[,1])) %>%
      dplyr::filter(.data$TEST %in% (DF_TEST[,1]))

    CONTROL_STR_LIST <- DF_DIST_REDUCED %>%
      dplyr::group_by(.data$TEST) %>%
      dplyr::mutate(DIST_RANK = dplyr::min_rank(.data$DIST_Q)) %>%
      dplyr::filter(.data$DIST_RANK <= 1) %>%
      dplyr::select(-.data$DIST_RANK) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(GROUP = dplyr::row_number(.data$TEST))

    # Create list of Dupes
    DUPES_LIST <- CONTROL_STR_LIST %>% dplyr::group_by(.data$CONTROL) %>%
      dplyr::summarise(control_cnt = n()) %>%
      dplyr::filter(.data$control_cnt > 1)

    # Run While loop over the list of duplicates, until no more dupes remain
    i = 0

    while (nrow(DUPES_LIST) > 0) {
      # Count the number of iterations
      i = i + 1
      print(sprintf("The %sth de-duping iteration started", i))
      # rank the duplicate control stores and keep the minimum rank

      rank_dupes <- DUPES_LIST %>%
        dplyr::inner_join(CONTROL_STR_LIST) %>%
        dplyr::group_by(.data$CONTROL) %>%
        dplyr::mutate(rank = dplyr::min_rank(.data$DIST_Q)) %>%
        dplyr::filter(.data$rank > 1)

      # Remove the duplicate from remaining distance list

      DF_DIST_FINAL_TEMP <- DF_DIST_REDUCED %>% dplyr::anti_join(rank_dupes, by = "CONTROL")

      # Remove the duplicate data from CONTROL_STR_LIST distance list

      CONTROL_STR_LIST_TEMP <-CONTROL_STR_LIST %>% dplyr::left_join(rank_dupes)

      CONTROL_STR_LIST_TEMP <- CONTROL_STR_LIST_TEMP %>%
        dplyr::mutate(CONTROL = dplyr::if_else(is.na(rank) == TRUE, .data$CONTROL, NULL),
                      DIST_Q = dplyr::if_else(is.na(rank) == TRUE, .data$DIST_Q,NULL))

      # select new minimum from the remaining list

      TEST_DUPES_TEMP <- CONTROL_STR_LIST_TEMP %>% dplyr::filter(is.na(.data$DIST_Q)) %>% dplyr::select(.data$TEST)
      CONT_DUPES_TEMP <- CONTROL_STR_LIST_TEMP %>% dplyr::filter(!is.na(.data$CONTROL)) %>% dplyr::select(.data$CONTROL)

      DIST_REMAINING <- DF_DIST_FINAL_TEMP %>% dplyr::inner_join(TEST_DUPES_TEMP, by = 'TEST') %>%
        dplyr::anti_join(CONT_DUPES_TEMP, by = 'CONTROL') %>%
        dplyr::group_by(.data$TEST) %>%
        dplyr::arrange(.data$TEST, .data$DIST_Q) %>%
        dplyr::mutate(rank = dplyr::min_rank(.data$DIST_Q)) %>%
        dplyr::filter(.data$rank == 1)

      # Add new control to test stores with missing controls stores

      CONTROL_STR_LIST <- CONTROL_STR_LIST_TEMP %>% dplyr::left_join(DIST_REMAINING, by = 'TEST') %>%
        dplyr::mutate( CONTROL = dplyr::coalesce(.data$CONTROL.x, .data$CONTROL.y),
                DIST_Q  = dplyr::coalesce(.data$DIST_Q.x, .data$DIST_Q.y)) %>%
        dplyr::select(.data$CONTROL, .data$TEST, .data$DIST_Q, .data$GROUP)

      # re-move all test and control stores from the current dist df
      DF_DIST_FINAL <- DF_DIST_FINAL_TEMP %>% dplyr::anti_join(CONTROL_STR_LIST, by = "CONTROL")

      # re-build the Dupes_list

      DUPES_LIST <- CONTROL_STR_LIST %>% dplyr::group_by(.data$CONTROL) %>%
        dplyr::summarise(control_cnt = n()) %>%
        dplyr::filter(.data$control_cnt > 1)

      # ends when DUPES_LIST is nrow() = 0
      print(sprintf("The %sth de-duping iteration complete.", i))

    }

    # Output list of Test and Controls
    return(CONTROL_STR_LIST)
      # assign( CONTROL_STR_LIST, paste0("Randomized Selection_seed_",rand_num), envir = .GlobalEnv #)
  }
