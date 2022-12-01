NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(tidyr)
library(ggplot2)

summaryDF <- NEI %>%
  filter(fips == "24510") %>% group_by(year, type) %>% summarise(
    totalEmissions = sum(Emissions)
  )

png("plot3_p2.png")
summaryDF %>%
  ggplot(aes(x = year, y = totalEmissions, colour = type)) +
  geom_point() +
  geom_line()
dev.off() 



