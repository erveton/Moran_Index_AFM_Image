# setwd('your_address')
library(spdep) # for Moran's Index

# lets generate our height matrix
L = 256

#Access the Height Matrix of the AFM image

image1<-read.table(file = "sample.txt")
x1<-image1[1]
x=x1[[1]]
x_mat   = matrix(x, nrow = L, ncol = 1)
y1<-image1[2]
y=y1[[1]]
y_mat = matrix(y, nrow = 1, ncol = L)
z1<- image1[3]
z_vec = z1[[1]]

pdf('Correlogram.pdf')

# lets see our pretty image
z_mat = matrix(z_vec, nrow=L, ncol=L)

image(z_mat)

# Now lets compute MORAN

# empty matrix and spatial coordinates of its cells
my.mat  = matrix(NA, nrow=L, ncol=L)
x.coord = rep(1:L, each=L)
y.coord = rep(1:L, times=L)
xy      = data.frame(x.coord, y.coord)


# 'nb' - neighbourhood of each cell
#r.nb = dnearneigh(as.matrix(xy), d1=0.5, d2=1.5)
# 'nb' - an alternative way to specify the neighbourhood
r.nb = cell2nb(nrow=L, ncol=L, type="queen")
sp.cor = sp.correlogram(r.nb, z_vec, order=5,
                        method="I", randomisation=FALSE)


sp.cor[[1]]

write.table(sp.cor[[1]], "Moran.txt", row.names = FALSE)

plot( sp.cor, ylim=c(-1,1), main='Moran Correlogram using spdep package')
#  Moran’s values close to +1 indicate clustering 
#  while values close to -1 indicate dispersion.
# lag = distance

dev.off()
