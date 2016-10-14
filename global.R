library(shiny)
library(markdown)
library(magrittr)
library(DT)
library(shinydashboard)
#library(ggplot2)
library(viridis)
library(scatterD3)
library(metricsgraphics)
library(ggvis)

options(warn=-1)

df <- read.csv("Data/2015-2016_Schedule_Favored.csv", header = TRUE)
df$Date <- as.Date(gsub("/","-",as.character(df$Date)), "%m-%d-%Y")
current1 <- as.Date("2015-11-20")
week <- current1 + 7
df1 <- df[df$Date <= week & df$Date >= current1,]

start <- as.POSIXct(as.Date("November 12 2016 T19:00:00", format = "%B %d %Y T%H:%M:%S"))

all_Data <- read.csv("Data/2016_STATS_PROB_v2.csv", header = TRUE)
conferences <- levels(all_Data$CONFERENCE)
teams <- c("All",levels(all_Data$TEAM))

df2 <- read.csv("Data/NCAA_Tournament_History_Prob.csv", header = TRUE)
df2$ROUND <- factor(df2$ROUND, levels = df2$ROUND)

scoreSys <- data.frame(Site=c("ESPN","Yahoo","CBS","FoxSports","NCAA"), Round1=c(10,1,1,1,1), Round2=c(20,2,2,2,2), 
                       Sweet16=c(40,4,4,4,4), Elite8=c(80,8,8,8,8), Final4=c(160,16,16,16,16), Championship=c(320,32,32,32,32))
mdl <- read.csv("Data/models.csv", header = TRUE)

feats <- read.csv("Data/FeatureTable.csv", header = FALSE)
