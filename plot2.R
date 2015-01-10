library(data.table)

date.data <- as.data.frame(fread("sed '1p;/^[12]\\/2\\/2007/!d' household_power_consumption.txt",sep=";",header=TRUE))

DateTime<-strptime(paste(date.data[,"Date"],date.data[,"Time"],sep=" "), format="%d/%m/%Y %H:%M:%S")
date.data<-cbind(DateTime,date.data)

date.data<-as.data.table(date.data)

date.data[,"Time":=NULL]
date.data[,"Date":=NULL]

png(filename="plot2.png",width=480,height=480,bg="transparent")
plot(date.data$DateTime,date.data$Global_active_power,ylab="Global Active Power (kilowatts)",xlab="",main="",type="l")
dev.off()
