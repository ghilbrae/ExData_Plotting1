library(sqldf)

## Select data from 01/02/2007 to 02/02/2007
target_data <- read.csv.sql('household_power_consumption.txt', sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", header = TRUE, sep = ";")

## Plot
hist(target_data$Global_active_power, main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)', col = 'red')
# Copy to file
dev.copy(png, width = 480, height = 480, file = 'figure/plot1.png')
dev.off()


