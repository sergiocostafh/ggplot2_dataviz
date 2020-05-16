# Load packages
library(ggplot2)
library(raster)
library(tidyr)
# Load data
climate=getData('worldclim', var='bio',res=2.5)
climate <- crop(climate,extent(-82,-34,-60,15))
raster <- climate$bio12
samerica <- rnaturalearth::ne_countries(continent = 'south america', returnclass = "sf")
plot(samerica)
# Manipulating data
rasdf <- as.data.frame(raster,xy=TRUE)%>%drop_na()
head(rasdf)
# Plotting
ggplot()+
  geom_raster(aes(x=x,y=y,fill=bio12),data=rasdf)+
  geom_sf(fill='transparent',data=samerica)+
  scale_fill_viridis_c('mm/yr',direction = -1)+
  coord_sf(expand=c(0,0))+
  labs(x='Longitude',y='Latitude',
       title="South America's climate map",
       subtitle='Annual precipitation',
       caption='Source: WorldClim, 2020')+
  cowplot::theme_cowplot()+
  theme(panel.grid.major = element_line(color = gray(.5),
                                        linetype = 'dashed',
                                        size = 0.5),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(fill=NA,color = 'black'),
        panel.ontop = TRUE)
