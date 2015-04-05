## Plots hitter spray charts over Rogers Center Field dimension
##
## Rogers center field image: http://mlb.mlb.com/images/gameday/fields/svg/14.svg
##
## Pitch F/x data taken from : http://baseballsavant.com/
##


library(ggplot2)

# Pitch f/x data set to plot
toplot <-bjaystot
# Subset to just batted balls
toplot <-subset(toplot, batted_ball_type!="")
# String cleaning to filter by year
toplot$tfs_zulu <- as.character(toplot$tfs_zulu)
toplot$year <- substr(toplot$tfs_zulu, 1,4)
# Subset by year and playerid
toplot <- subset( toplot, player_id==476270 & year %in% c(2014) )

ggplot( toplot
        , aes(hc_x-128, -hc_y+200)) + # adjusts axis system
  coord_equal()+
  annotation_raster(rogers, -137,132,-40,235)+ # adds and positions field image
  geom_point(aes(color=atbat_result), size=2.5) + # colors points by at bat result
  xlim(-120, 120)+
  ylim(-25, 195)+
  theme(axis.ticks = element_blank(), axis.text.x = element_blank(), 
        axis.text.y = element_blank(), axis.title.x=element_blank(),
        axis.title.y=element_blank(),plot.title=element_text(size=20, face="bold"),
        legend.text = element_text(colour="black", size = 14),
        legend.title = element_text(size=17),
        strip.text.x = element_text(size = 16))+
  scale_color_discrete(name="Batted Ball Result")+
  labs(title= "Steve Tolleson 2014\n(Sample Size = 126)")

  
