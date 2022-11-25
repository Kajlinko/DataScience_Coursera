## download packages
library(dplyr)
library(lubridate)

## filter dates of interest and convert date and time to date/time objects
powerconsumption <- read.table("household_power_consumption.txt", sep = ";")
powerconsumption <- powerconsumption %>%
  filter(V1 == "1/2/2007" | V1 == "2/2/2007")
powerconsumption$V10 = dmy_hms(paste(powerconsumption$V1, powerconsumption$V2))
powerconsumption <- subset(powerconsumption, select = -c(V1, V2))
powerconsumption <- powerconsumption %>%
  mutate(V3 = as.numeric(V3), V4 = as.numeric(V4), V5 = as.numeric(V5), 
         V6 = as.numeric(V6), V7 = as.numeric(V7), V8 = as.numeric(V8),
         V9 = as.numeric(V9))

## rename variables
variablenames <- c("globalactivepower", "globalreactivepower", "voltage", 
                   "globalintensity", "submetering1", "submetering2", 
                   "submetering3", "date_time")
colnames(powerconsumption) <- variablenames

## create charts

### chart 1

png(filename = "plot1.png", width = 480, height = 480)

hist(
  powerconsumption$globalactivepower, 
  xlab = "Global Active Power (kilowatts)",
  ylab = "Frequency",
  main = "Global Active Power",
  col = "red",
  )

dev.off()

### chart 2

png(filename = "plot2.png", width = 480, height = 480)

plot(
  powerconsumption$date_time, powerconsumption$globalactivepower, type = "l",
  xlab = "", ylab = "Global Active Power"
  )

dev.off()

### chart 3

png(filename = "plot3.png", width = 480, height = 480)

plot(powerconsumption$date_time, powerconsumption$submetering1, type = "n")
lines(powerconsumption$date_time, powerconsumption$submetering1, col = "black")
lines(powerconsumption$date_time, powerconsumption$submetering2, col = "red")
lines(powerconsumption$date_time, powerconsumption$submetering3, col = "blue")
legend("topright", legend = c("submeter1", "submeter2", "submeter3"), 
       col = c("black", "red", "blue"), pch = 20)

dev.off()

### chart 4

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

hist(
  powerconsumption$globalactivepower, 
  xlab = "Global Active Power (kilowatts)",
  ylab = "Frequency",
  main = "Global Active Power",
  col = "red",
)

plot(
  powerconsumption$date_time, powerconsumption$globalactivepower, type = "l",
  xlab = "", ylab = "Global Active Power"
)

plot(powerconsumption$date_time, powerconsumption$submetering1, type = "n",
     xlab = "", ylab = "Energy Submetering")
lines(powerconsumption$date_time, powerconsumption$submetering1, col = "black")
lines(powerconsumption$date_time, powerconsumption$submetering2, col = "red")
lines(powerconsumption$date_time, powerconsumption$submetering3, col = "blue")
legend("topright", legend = c("submeter1", "submeter2", "submeter3"), 
       col = c("black", "red", "blue"), pch = 20)
plot(
  powerconsumption$date_time, powerconsumption$globalreactivepower, type = "l",
  xlab = "", ylab = "Global Reactive Power"
)

dev.off()
