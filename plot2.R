setwd("/home/maria/R/exdata_data_NEI_data/")

#imports NEI table, if it doesn't exist
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}

#defines variables for "for" loop
total<-0
count<-1
year<-c(1999,2002,2005,2008)
for (number in year){
  matrix<-subset(NEI,year==number & fips %in% "24510")
  total[count]<-sum(matrix$Emissions)
  count<-count+1
}

#plots the chart in a png file
png('Plot2.png')
barplot(height=total, names.arg=year, xlab="Year", ylab="Total PM2.5 (tons)", main="Total PM2.5 emission from all sources in Baltimore, Maryland ")
dev.off()