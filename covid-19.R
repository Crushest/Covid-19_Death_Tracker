library(tidyverse)
library(janitor)
library(lubridate)
library(scales)
library(maps)

##Read all files
c2020 <- read.csv("us-counties-2020.csv")
c2021 <- read.csv("us-counties-2021.csv")
c2022 <- read.csv("us-counties-2022.csv")
cnow <- read.csv("us-counties-recent.csv")

#combine into one dataset since 
#they all have the same 6 variables
covid <- rbind(c2020,c2021,c2022,cnow)

#Fix data to work with states_map
names(covid)[3]<-paste("region")
covid[[3]] <- tolower(covid[[3]])
covid[[2]] <- tolower(covid[[2]])

#Covid map and state map
states_map <- map_data("state")
#May not work due to amount of data (depends on pc)
covid_map <- left_join(states_map,covid,by = "region") 

#ggplot map showing the amount of deaths per state
ggplot(covid_map,aes(long,lat,group=group))+
  geom_polygon(aes(fill=deaths),color="white")
  scale_fill_viridis_c(option = "C")

