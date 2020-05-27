# Load packages
library(ggplot2)
library(tidyverse)
# Load data
url <- 'https://www.populationpyramid.net/api/pp/76/2019/?csv=true'
data <- read.csv(url)
head(data)
# Manipulating data
data <- data%>%
  gather('Gender','Population',2:3)%>%
  mutate(PopPerc=case_when(Gender=='M'~round(Population/sum(Population)*100,2),
                           TRUE~-round(Population/sum(Population)*100,2)),
         signal=case_when(Gender=='M'~1,
                          TRUE~-1))
head(data)
levels(data$Age)
data$Age <- factor(data$Age,levels=unique(data$Age),ordered=TRUE)
# Plotting
ggplot(data)+
  geom_bar(aes(x=Age,y=PopPerc,fill=Gender),stat='identity')+
  geom_text(aes(x=Age,y=PopPerc+signal*.3,label=abs(PopPerc)))+
  coord_flip()+
  scale_fill_manual(name='',values=c('darkred','steelblue'))+
  scale_y_continuous(breaks=seq(-10,10,1),
                     labels=function(x){paste(abs(x),'%')})+
  labs(x='',y='Population (%)',
       title='Population Pyramid of Brazil',
       subtitle=paste('Total resident population in 2019:', format(sum(data$Population),big.mark='.')),
       caption='Source: PopulationPyramid.net')+
  cowplot::theme_cowplot()+
  theme(axis.text.x=element_text(vjust=.5),
        panel.grid.major.y = element_line(color='lightgray',linetype='dashed'),
        legend.position = 'top',
        legend.justification = 'center')
