# Load packages
library(ggplot2)
library(datasets)
# Load data
data <- Orange
head(data)
# Plotting
ggplot(data,aes(x=age,y=circumference,linetype=Tree,shape=Tree))+
  geom_point()+
  geom_line()+
  scale_linetype(name='Tree',breaks=1:5)+
  scale_shape(name='Tree',breaks=1:5)+
  scale_x_continuous(limits=c(0,1700),
                              expand=c(0,0))+
  scale_y_continuous(limits=c(0,240),
                              expand=c(0,0),
                              breaks=seq(0,240,40))+
  labs(x='Age (days)',y='Circumference at breast height (mm)',
       title='Growth of orange trees',
       subtitle='Circumference increase over 1600 days',
       caption=expression(paste(italic(Orange),
                                ' dataset from the ',
                                italic(datasets),
                                ' package')))
