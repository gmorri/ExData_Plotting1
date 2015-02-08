

loadData1 <- function(){
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
  
  #change time col from POSIXlt to POSIXct
  feb1_feb2$Time <- as.POSIXct(feb1_feb2$Time)
  
  return(feb1_feb2)
}


#load for feb1 and feb2 2007
test_POSIXct <- loadData1()

#open connection to png
png(file="plot2.png",width=480,height=480)
#initiate plot without plotting points
plot(test_POSIXct$Global_active_power ~ test_POSIXct$Time,type="n",xlab="",ylab="Global Active Power (kilowatts)")
#add lines to plot
lines(test_POSIXct$Time,test_POSIXct$Global_active_power,type="l")
dev.off()