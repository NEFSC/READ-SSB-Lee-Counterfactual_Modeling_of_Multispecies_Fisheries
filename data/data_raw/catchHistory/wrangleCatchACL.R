################# Georges Bank Catch History Data Wrangling ###########################
# Code Header
# Authors: Jonathan Cummings

# code Description: 
# This code reads in catch history tables from pdfs obtained from 
# https://www.greateratlantic.fisheries.noaa.gov/ro/fso/reports/Groundfish_Catch_Accounting.htm
# And wrangles the data into a common usable format.

# Last Edit: March 13, 2019

##### Load needed libraries #####
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_201')
library(rJava)
library(tabulizer)
library(tidyverse)
library(purrr)

##### Functions #####
removeCommas<- function(table) {gsub(",", "", table, fixed = TRUE)}

wrangle<-function(data,selVars=c(2,4,6:9,11:13,15:16),sliceVars=-c(2),year=2010){
  data<-data %>%
    select(selVars) %>% 
    slice(sliceVars)
  names(data) <- c("Stock",data[1, 2:ncol(data)])
  data<-data[-1,] %>% 
    mutate('Year'=year)
  data<-map(data,removeCommas)
  data
}

##### Extract and wrangle the  the tables #####
# 2010
location<- c("FY10_Mults_Catch_Estimates.pdf")
FY10 <- extract_tables(location,pages=c(2:6),method="lattice")
# Convert to tibbles
FY10_Catch<-as_tibble(FY10[[1]])
FY10_Landing<-as_tibble(FY10[[2]])
FY10_Discard<-as_tibble(FY10[[3]])
FY10_ACL<-as_tibble(FY10[[4]])
FY10_CtoACL<-as_tibble(FY10[[5]])
# Wrangle
FY10_Catch<-wrangle(FY10_Catch,selVars=c(2,4,6:9,11:12,14:15),sliceVars=-c(1,3:4))
FY10_Landing<-wrangle(FY10_Landing,selVars=c(2,4,6:9,11:12,14:15),sliceVars=-c(1,3:4))
FY10_Discard<-wrangle(FY10_Discard,selVars=c(2,4,6:9,11:12,14:15),sliceVars=-c(1,3:4))
FY10_ACL<-wrangle(FY10_ACL,selVars=c(2,4,6:9,11:12,14:15),sliceVars=-c(1,3:4))
FY10_CtoACL<-wrangle(FY10_CtoACL,selVars=c(2,4,6:9,11:12,14:15),sliceVars=-c(1,3:4))

# 2011
location<- c("FY11_Mults_Catch_Estimates.pdf")
FY11 <- extract_tables(location,pages=c(2:6),method="lattice")
# Convert to tibbles
FY11_Catch<-as_tibble(FY11[[1]])
FY11_Landing<-as_tibble(FY11[[2]])
FY11_Discard<-as_tibble(FY11[[3]])
FY11_ACL<-as_tibble(FY11[[4]])
FY11_CtoACL<-as_tibble(FY11[[5]])
# Wrangle
FY11selVars<-c(2,4,6:9,11:12,14:15)
FY11sliceVars<- -c(1,3)
FY11_Catch<-wrangle(FY11_Catch,selVars=FY11selVars,sliceVars=FY11sliceVars,year=2011)
FY11_Landing<-wrangle(FY11_Landing,selVars=FY11selVars,sliceVars=FY11sliceVars,year=2011)
FY11_Discard<-wrangle(FY11_Discard,selVars=FY11selVars,sliceVars=FY11sliceVars,year=2011)
FY11_ACL<-wrangle(FY11_ACL,selVars=c(1:ncol(FY11_ACL)),sliceVars=FY11sliceVars,year=2011)
FY11_CtoACL<-wrangle(FY11_CtoACL,selVars=FY11selVars,sliceVars=-1,year=2011)

# 2012
location<- c("FY12_Mults_Catch_Estimates.pdf")
FY12 <- extract_tables(location,pages=c(2:6),method="lattice")
# Convert to tibbles
FY12_Catch<-as_tibble(FY12[[1]])
FY12_Landing<-as_tibble(FY12[[2]])
FY12_Discard<-as_tibble(FY12[[3]])
FY12_ACL<-as_tibble(FY12[[4]])
FY12_CtoACL<-as_tibble(FY12[[5]])
# Wrangle
FY12selVars<-c(2,4,6:9,11:12,14:15)
FY12sliceVars<- -c(1,3)
FY12_Catch<-wrangle(FY12_Catch,selVars=FY12selVars,sliceVars=FY12sliceVars,year=2012)
FY12_Landing<-wrangle(FY12_Landing,selVars=FY12selVars,sliceVars=FY12sliceVars,year=2012)
FY12_Discard<-wrangle(FY12_Discard,selVars=FY12selVars,sliceVars=FY12sliceVars,year=2012)
FY12_ACL<-wrangle(FY12_ACL,selVars=FY12selVars,sliceVars=FY12sliceVars,year=2012)
FY12_CtoACL<-wrangle(FY12_CtoACL,selVars=FY12selVars,sliceVars=FY12sliceVars,year=2012)

#2013
location<- c("FY13_Mults_Catch_Estimates.pdf")
FY13 <- extract_tables(location,pages=c(2:6),method="lattice")
# Convert to tibbles
FY13_CtoACL<-as_tibble(FY13[[1]])
FY13_ACL<-as_tibble(FY13[[2]])
FY13_Catch<-as_tibble(FY13[[3]])
FY13_Landing<-as_tibble(FY13[[4]])
FY13_Discard<-as_tibble(FY13[[5]])
# Wrangle
FY13selVars<-c(2,4,6:9,11:13,15:16)
FY13sliceVars<- -c(1,3)
FY13_CtoACL<-wrangle(FY13_CtoACL,selVars=FY13selVars,sliceVars=FY13sliceVars,year=2013)
FY13_ACL<-wrangle(FY13_ACL,selVars=c(1:ncol(FY13_ACL)),sliceVars=FY13sliceVars,year=2013)
FY13_Catch<-wrangle(FY13_Catch,year=2013)
FY13_Landing<-wrangle(FY13_Landing,year=2013)
FY13_Discard<-wrangle(FY13_Discard,year=2013)

#2014
location<- c("FY14_Mults_Catch_Estimates.pdf")
FY14 <- extract_tables(location,pages=c(2:6),method="lattice")
# Convert to tibbles
FY14_CtoACL<-as_tibble(FY14[[1]])
FY14_ACL<-as_tibble(FY14[[2]])
FY14_Catch<-as_tibble(FY14[[3]])
FY14_Landing<-as_tibble(FY14[[4]])
FY14_Discard<-as_tibble(FY14[[5]])
# Wrangle
FY14selVars<-c(2,4,6:9,11:13,15:16)
FY14sliceVars<- -c(1,3)
FY14_CtoACL<-wrangle(FY14_CtoACL,sliceVars=FY14sliceVars,year=2014)
FY14_ACL<-wrangle(FY14_ACL,selVars=c(1:ncol(FY14_ACL)),sliceVars=FY14sliceVars,year=2014)
FY14_Catch<-wrangle(FY14_Catch,year=2014)
FY14_Landing<-wrangle(FY14_Landing,year=2014)
FY14_Discard<-wrangle(FY14_Discard,year=2014)

#2015
location<- c("FY15_Mults_Catch_Estimates.pdf")
FY15 <- extract_tables(location,pages=c(2:6),method="lattice")
# Convert to tibbles
FY15_CtoACL<-as_tibble(FY15[[1]])
FY15_ACL<-as_tibble(FY15[[2]])
FY15_Catch<-as_tibble(FY15[[3]])
FY15_Landing<-as_tibble(FY15[[4]])
FY15_Discard<-as_tibble(FY15[[5]])
# Wrangle
FY15selVars<-c(2,4,6:9,11:13,15:16)
FY15sliceVars<- -c(1,3)
FY15_CtoACL<-wrangle(FY15_CtoACL,sliceVars=FY15sliceVars,year=2015)
FY15_ACL<-wrangle(FY15_ACL,selVars=c(1:ncol(FY15_ACL)),sliceVars=FY15sliceVars,year=2015)
FY15_Catch<-wrangle(FY15_Catch,year=2015)
FY15_Landing<-wrangle(FY15_Landing,year=2015)
FY15_Discard<-wrangle(FY15_Discard,year=2015)

#2016
location<- c("FY16_Mults_Catch_Estimates.pdf")
FY16 <- extract_tables(location,pages=c(2:6),method="lattice")
# Convert to tibbles
FY16_CtoACL<-as_tibble(FY16[[1]])
FY16_ACL<-as_tibble(FY16[[2]])
FY16_Catch<-as_tibble(FY16[[3]])
FY16_Landing<-as_tibble(FY16[[4]])
FY16_Discard<-as_tibble(FY16[[5]])
# Wrangle
FY16selVars<-c(2,4,6:9,11:13,15:16)
FY16sliceVars<- -c(1,3)
FY16_CtoACL<-wrangle(FY16_CtoACL,sliceVars=FY16sliceVars,year=2016)
FY16_ACL<-wrangle(FY16_ACL,selVars=c(1:ncol(FY16_ACL)),sliceVars=FY16sliceVars,year=2016)
FY16_Catch<-wrangle(FY16_Catch,year=2016)
FY16_Landing<-wrangle(FY16_Landing,year=2016)
FY16_Discard<-wrangle(FY16_Discard,year=2016)

#2017
location<- c("FY17_Mults_Catch_Estimates.pdf")
FY17 <- extract_tables(location,pages=c(2:6),method="lattice")
# Convert to tibbles
FY17_CtoACL<-as_tibble(FY17[[1]])
FY17_ACL<-as_tibble(FY17[[2]])
FY17_Catch<-as_tibble(FY17[[3]])
FY17_Landing<-as_tibble(FY17[[4]])
FY17_Discard<-as_tibble(FY17[[5]])
# Wrangle
FY17_CtoACL<-wrangle(FY17_CtoACL,sliceVars=-c(1,3),year=2017)
FY17_ACL<-wrangle(FY17_ACL,selVars=c(1:ncol(FY17_ACL)),sliceVars=-c(1,3),year=2017)
FY17_Catch<-wrangle(FY17_Catch,year=2017)
FY17_Landing<-wrangle(FY17_Landing,year=2017)
FY17_Discard<-wrangle(FY17_Discard,year=2017)

##### Bind annual tables together #####

# Catch Data ####

# Rename Columns of Catch Data
names(FY10_Catch)<-names(FY11_Catch)<-names(FY12_Catch)<-
  c("Stock","Total","Commercial","Sector","Common Pool","Recreational","Herring Fishery",
    "Scallop Fishery","State Water","Other","Year")
names(FY13_Catch)<-names(FY14_Catch)<-names(FY15_Catch)<-
  names(FY16_Catch)<-names(FY17_Catch)<-
  c("Stock","Total","Commercial","Sector","Common Pool","Recreational","Herring Fishery",
    "Scallop Fishery","Small Mesh","State Water","Other","Year")

# Bind yearly tables together
Catch<-bind_rows(FY10_Catch,FY11_Catch,FY12_Catch,FY13_Catch,FY14_Catch,FY15_Catch,
                 FY16_Catch,FY17_Catch)

# Make character columns numeric
Catch[,-1]<-map(Catch[,-1], as.numeric)

# ACL Data ####

# Rename Columns of ACL Data
names(FY10_ACL)<-names(FY11_ACL)<-names(FY12_ACL)<-
  c("Stock","Total","Commercial","Sector","Common Pool","Recreational","Herring Fishery",
    "Scallop Fishery","State Water","Other","Year")
names(FY13_ACL)<-names(FY14_ACL)<-names(FY15_ACL)<-
  names(FY16_ACL)<-names(FY17_ACL)<-
  c("Stock","Total","Commercial","Sector","Common Pool","Recreational","Herring Fishery",
    "Scallop Fishery","Small Mesh","State Water","Other","Year")

# Bind yearly tables together
ACL<-bind_rows(FY10_ACL,FY11_ACL,FY12_ACL,FY13_ACL,FY14_ACL,FY15_ACL,
                 FY16_ACL,FY17_ACL)

# Make character columns numeric
ACL[,-1]<-map(ACL[,-1], as.numeric)

# CtoACL Data ####

# Rename Columns of CtoACL Data
names(FY10_CtoACL)<-names(FY11_CtoACL)<-names(FY12_CtoACL)<-
  c("Stock","Total","Commercial","Sector","Common Pool","Recreational","Herring Fishery",
    "Scallop Fishery","State Water","Other","Year")
names(FY13_CtoACL)<-names(FY14_CtoACL)<-names(FY15_CtoACL)<-
  names(FY16_CtoACL)<-names(FY17_CtoACL)<-
  c("Stock","Total","Commercial","Sector","Common Pool","Recreational","Herring Fishery",
    "Scallop Fishery","Small Mesh","State Water","Other","Year")

# Bind yearly tables together
CtoACL<-bind_rows(FY10_CtoACL,FY11_CtoACL,FY12_CtoACL,FY13_CtoACL,FY14_CtoACL,FY15_CtoACL,
               FY16_CtoACL,FY17_CtoACL)

# Make character columns numeric
CtoACL[,-1]<-map(CtoACL[,-1], as.numeric)

# Landing Data ####

# Rename Columns of Landing Data
names(FY10_Landing)<-names(FY11_Landing)<-names(FY12_Landing)<-
  c("Stock","Total","Commercial","Sector","Common Pool","Recreational","Herring Fishery",
    "Scallop Fishery","State Water","Other","Year")
names(FY13_Landing)<-names(FY14_Landing)<-names(FY15_Landing)<-
  names(FY16_Landing)<-names(FY17_Landing)<-
  c("Stock","Total","Commercial","Sector","Common Pool","Recreational","Herring Fishery",
    "Scallop Fishery","Small Mesh","State Water","Other","Year")

# Bind yearly tables together
Landing<-bind_rows(FY10_Landing,FY11_Landing,FY12_Landing,FY13_Landing,FY14_Landing,FY15_Landing,
                  FY16_Landing,FY17_Landing)

# Make character columns numeric
Landing[,-1]<-map(Landing[,-1], as.numeric)

# Discard Data ####

# Rename Columns of Discard Data
names(FY10_Discard)<-names(FY11_Discard)<-names(FY12_Discard)<-
  c("Stock","Total","Commercial","Sector","Common Pool","Recreational","Herring Fishery",
    "Scallop Fishery","State Water","Other","Year")
names(FY13_Discard)<-names(FY14_Discard)<-names(FY15_Discard)<-
  names(FY16_Discard)<-names(FY17_Discard)<-
  c("Stock","Total","Commercial","Sector","Common Pool","Recreational","Herring Fishery",
    "Scallop Fishery","Small Mesh","State Water","Other","Year")

# Bind yearly tables together
Discard<-bind_rows(FY10_Discard,FY11_Discard,FY12_Discard,FY13_Discard,FY14_Discard,FY15_Discard,
                   FY16_Discard,FY17_Discard)

# Make character columns numeric
Discard[,-1]<-map(Discard[,-1], as.numeric)

Tables<-list(Catch,ACL,CtoACL,Landing,Discard)
lables<-c("Catch","ACL","CtoACL","Landing","Discard")
for(i in 1:length(Tables)){
  Tables[[i]]<-mutate(Tables[[i]],data_type=lables[i])
}
catchHist<-bind_rows(Tables)

catchHist$Stock[which(catchHist$Stock=="SNE Winter Flounder")]<-"SNE/MA Winter Flounder"
catchHist$Stock[which(catchHist$Stock=="SNE/MA Winter Flounder*")]<-"SNE/MA Winter Flounder"

#write_csv(catchHist,"catchHist.csv")
