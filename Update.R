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
  setwd(dir)
  temp = tempfile()
  download.file(file,temp)
  data <- read.csv(unzip(temp), header=TRUE)
  unlink(temp)
  ##retrieve file name
  fileName = sub("http://www.accessdata.fda.gov/MAUDE/ftparea/","",file)
  fileName = sub(".zip","",fileName)
  ##set directory for saving data prior to cleaning
  n <- paste("D:/MAUDE/RawData/",fileName,sep="")
  n <- paste(n,".csv",sep="")
  write.csv(data, file = n, sep = "\t", row.names = FALSE, col.names = TRUE)
}

##clean data for organizational level dataframe
