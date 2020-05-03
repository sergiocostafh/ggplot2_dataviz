# Load packages
library(ggplot2)
library(sf)
# Load shapefiles
br_mun <- read_sf('./shapefile','br_municipios')
br_est <- read_sf('./shapefile','br_estados')
plot(br_mun)
head(br_mun)
plot(br_est)
head(br_est)
# Setting population density classes
br_mun$DensClass <- cut(br_mun$DensPop,breaks=c(0,5,50,500,5000,Inf),
                        labels=c('< 5','5-50','50-500','500-5.000','> 5.000'))
# Plotting
ggplot()+
  geom_sf(aes(fill=DensClass),color='transparent',data=br_mun)+
  geom_sf(fill='transparent',color='white',data=br_est)+
  scale_fill_viridis_d(name='Inhab/km²',
                       guide=guide_legend(
                         direction='horizontal',
                         title.position='top',
                         title.hjust = .5,
                         label.hjust = .5,
                         label.position = 'bottom',
                         keywidth = 3,
                         keyheight = .5
                       ))+
  labs(title="Brazil's demographics",
       subtitle='Population density',
       caption=c('Source: IBGE - Censo demográfico, 2010'))+
  theme_void()+
  theme(title=element_text(face='bold'),
        legend.position = 'bottom')
