library(datasets)
data <- iris
head(data)

ggplot(data,aes(x=Petal.Width,y=Sepal.Length))+
  geom_smooth(method='lm',size=.8)+
  geom_point()+
  scale_shape_manual(values = 1:3)+
  labs(x='Petal width (cm)',y='Sepal length (cm)',
       title='Relationship between petal width and sepal length for the genus Iris',
       subtitle='Petal and sepal measurements for three species',
       caption=expression(paste('Source: ',
                                italic(iris),
                                ' dataset from the ',
                                italic(datasets),
                                ' package')))+
  cowplot::theme_cowplot()+
  theme(panel.grid.major = element_line(color='lightgray',
                                        size=.5,
                                        linetype='dashed'))+
  facet_wrap(~Species,scales='free_x')
