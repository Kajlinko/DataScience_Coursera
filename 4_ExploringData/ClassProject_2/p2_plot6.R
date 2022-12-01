NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(tidyr)
library(ggplot2)

colnames(NEI)
unique(SCC[,7])

df <- left_join(NEI, SCC, by = c("SCC" = "SCC"))

summaryDF <- df %>%
  filter(SCC.Level.Two == "Highway Vehicles - Gasoline" | 
           SCC.Level.Two == "Highway Vehicles - Diesel" |
           SCC.Level.Two == "Off-highway Vehicle Gasoline, 2-Stroke" |
           SCC.Level.Two == "Off-highway Vehicle Gasoline, 4-Stroke" |
           SCC.Level.Two == "Off-highway Vehicle Diesel") %>%
  filter(fips == "24510" | fips == "06037")

summaryDF <- summaryDF %>% group_by(year, fips) %>% summarise(
  totalEmissions = sum(Emissions)
)

png("p2_plot6.png")
summaryDF %>%
  ggplot(aes(x = year, y = totalEmissions, colour = fips)) +
  geom_point() +
  geom_line()
dev.off() 


