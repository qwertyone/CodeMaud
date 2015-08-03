##initiate packages
library("rvest")
library("XML")
library("selectr")

##begin update of URLs and files to download
url<-"http://www.fda.gov/MedicalDevices/DeviceRegulationandGuidance/PostmarketRequirements/ReportingAdverseEvents/ucm127891.htm"
listFiles <- getHTMLLinks(url, externalOnly = TRUE)
listFiles <- listFiles[31:84]

##begin download and extraction of zip files and save file as csv

##clean data for organizational level dataframe
