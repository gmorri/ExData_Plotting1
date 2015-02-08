#Load data
consumption <- loadData1()



global_reactive_pwr <- function(data1){
    #initiate plot without plotting points
    plot(data1$Global_reactive_power ~ data1$Time,type="n",ylab="Global_inactive_power",xlab="datetime")
    #add lines to plot
    lines(data1$Time,data1$Global_reactive_power,type="l")
}

voltage <- function(data){
    #initiate plot without plotting points
    plot(data$Voltage ~ data$Time,type="n",ylab="Voltage",xlab="datetime")
    #add lines to plot
    lines(data$Time,data$Voltage,type="l")
}

sub_metering <- function(data){
  #Plot without lines
  plot(test_POSIXct$Sub_metering_1 ~ test_POSIXct$Time,type="n",xlab="",ylab="Energy sub metering")
  #add line for sub metering 1 default black
  lines(test_POSIXct$Time,test_POSIXct$Sub_metering_1,type="l")
  #add line for sub metering 2 in red
  lines(test_POSIXct$Time,test_POSIXct$Sub_metering_2,col="red",type="l")
  #add line for sub metering 3 in blue
  lines(test_POSIXct$Time,test_POSIXct$Sub_metering_3,col="blue",type="l")
  
  #set legend
  legend("topright", #place legend in upper right corner
         c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
         lty=c(1,1,1),lwd=c(2.5,2.5,2.5),
         col=c("black","blue","red"), #set color of lines
         bty="n") #remove legend border
}

global_active_pwr <- function(data){
  #initiate plot without plotting points
  plot(data$Global_active_power ~ data$Time,type="n",xlab="",ylab="Global Active Power")
  #add lines to plot
  lines(data$Time,data$Global_active_power,type="l")
}

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

png(file="plot4.png",height=480,width=480)
par(mfrow=c(2,2))
with(consumption,{
  global_active_pwr(consumption)
  voltage(consumption)
  sub_metering(consumption)
  global_reactive_pwr(consumption)
})

dev.off()