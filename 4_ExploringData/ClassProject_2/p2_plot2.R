NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(tidyr)

summaryDF <- NEI %>%
  group_by(year) %>% filter(fips == "24510") %>%
  summarise(
    totalEmissions = sum(Emissions)
  )

png("plot2_p2.png")
plot(summaryDF$year, summaryDF$totalEmissions, pch = 3, cex = 2, col = "black")
lines(summaryDF$year, summaryDF$totalEmissions, col = "red", lwd = 2)
dev.off()

