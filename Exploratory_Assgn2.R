##Assignt2
##Read data
data <- read.table("household_power_consumption.txt",header = FALSE, sep = "")
str(data)

df2 %>% select(data,c('Date','Time'))