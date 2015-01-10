library(data.table)

date.data <- as.data.frame(fread("sed '1p;/^[12]\\/2\\/2007/!d' household_power_consumption.txt",sep=";",header=TRUE))

DateTime<-strptime(paste(date.data[,"Date"],date.data[,"Time"],sep=" "), format="%d/%m/%Y %H:%M:%S")
date.data<-cbind(DateTime,date.data)

date.data<-as.data.table(date.data)

date.data[,"Time":=NULL]
date.data[,"Date":=NULL]

png(filename="plot3.png",width=480,height=480,bg="transparent")
plot(date.data$DateTime,date.data$Sub_metering_1,ylab="Energy sub metering",xlab="",main="",type="l",col="black")
lines(date.data$DateTime,date.data$Sub_metering_2,col="red")
lines(date.data$DateTime,date.data$Sub_metering_3,col="blue")
legend("topright",lwd=c(2.5,2.5,2.5), col = c("black","red", "blue"), legend = c("Sub_setting_1", "Sub_setting_2","Sub_setting_3"))
dev.off()
