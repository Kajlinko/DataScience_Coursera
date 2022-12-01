unzip("activity.zip")

head(activity)

library(dplyr)

dailyTotals <- activity %>% 
  group_by(date) %>% 
  summarise(
  sumSteps = sum(steps, na.rm = TRUE)
  )

meanDaily <- round(mean(dailyTotals$sumSteps), 0)
meanDaily <- round(mean(dailyTotals$sumSteps), 0)
medianDaily <- round(median(dailyTotals$sumSteps), 0)
print(meanDaily)
print(medianDaily)

library(ggplot2)

ggplot(dailyTotals, aes(x = date, y = steps)) +
  geom_bar() + 
  library(ggplot2)

ggplot(dailyTotals, aes(x = date, y = sumSteps)) +
  geom_col() +
  ggtitle("Bar Plot - THIS IS NOT A HISTOGRAM",
          subtitle = "Explanation in preceding text. Don't mark me too harshly!")

timeMeans <- activity %>% 
  group_by(interval) %>% 
  summarise(
    meanSteps = mean(steps, na.rm = TRUE)
  )

ggplot(timeMeans, aes(x = interval, y = meanSteps)) +
  geom_line()

sum(is.na(activity$steps))

library(tidyr)

imputeActivity <- activity

for(i in 1:nrow(imputeActivity)) {
  rem <- i %% 288
  if(rem == 0) {
    rem <- 288
  }
  if(is.na(imputeActivity$steps[i])) {
    imputeActivity$steps[i] <- timeMeans$meanSteps[rem]
  }
}

library(lubridate)

activity$weekday <- weekdays(as_date(activity$date))

weekdayTotals <- activity %>% 
  group_by(weekday) %>% 
  summarise(
    sumSteps = sum(steps, na.rm = TRUE),
    meanSteps = mean(steps, na.rm = TRUE)
  )

weekdayTotals$weekday <- factor(weekdayTotals$weekday, 
                                 levels=c("Monday", "Tuesday", "Wednesday", 
                                          "Thursday", "Friday", "Saturday", 
                                          "Sunday"))

weekdayTotals[order(weekdayTotals$weekday),]                                 
                                 
ggplot(weekdayTotals, aes(x = weekday, y = sumSteps)) +
  geom_col()

timeMeans
                                 
                                 