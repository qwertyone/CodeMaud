##initiate packages
library("rvest")
library("XML")
library("selectr")

##begin update of URLs and files to download
url<-"http://www.fda.gov/MedicalDevices/DeviceRegulationandGuidance/PostmarketRequirements/ReportingAdverseEvents/ucm127891.htm"
listFiles <- getHTMLLinks(url, externalOnly = TRUE)
listFiles <- listFiles[31:84]

##begin download and extraction of zip files and save file as csv
dir = "D:/MAUDE"
setwd(dir)

for file in listFiles:
  temp = tempfile()
  download.file(file,temp)
  data <- read.table(unz(temp, file))
  unlink(temp)
  ##retrieve file name
  write.csv(data, file, sep = "\t", row.names = FALSE, col.names = TRUE)



##clean data for organizational level dataframe
