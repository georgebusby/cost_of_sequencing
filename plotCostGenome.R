## PLOT COST OF GENOME SEQUENCING FROM US GOV DATA ##




x <- read.csv("sequencing_costs_table_july_2017.csv", header = T)

x$Date <- as.character(x$Date)
x$Cost.per.Mb <- as.numeric(gsub("\\,","",gsub("\\$","",x$Cost.per.Mb)))
x$Cost.per.Genome  <- as.numeric(gsub("\\,","",gsub("\\$","",x$Cost.per.Genome)))



plot(x$Date,x$Cost.per.Mb)

new.date <- c()
new.year <- c()
for(i in x$Date){
  mth <- which(month.abb%in%strsplit(i,split = "\\-")[[1]][1])
  year <- 2000 + as.numeric(strsplit(i,split = "\\-")[[1]][2])
  new.date <- c(new.date,as.Date(paste("1",mth,year, sep="/"),format = "%d/%m/%Y"))
  new.year <- c(new.year,year)
}


new.costs <- log(x$Cost.per.Genome)
costs.y <- pretty(range(new.costs))
costs <- range(x$Cost.per.Genome)


png("crashingSequencingCosts.png",
    width = 1500, height = 800, res = 150)
plot(as.Date(new.date,origin = "1970-01-01"),new.costs, log = "y",
     type = "n", col = "blue", lwd = 2, axes = "F",
     xlab = "Year",
     ylab = "Cost per genome ($)"
     )
box()
xat <- c()
years <- (2000:2018)
for(i in years){
  abline(v=as.Date(paste("01/01",i,sep = "/"),format = "%d/%m/%Y"),lwd = 0.5, col = "grey60")
  xat <- c(xat,as.Date(paste("01/06",i,sep = "/"),format = "%d/%m/%Y"))
}
axis(1,at = xat,labels = years, lwd = 0, cex.axis = 0.8)  
  

aty <- axTicks(2)
labsy <- paste0(pretty(costs/1000000),"M")
labsy[1] <- "1K"
axis(2, las = 2, at = c(0,aty), labels = c("",labsy))
abline(h = aty, lwd = 0.5, lty = 2)


points(as.Date(new.date,origin = "1970-01-01"),
       new.costs, lwd = 2)
points(as.Date(new.date,origin = "1970-01-01"),
       new.costs, col = "blue", lwd = 2,
       type = "l")

mtext(1,adj = 1, text = "Source: https://www.genome.gov/27541954/dna-sequencing-costs-data/",
      line = 4, cex = 0.8)

dev.off()