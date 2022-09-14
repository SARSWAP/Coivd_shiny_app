library(dplyr)
library(ggplot2)
library(lubridate)

covid <- read.csv("https://covid.ourworldindata.org/data/owid-covid-data.csv")
india <- covid %>% filter(location=='India')%>%  
  select(location,date,new_cases,new_deaths,new_vaccinations_smoothed)%>%  
  mutate(date=as_date(date),year=year(date),month=month(date,label = TRUE)) %>%
  filter(year=='2022') %>% 
  arrange(month,new_cases,new_deaths)

casevdeath_plot_IN <- ggplot(india,aes(x=date)) +
  geom_line(aes(y = new_cases/2,color='New Cases')) +
  labs(y='New Cases',x='Months') +
  geom_line(aes(y = new_deaths/0.025,color='Deaths')) +
  scale_x_date(date_breaks = "1 month",date_labels = "%b") +
  scale_y_continuous(sec.axis = sec_axis(~.*0.025, name = "Deaths")) +
  theme_light() +
  theme(legend.position="bottom",plot.title = element_text(hjust = 0.5)) +
  scale_color_manual(name="Covid Cases",
                     values =  c("steelblue","darkred"),breaks = c("New Cases", "Deaths")) +
  ggtitle("Covid-19 New Cases vs Deaths in India")

vaccination_plot <- ggplot(india,aes(x=date)) + 
  geom_line(aes(y = new_vaccinations_smoothed,color='New vaccinations')) +
  labs(y='New Vaccinations',x='Months') +
  scale_x_date(date_breaks = "1 month",date_labels = "%b") +
  theme_light() +
  theme(legend.position="bottom",plot.title = element_text(hjust = 0.5)) +
  scale_color_manual(name="Vaccinations",values =  c("steelblue"),breaks = c("New vaccinations")) +
  ggtitle("Vaccinations in India")

rm(india)

World <- covid %>% filter(location=='World')%>%  
  select(location,date,new_cases,new_deaths,new_vaccinations_smoothed)%>%  
  mutate(date=as_date(date),year=year(date),month=month(date,label = TRUE)) %>%
  filter(year=='2022') %>% 
  arrange(month,new_cases,new_deaths)

casevdeath_plot_W <- ggplot(World,aes(x=date)) +
  geom_line(aes(y = new_cases/2,color='New Cases')) +
  labs(y='New Cases',x='Months') +
  geom_line(aes(y = new_deaths/0.025,color='Deaths')) +
  scale_x_date(date_breaks = "1 month",date_labels = "%b") +
  scale_y_continuous(sec.axis = sec_axis(~.*0.025, name = "Deaths")) +
  theme_light() +
  theme(legend.position="bottom",plot.title = element_text(hjust = 0.5)) +
  scale_color_manual(name="Covid Cases",
                     values =  c("steelblue","darkred"),breaks = c("New Cases", "Deaths")) +
  ggtitle("Covid-19 New Cases vs Deaths in World")

vaccination_plot_W <- ggplot(World,aes(x=date)) + 
  geom_line(aes(y = new_vaccinations_smoothed,color='New vaccinations')) +
  labs(y='New Cases',x='Months') +
  scale_x_date(date_breaks = "1 month",date_labels = "%b") +
  theme_light() +
  theme(legend.position="bottom",plot.title = element_text(hjust = 0.5)) +
  scale_color_manual(name="Vaccinations",values =  c("steelblue"),breaks = c("New vaccinations")) +
  ggtitle("Vacinations around the world")

rm(World)
rm(covid)