library(ggplot2)
library(readr)
library(dplyr)
library(ggthemes)

d00 <- readr::read_delim("00.dat",
  delim = " ",
  col_names = c("m", "t"),
  col_types = c(col_double(), col_double())
)
d01 <- readr::read_delim("01.dat",
  delim = " ",
  col_names = c("m", "t"),
  col_types = c(col_double(), col_double())
)
d02 <- readr::read_delim("02.dat",
  delim = " ",
  col_names = c("m", "t"),
  col_types = c(col_double(), col_double())
)
d03 <- readr::read_delim("03.dat",
  delim = " ",
  col_names = c("m", "t"),
  col_types = c(col_double(), col_double())
)
d00 <- dplyr::mutate(d00, dt = (t - t[[1]])/60)
d01 <- dplyr::mutate(d01, dt = (t - t[[1]])/60)
d02 <- dplyr::mutate(d02, dt = (t - t[[1]])/60)
d03 <- dplyr::mutate(d03, dt = (t - t[[1]])/60)
d00 <- dplyr::mutate(d00, m = m / 1000)
d01 <- dplyr::mutate(d01, m = m / 1000)
d02 <- dplyr::mutate(d02, m = m / 1000)
d03 <- dplyr::mutate(d03, m = m / 1000)

print(typeof(d00))
print(d00)

p <- (
    ggplot2::ggplot(d00) +
    ggplot2::geom_line(
      mapping = ggplot2::aes_(x = quote(dt), y = quote(m)),
      colour = "red"
    ) +
    ggplot2::geom_line(
      data = d01,
      mapping = ggplot2::aes_(x = quote(dt), y = quote(m)),
      colour = "purple"
    ) +
    ggplot2::geom_line(
      data = d02,
      mapping = ggplot2::aes_(x = quote(dt), y = quote(m)),
      colour = "green"
    ) +
    ggplot2::geom_line(
      data = d03,
      mapping = ggplot2::aes_(x = quote(dt), y = quote(m)),
      colour = "blue"
    ) +
    ggplot2::xlab("time (min)") +
    ggplot2::ylab("memory (GB)") +
    theme_classic()
)

ggplot2::ggsave(file = "mem.pdf", plot = p,
                width = 8, height = 10)
