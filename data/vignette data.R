
#df <- datasets::iris # needs to have stores/unit as rownames
#df$flower_num <- as.integer(rownames(df))
#df <- select(df, flower_num, everything()) %>% select(-Species)

df <- USArrests %>% mutate(state = row.names(USArrests)) %>%
      select(state, everything())
