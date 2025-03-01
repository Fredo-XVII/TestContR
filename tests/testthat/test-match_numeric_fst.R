# Test using Copilot

context("test-match_numeric_fst.R")

# Create Data for testing

test_list <- tribble(~"TEST","Colorado")

df <- datasets::USArrests %>% dplyr::mutate(state = base::row.names(USArrests)) %>%
  dplyr::select(state, everything())


test_that("Fast equals original", {
  expect_equal(
    TestContR::match_numeric(df, topN = 10, test_list = test_list),
    TestContR::match_numeric_fst(df, topN = 10, test_list = test_list))
})
