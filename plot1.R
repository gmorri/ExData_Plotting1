


loadData <- function(){
  #separator in text file is ;
  #first column is date in day/month/year format
  #want 2007-02-01 and 2007-02-02

  total_data <- read.table("C:/Users/Mu Sigma/Documents/GitHub/ExData_Plotting1/ExData_Plotting1/household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
  feb1_feb2 <- total_data[which(total_data[,1]=="1/2/2007" | total_data[,1]=="2/2/2007"),]

  #change date from factor format to date format
  #change time from factor format to time format
  feb1_feb2$Date <- as.Date(feb1_feb2$Date,"%d/%m/%Y")
  time <- paste(feb1_feb2$Date, " ", feb1_feb2$Time)
  feb1_feb2$Time <- strptime(time,format="%Y-%m-%d %H:%M:%S")
  
  return(feb1_feb2)
}

#create data frame with data for Feb1 and Feb2
plot_data <- loadData()

#export histogram to file
png(file="plot1.png",width=480,height=480)
hist(plot_data$Global_active_power, breaks=12, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()