setwd("/home/maria/R/exdata_data_NEI_data/")

#loads library ggplot2
library(ggplot2)

#imports NEI table, if it doesn't exist
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}

#defines variables for "for" loop
teste<-0
count<-1
year<-c(1999,2002,2005,2008)

for (number in year){
  matrix<-subset(NEI,year==number & fips %in% "24510")
  total<-aggregate(matrix$Emissions, by=list(Category=matrix$type), FUN=sum)
  total$year<-rep(number,4)
  teste<-rbind(teste,total)
}
teste<-teste[-1,]

#plots the chart in a png file
png('Plot3.png')
p<-ggplot(teste,aes(year,x))+geom_point()+facet_grid(.~Category)+theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+labs(title = "Total PM2.5 emission in Baltimore, per type", x = "Year", y = "PM2.5 emission (tons)")
print(p)
dev.off()