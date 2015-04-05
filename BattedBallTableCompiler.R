## Batted Ball Profile Table Compiler from PitchFx data
##
## Pitch f/x data from: http://baseballsavant.com/
##
##

# Pitch f/x dataset
main <-bjaystot
# Player ID to compile data for
playid <-476270
# Years to compile data for
years <- c(2010,2011,2012,2013,2014)

for(i in years){
  toplot <-main
# subset to batted balls  
toplot <-subset(toplot, batted_ball_type!="")
# String cleaning to sort by year
toplot$tfs_zulu <- as.character(toplot$tfs_zulu)
toplot$year <- substr(toplot$tfs_zulu, 1,4)
# Subset to desired player and year
toplot <- subset( toplot, player_id== playid & year ==i )

# Determine numberss of batted ball types
fbs <- nrow(subset(toplot, batted_ball_type=="FB"))
lds <- nrow(subset(toplot, batted_ball_type=="LD"))
gbs <- nrow(subset(toplot, batted_ball_type=="GB"))
pus <- nrow(subset(toplot, batted_ball_type=="PU"))
totbb <- nrow(toplot)
# Determine number of HR
hrs <- nrow(subset(toplot, atbat_result=="Home Run"))

# Calculate %'s
ldpct <- round(lds/totbb*100, 1)
gbpct <- round(gbs/totbb*100, 1)
fbpct <- round((fbs+pus)/totbb*100, 1)
iffbpct <- round(pus/totbb*100, 1)

# Calculate ratios
gb.fb <- round(gbs/(fbs+pus),2)
hr.fb <- round(hrs/(fbs+pus)*100,1)

# Compile table
res <- c(i, totbb, ldpct, gbpct, fbpct,iffbpct, hr.fb, gb.fb)
res <- as.data.frame(t(res))
names(res) <- c("Year", "Sample Size","LDPct","GBPct","FBPct","IFFBPct","HRperFBPct", "GBperFB")
if(i == 2010){
  output <- res
}else
  output <- rbind(output,res)

}

#Same code as for loop above, but to do Total for all data, not by year
toplot <-bjaystot
toplot <-subset(toplot, batted_ball_type!="")
toplot$tfs_zulu <- as.character(toplot$tfs_zulu)
toplot$year <- substr(toplot$tfs_zulu, 1,4)
toplot <- subset( toplot, player_id== playid )

fbs <- nrow(subset(toplot, batted_ball_type=="FB"))
lds <- nrow(subset(toplot, batted_ball_type=="LD"))
gbs <- nrow(subset(toplot, batted_ball_type=="GB"))
pus <- nrow(subset(toplot, batted_ball_type=="PU"))
totbb <- nrow(toplot)

hrs <- nrow(subset(toplot, atbat_result=="Home Run"))

ldpct <- round(lds/totbb*100, 1)
gbpct <- round(gbs/totbb*100, 1)
fbpct <- round((fbs+pus)/totbb*100, 1)
iffbpct <- round(pus/totbb*100, 1)

gb.fb <- round(gbs/(fbs+pus),2)
hr.fb <- round(hrs/(fbs+pus)*100,1)

res <- c(totbb, ldpct, gbpct, fbpct,iffbpct, hr.fb, gb.fb)
res <- as.data.frame(t(res))
names(res) <- c("Sample Size","LDPct","GBPct","FBPct","IFFBPct","HRperFBPct", "GBperFB")
res$Year <- "Total"

output <- rbind(output,res)
names(output) <- c("Year", "Sample Size","LD%","GB%","FB%","IFFB%","HR/FB%", "GB/FB")
