# Dev script to remove dupes in Control List

DUPES_LIST <- CONTROL_STR_LIST %>% dplyr::group_by(CONTROL) %>%
              summarise(control_cnt = n()) %>%
              filter(control_cnt > 1)


for (i in rnow(CONTROL_STR_LIST)) {
  if (nrow(DUPES_LIST) == 0) {
      print("No Dupes Detected in the Control")
    break
  } else {

  }

}
