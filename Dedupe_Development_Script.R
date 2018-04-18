# Dev script to remove dupes in Control List

library(tidyverse)
library(dplyr)
library(random)

n <- 500

DUPES_LIST <- CONTROL_STR_LIST %>% dplyr::group_by(CONTROL) %>%
              summarise(control_cnt = n()) %>%
              filter(control_cnt > 1)

while (nrow(DUPES_LIST) > 0) {

  # rank the duplicate control stores and filter out the minimum rank

  rank_dupes <- DUPES_LIST %>% inner_join(CONTROL_STR_LIST) %>%
    group_by(CONTROL) %>% mutate(rank = min_rank(DIST_Q)) %>%
    filter(rank > 1)

  # Remove the duplicate from remaining distance list

  DF_DIST_FINAL_TEMP <- DF_DIST_FINAL %>% anti_join(rank_dupes, by = "CONTROL")

  # Remove the duplicate from CONTROL_STR_LIST distance list

  CONTROL_STR_LIST_TEMP <-
    CONTROL_STR_LIST %>% left_join(rank_dupes)

  CONTROL_STR_LIST_TEMP <- CONTROL_STR_LIST_TEMP %>%
    mutate(CONTROL = if_else(is.na(rank) == TRUE, CONTROL, NULL),
           DIST_Q = if_else(is.na(rank) == TRUE, DIST_Q,NULL))

  # select new minimum from the remaining list

  DIST_REMAINING <- CONTROL_STR_LIST_TEMP %>% filter(is.na(DIST_Q)) %>% select(TEST) %>%
    inner_join(DF_RANK_BASE_FULL_1, by = 'TEST') %>%
    filter(CONTROL != rank_dupes$CONTROL) %>%
    group_by(TEST) %>%
    arrange(DIST_Q) %>%
    mutate(rank = min_rank(DIST_Q)) %>%
    filter(rank == 1)

  # Add new control to test stores with missing controls stores

  CONTROL_STR_LIST <- CONTROL_STR_LIST_TEMP %>%
    left_join(DIST_REMAINING, by = 'TEST', copy = FALSE) %>%
    mutate( CONTROL = coalesce(CONTROL.x, CONTROL.y),
            DIST_Q  = coalesce(DIST_Q.x, DIST_Q.y)
          ) %>%
    select(CONTROL, TEST, DIST_Q, GROUP)

  # re-build the Dupes_list

  DUPES_LIST <- CONTROL_STR_LIST %>% dplyr::group_by(CONTROL) %>%
    summarise(control_cnt = n()) %>%
    filter(control_cnt > 1)

  # end of dupe list is nrow() = 0

}


