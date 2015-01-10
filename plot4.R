library(data.table)

date.data <- as.data.frame(fread("sed '1p;/^[12]\\/2\\/2007/!d' household_power_consumption.txt",sep=";",header=TRUE))

DateTime<-strptime(paste(date.data[,"Date"],date.data[,"Time"],sep=" "), format="%d/%m/%Y %H:%M:%S")
date.data<-cbind(DateTime,date.data)

date.data<-as.data.table(date.data)

date.data[,"Time":=NULL]
date.data[,"Date":=NULL]

png(filename="plot4.png",width=480,height=480,bg="transparent")
par(mfrow = c(2, 2))

with(date.data, { 
  plot(date.data$DateTime,date.data$Global_active_power,ylab="Global Active Power",xlab="",main="",type="l")
  
  plot(date.data$DateTime,date.data$Voltage,ylab="Voltage",xlab="datetime",main="",type="l")
  
  plot(DateTime,Sub_metering_1,ylab="Energy sub metering",xlab="",main="",type="l",col="black")
  lines(DateTime,Sub_metering_2,col="red")
  lines(DateTime,Sub_metering_3,col="blue")
  legend("topright",lwd=c(2.5,2.5,2.5), col = c("black","red", "blue"), legend = c("Sub_setting_1", "Sub_setting_2","Sub_setting_3"),bty="n")
  
  plot(date.data$DateTime,date.data$Global_reactive_power,ylab="Global_reactive_power",xlab="datetime",main="",type="l")
  
})
dev.off()
