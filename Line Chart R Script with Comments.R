library(ggplot2)
library(reshape2)
library(plyr)

#load data
spx_ftse_00_10 <- read.csv("line_chart_data.csv",
                           header = TRUE,
                           sep = ",")
#format year in date format with the help of the reshape2 library
spx_ftse_00_10$Date <- as.Date(spx_ftse_00_10$Date,
                               format = "%m/%d/%Y")
#combine variables into one. In this case, the GSPC500 and FTSE100
spx_ftse_00_10_melt <- melt(spx_ftse_00_10,
                            id = "Date")
#rename columns using the plyr library
spx_ftse_00_10_melt <- rename(spx_ftse_00_10_melt,
                              c("value" = "Returns",
                                "variable" = "Index"))

#create line chart for 2000 - 2010
line_chart <- ggplot(spx_ftse_00_10_melt,
                     aes(x = Date,
                         y = Returns,
                         colour = Index,
                         group = Index)) +
  geom_line(aes(color = Index),
            size = 1) +
  scale_color_manual(values = c("navyblue", "red4")) +
  theme_minimal() +
  ggtitle("S&P vs FTSE Returns (2000 - 2010)")
line_chart


# new date intervals for H2 2008
min <- as.Date("2008-7-1")
max <- as.Date("2008-12-31")

#line chart for H2 of 2008
line_chart_H2_08 <- ggplot(spx_ftse_00_10_melt,
                           aes(x = Date,
                               y = Returns,
                               colour = Index,
                               group = Index)) +
  geom_line(aes(color = Index),
            size = 1) +
  scale_color_manual(values = c("navyblue", "red4")) +
  theme_minimal() +
  ggtitle("S&P vs FTSE Returns (H2 2008)") +
  scale_x_date(limits = c(min, max)) +
  theme(legend.justification = c(0.01,1),
        legend.position = c(0.01,1))
line_chart_H2_08

