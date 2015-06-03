library(sqldf)
library(lubridate)

## Select data from 01/02/2007 to 02/02/2007
target_data <- read.csv.sql('household_power_consumption.txt', sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", header = TRUE, sep = ";")

## Convert the Date and Time variables to Date/Time. Using lubridate library to 
## change the Date and Time columns into Date/Time formats.
target_data$Date <- dmy(target_data$Date)
target_data$Time <- hms(target_data$Time)
# Add a column corresponding to the weekday in abbreviated form.
target_data$weekday <- weekdays(target_data$Date, abbreviate = TRUE)

## Plot
plot(target_data$Global_active_power, type = 'l', xaxt = 'n', ylab = 'Global Active Power (kilowatts)', xlab = '')
# Find the x values where the weekday changes
start_fri <- head(which(target_data$weekday == 'Fri'), n = 1)
start_sat <- tail(which(target_data$weekday == 'Fri'), n = 1) + 1
# Add weekday to X axis
axis(side=1, labels=c("Thu", "Fri", "Sat"), at=c(0, start_fri, start_sat))
# Copy to file
dev.copy(png, width = 480, height = 480, file = 'figure/plot2.png')
dev.off()
