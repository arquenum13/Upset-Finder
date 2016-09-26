library(shiny)
library(markdown)
library(magrittr)
library(DT)
library(shinydashboard)
library(ggplot2)
library(viridis)

df <- read.csv("2015-2016_Schedule.csv", header = TRUE)
df$Date <- as.Date(gsub("/","-",as.character(df$Date)), "%m-%d-%Y")
current1 <- as.Date("2015-11-20")
week <- current1 + 7
df1 <- df[df$Date <= week & df$Date >= current1,]
h7 <- read.csv("2014-2016_Game_Results_Upset_Conf_Statistics.csv", header = T)

start <- as.POSIXct(as.Date("November 12 2016 T19:00:00", format = "%B %d %Y T%H:%M:%S"))

heater <- function(year){
  heat <- ggplot(h7[h7$SEASON==year,], aes(x=TEAM_CONF, y=OPP_CONF, fill=PERCENT)) + geom_tile(color="white", size=0.1) + 
    scale_fill_viridis(name="Upset Percentage")+ theme(axis.text.x=element_text(angle = -90, hjust = 0)) +
    labs(x="Team", y="Opponent", title=paste("Frequency of Upsets Between Conferences in", year, sep=" "))
  return(heat)
}