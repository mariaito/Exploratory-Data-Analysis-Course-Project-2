setwd("/home/maria/R/exdata_data_NEI_data/")

#imports NEI table, if it doesn't exist
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
#imports SCC table, if it doesn't exist
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

#searches SCC for the term "vehicle", case insensitive
a<-grep("vehicle",SCC$EI.Sector,ignore.case = T)
b<-SCC[a,]

#defines variables for "for" loop
year<-c(1999,2002,2005,2008)
count<-1
total=matrix(nrow=4,ncol=2)

for (number in year){
  matrix_BAL<-subset(NEI,year==number & SCC %in% b$SCC & fips == "24510")
  matrix_LA<-subset(NEI,year==number & SCC %in% b$SCC & fips == "06037")
  total[count,1]<-sum(matrix_BAL$Emissions)
  total[count,2]<-sum(matrix_LA$Emissions)
  count<-count+1
}
colnames(total)<-c("Baltimore","Los Angeles")

#plots the chart in a png file
png('Plot6.png')
par(mfrow=c(1,2))
barplot(height=total[,1], names.arg=year, xlab="Year", ylab="PM2.5 emission (tons)", main="Baltimore", ylim = c( 0 , 4600 ))
barplot(height=total[,2], names.arg=year, xlab="Year", ylab="PM2.5 emission (tons)", main="Los Angeles", ylim = c( 0 , 4600 ))
title( "Total PM2.5 emission from motor vehicle sources", outer = TRUE, line=-1 )
dev.off()