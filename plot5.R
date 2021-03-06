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
total<-0

for (number in year){
  matrix<-subset(NEI,year==number & SCC %in% b$SCC & fips == "24510")
  total[count]<-sum(matrix$Emissions)
  count<-count+1
}

#plots the chart in a png file
png('Plot5.png')
barplot(height=total, names.arg=year, xlab="Year", ylab="PM2.5 emission (tons)", main="Total PM2.5 emission from motor vehicle sources in Baltimore")
dev.off()