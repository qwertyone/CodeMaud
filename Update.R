##initiate packages
library("rvest")
library("XML")
library("selectr")

##begin update of URLs and files to download
url<-"http://www.fda.gov/MedicalDevices/DeviceRegulationandGuidance/PostmarketRequirements/ReportingAdverseEvents/ucm127891.htm"
listFiles <- getHTMLLinks(url, externalOnly = TRUE)
listFiles <- listFiles[31:84]

##begin download and extraction of zip files and save file as csv
for (file in listFiles) {
  dir = tempdir()
  #setwd(dir)
  temp = tempfile()
  download.file(file,temp)
  data <- read.table(unzip(temp), header=TRUE, fill=TRUE, quote="", sep = "|", stringsAsFactors=FALSE)
  unlink(temp)
  ##use pattern matching to remove URLs and suffixes from table links
  fileName = sub("http://www.accessdata.fda.gov/MAUDE/ftparea/","",file)
  fileName = sub(".zip","",fileName)
  ##set directory for saving data prior to cleaning
  n <- paste("D:/MAUDE/RawData/",fileName,sep="")
  n <- paste(n,".csv",sep="")
  write.table(data, file = n, sep = "|", col.names = TRUE)
}

###!!L!!!!e!!!!!!!!being revised !!N!!!!Broken code below!!G!!o
wd = "D:/MAUDE/RawData/"
setwd(wd)
library(plyr)
##return names in working directory (wd) that match string. Create complete database.
#file_list <- list.files(wd,"foidev")
#data<-ldply(file_list,read.table, sep="|", head=TRUE, fill=TRUE,stringsAsFactors=FALSE, na.strings=FALSE)
#write.table(data, "complete_foidev.txt", row.names=FALSE, col.names=TRUE, sep="|",quote=FALSE)
###########################
file_list <- list.files(wd,"mdrfoi")
data<-ldply(file_list,read.table, sep="|", head=TRUE, fill=TRUE,stringsAsFactors=FALSE, na.strings=FALSE)
write.table(data, "D:/MAUDE/RawData/mdrfoi_complete.txt", row.names=FALSE, col.names=TRUE, sep="|",quote=FALSE)
############
rm(list=ls())
#df1<-read.table("complete_mdrfoi.txt", row.names=NULL,fill=TRUE, sep="|", quote="", stringsAsFactors=FALSE, head=TRUE)
#library(data.table)
#df1<-df1[grep("", "Manufacturer", ignore.case = TRUE)]
#df2<-read.table("complete_foidev.txt", row.names=NULL,fill=TRUE, sep="|", quote="", stringsAsFactors=FALSE)
#data<-merge(data1,data2,by="MDR_Report_Key", all=TRUE)
#write.table(data, "maqquery1.txt", row.names=FALSE, col.names=TRUE, sep="|",quote=FALSE)
##clean data for organizational level dataframe
