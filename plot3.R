

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


#create data frame with data for feb1 and feb2
test_POSIXct <- loadData1()

#open connection to png
png(file="plot3.png",width=480,height=480)

#Plot without lines
plot(test_POSIXct$Sub_metering_1 ~ test_POSIXct$Time,type="n",xlab="",ylab="Energy sub metering")
#add line for sub metering 1 default black
lines(test_POSIXct$Time,test_POSIXct$Sub_metering_1,type="l")
#add line for sub metering 2 in red
lines(test_POSIXct$Time,test_POSIXct$Sub_metering_2,col="red",type="l")
#add line for sub metering 3 in blue
lines(test_POSIXct$Time,test_POSIXct$Sub_metering_3,col="blue",type="l")

#set legend
legend("topright",
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),
       lwd=c(2.5,2.5,2.5),
       col=c("black","blue","red"))

dev.off()