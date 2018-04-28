# Create Hexbin Sticker

library(hexSticker)
library(ggplot2)
library(magrittr)

# Build data for ggplot
set.seed(17)
A <- rnorm(n = 100000, mean = 100, 25)
B <- rnorm(n = 100000, mean = 300, 30)

df <- as.data.frame(cbind(A,B))

# Build ggplot

stckr <- df %>%
  ggplot(aes(x = A)) + geom_density(col = 'black', alpha = 0.75) +
  geom_density(aes(x = B), col = 'black', alpha = 0.75) +
  xlab('') +
  annotate("text", x = 100, y = 0.005, label = "A", size = 7.5) +
  annotate("text", x = 300, y = 0.005, label = "B", size = 7.5) +
  theme_bw() +
  theme_transparent() +
  theme(legend.position="none")

# Build Sticker

sticker(stckr, package="TestContR", p_color = "#000000", h_color = "#000000",
        h_fill = "#EEEEEE",
        s_x = 0.9, s_y = 0.75,
        s_width = 1.9, s_height = 1.0,
        p_size = 24
        )
