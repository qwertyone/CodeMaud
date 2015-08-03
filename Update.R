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
  dir = "D:/MAUDE"
  setwd(dir)
  temp = tempfile()
  download.file(file,temp)
  fileName = sub("http://www.accessdata.fda.gov/MAUDE/ftparea/","",file)
  data <- read.csv(unzip(temp), header=TRUE)
  unlink(temp)
  fileName = sub(".zip","",fileName)
  ##retrieve file name
  dir = "D:/MAUDE/RawData"
  setwd(dir)
  write.csv(data, filename = fileName, sep = "\t", row.names = FALSE, col.names = TRUE)
}

##clean data for organizational level dataframe
