## I'M EXPERIMENTING WITH PLOTTING DATA FROM BHATT ET AL 2015 NATURE
## I DOWNLOADED DATA FROM www.map.zoo.ox.ac.uk

library(raster)
library(maps)  
library(geosphere)  
library(plotKML)
library(rgdal)
library(grid)
library(gridBase)
library(sp)
library(maptools)
library(rgeos)
library(countrycode)
source("~/R/Copy/Rprojects/AfricaPOPGEN/functions/makeTransparent.R")



##############################################################
## get prevalence rastter
raster_file <- "~/repos/anopheles/data/bhatt2015_meanrasters/MODEL43.2015.PR.rmean.stable.tif" 
#  raster_file <- "~/repos/anopheles/data/bhatt2015_meanrasters/MODEL43.2015.inc.rate.PR.rmean.stable.tif"
x <- raster(raster_file)
x <- setMinMax(x)

## plot positioning
first_plot_x1 <- 0
first_plot_x2 <- 1
first_plot_y1 <- 0
first_plot_y2 <- 1
first_xlim <- c(-20.000000, 50.000000)  
first_ylim <- c(-50.000000, 30.000000)


n_cols <- 20
alpha <- 0.5
para_plot_cols <- c(topo.colors(n_cols, alpha) ) #, rev(heat.colors(n_cols,alpha)))


png(paste0("AfricaPfPR2015.png"),
    height=600,width=600, res=150)
## plot main map

##############################################################
## plot main map with pfpr
par(fig=c(first_plot_x1,first_plot_x2,first_plot_y1,first_plot_y2),
    mar=c(0,0,0,0),bg=NA)
map1 <- map("world", col=c("grey"), fill=T, bg="white", lwd=0.0001, xlim = first_xlim, ylim= first_ylim)

plot(x,add = T, col = para_plot_cols, legend=F, axes = F)
par(fig=c(first_plot_x1,first_plot_x2,first_plot_y1,first_plot_y2),
    mar=c(0,0,0,0),bg=NA)
map("world", col=c("grey60"), fill=F, lwd=1, xlim=first_xlim, ylim=first_ylim, add=T)  

mtext(1,text = "Source: Bhatt et al 2015", line = -1, cex = 0.5, adj =1)


par(fig=c(first_plot_x1,first_plot_x2,first_plot_y1,first_plot_y2), new = T,bg=NA)
x.range <- c(minValue(x), maxValue(x))
# n_cols <- 20
# alpha <- 0.5
# plot_cols <- c(topo.colors(n_cols, alpha)) #, rev(heat.colors(n_cols,alpha)))
plot(x, legend.only=TRUE, col=para_plot_cols,
     legend.width=1, legend.shrink=0.75, horizontal = T,
     #smallplot=c(0.85,0.9, 0.7,0.9)); par(mar = par("mar"),
     axis.args=list(at=seq(x.range[1], x.range[2], 0.1),
                    labels=seq(x.range[1], x.range[2], 0.1)*100,
                    cex.axis=0.5),
     legend.args=list(text='Malaria prevalence 2015 [PfPR (%)]', side=3, font=1, line=0, cex=0.5, las=1, adj=0.5))


dev.off()
