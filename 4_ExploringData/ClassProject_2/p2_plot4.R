NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(tidyr)
library(ggplot2)

colnames(NEI)
unique(SCC[,7])

df <- left_join(NEI, SCC, by = c("SCC" = "SCC"))

summaryDF <- df %>%
  filter(SCC.Level.One == "External Combustion Boilers" |
         SCC.Level.One == "Internal Combustion Engines" | 
         SCC.Level.One == "Stationary Source Fuel Combustion")

summaryDF <- summaryDF[grepl("([Cc]oal)", summaryDF[,8]),]

summaryDF <- summaryDF %>% group_by(year) %>% summarise(
  totalEmissions = sum(Emissions)
)

png("plot3_p2.png")
summaryDF %>%
  ggplot(aes(x = year, y = totalEmissions)) +
  geom_point() +
  geom_line()
dev.off() 



