# CREATE A RANKED LIST OF MATCHES BASED ON DISTANCE.

# Libraries loaded in BUILD_METRICS.R script
library(reshape2)
library(tidyverse)

df <- datasets::airquality # needs to have stores/unit as rownames

# Convert column #1 to rownames and scale the dataset

rownames(df) <- df[1]
df_scaled <- scale(df)

#---- Build the Distant Matrix----
DF_DIST <- dist(df_scaled , method = "euclidian")

# Convert to Matrix
DF_RANK_BASE <- as.matrix(DF_DIST)

# Force NA on upper triangle and diagnol of 0's
DF_RANK_BASE[upper.tri(DF_RANK_BASE)] <- NA 
diag(DF_RANK_BASE) <- NA


DF_RANK_BASE_1 <- reshape2::melt(DF_RANK_BASE)
names(DF_RANK_BASE_1) <- c("CONTROL","TEST","DIST_Q")

DF_RANK_FINAL <- DF_RANK_BASE_1 %>% na.omit() %>%
                dplyr::arrange(TEST,DIST_Q,CONTROL)



