Rprof()
# import NC SIDS data:
library(sp)
library(maptools)
fname = system.file("shapes/sids.shp", package="maptools")[1]
nc = readShapePoly(fname, proj4string=CRS("+proj=longlat +datum=NAD27"))

# reproject to UTM17, so we can use Euclidian distances:
library(rgdal)
nc = spTransform(nc, CRS("+proj=utm +zone=17 +datum=WGS84"))

# create a target (newdata) grid, and plot:
grd = spsample(nc, "regular", n = 1000)
class(grd)
plot(nc, axes = TRUE)
points(grd, pch = 3)

library(gstat)
# define variogram model FUNCTION that can deal with x and y
# being of class SpatialPolygons OR SpatialPoints:
vgm_model = function(x, y = x, vm = vgm(1, "Exp", 1e5, 0), n = 10) {
	stopifnot(is(x, "SpatialPolygons") || is(x, "SpatialPoints"))
	stopifnot(is(y, "SpatialPolygons") || is(y, "SpatialPoints"))
	nx = length(x)
	ny = length(y)
	V = matrix(NA, nx, ny)
	pb = txtProgressBar(style = 3, max = nx)
	for (i in 1:nx) {
		if (is(x, "SpatialPolygons"))
			px = spsample(x[i,], n, "regular", offset = c(.5,.5))
		else
			px = x[i,]
		for (j in 1:ny) {
			if (is(y, "SpatialPolygons"))
				py = spsample(y[j,], n, "regular", offset = c(.5,.5))
			else
				py = y[j,]
			D = spDists(px, py)
			D[D == 0] = 1e-10
			V[i,j] = mean(variogramLine(vm, dist_vector = D, covariance = TRUE))
		}
		setTxtProgressBar(pb, i)
	}
	close(pb)
	V
}

kr = krige0(SID74 ~ 1, nc, grd, vgm_model)
out = SpatialPixelsDataFrame(grd, data.frame(pred = kr))

pl0 = spplot(nc["SID74"], main = "areas")
pl1 = spplot(out, sp.layout = list("sp.polygons", nc, first=F,col='grey'), 
    main = "points on a grid")
print(pl0, split = c(1,1,1,2), more = TRUE)
print(pl1, split = c(1,2,1,2), more = FALSE)

