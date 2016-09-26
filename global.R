library(shiny)
library(markdown)
library(magrittr)
library(DT)
library(shinydashboard)

df <- read.csv("2015-2016_Schedule.csv", header = TRUE)
df$Date <- as.Date(gsub("/","-",as.character(df$Date)), "%m-%d-%Y")
current1 <- as.Date("2015-11-20")
week <- current1 + 7
df1 <- df[df$Date <= week & df$Date >= current1,]