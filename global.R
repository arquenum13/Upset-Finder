library(shiny)
library(markdown)
library(magrittr)
library(DT)
library(shinydashboard)
library(ggplot2)
library(viridis)
library(scatterD3)
library(metricsgraphics)
library(ggvis)

options(warn=-1)
#options(warn=0)

df <- read.csv("2015-2016_Schedule_Favored.csv", header = TRUE)
df$Date <- as.Date(gsub("/","-",as.character(df$Date)), "%m-%d-%Y")
current1 <- as.Date("2015-11-20")
week <- current1 + 7
df1 <- df[df$Date <= week & df$Date >= current1,]
#h7 <- read.csv("2014-2016_Game_Results_Upset_Conf_Statistics.csv", header = T)

start <- as.POSIXct(as.Date("November 12 2016 T19:00:00", format = "%B %d %Y T%H:%M:%S"))

all_Data <- read.csv("2016_STATS_PROB_v2.csv", header = TRUE)
#all_Data <- all_Data[all_Data$ORPG > 0,]# | all_Data$ELO_DIFF < 0,]
#all_Data <- all_Data[all_Data$ELO_DIFF < 0,]
conferences <- levels(all_Data$CONFERENCE)
teams <- c("All",levels(all_Data$TEAM))

df2 <- read.csv("NCAA_Tournament_History_Prob.csv", header = TRUE)
df2$ROUND <- factor(df2$ROUND, levels = df2$ROUND)

#heater <- function(year){
#  heat <- ggplot(h7[h7$SEASON==year,], aes(x=TEAM_CONF, y=OPP_CONF, fill=PERCENT)) + geom_tile(color="white", size=0.1) + 
#    scale_fill_viridis(name="Upset Percentage")+ theme(axis.text.x=element_text(angle = -90, hjust = 0)) +
#    labs(x="Team", y="Opponent", title=paste("Frequency of Upsets Between Conferences in", year, sep=" "))
#  return(heat)
#}

scoreSys <- data.frame(Site=c("ESPN","Yahoo","CBS","FoxSports","NCAA"), Round1=c(10,1,1,1,1), Round2=c(20,2,2,2,2), 
                       Sweet16=c(40,4,4,4,4), Elite8=c(80,8,8,8,8), Final4=c(160,16,16,16,16), Championship=c(320,32,32,32,32))
mdl <- read.csv("models.csv", header = TRUE)

feats <- read.csv("FeatureTable.csv", header = FALSE)
