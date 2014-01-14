
# Experimenting with kernel density test
# http://www.mvstat.net/tduong/research/publications/duong-et-al-2012-pnas.pdf
# http://www.inside-r.org/packages/cran/ks/

#install.packages("ks")
library(ks)

setwd("~/mapping/projects/blog_kde_test/R")
#load(kde_test.RData

d1 = read.csv("crime_2013_02.csv") # Crime data from feb 2013
d2 = read.csv("crime_2013_03.csv") # Crime data from march 2013

#plot (x=d1$EASTING, y=d1$NORTHING, type='p')
#points(x=d2$EASTING, y=d2$NORTHING, type='p', col='blue')

# Temporarily only use first 10,000 points
#d1 <- d1[1:1000,]
#d2 <- d2[1:1000,]



d1.kde <- kde(x=d1[,2:3]) # (ignoring first colum which has object ID)
d2.kde <- kde(x=d2[,2:3]) # (ignoring first colum which has object ID)

# Make a plot of the crime densities

par(mfrow=c(1,1))
par(cex=0.5)

pdf("kde_2013_02.pdf")
plot(d1.kde, main="Feb 2013", width=18, height=15)
dev.off()

pdf("kde_2013_03.pdf")
plot(d2.kde, main="Mar 2013", width=18, height=15)
dev.off()


# Test the difference between the two

test.check <- kde.test( x1=d1, x2=d1) # Sanity check - test two identical kdes
test <- kde.test( x1=d1, x2=d2) # The proper test

save.image("~/mapping/projects/blog_kde_test/R/kde_test.RData")

test.check

test

