
## FNN local prediction
########################
library(sp)
library(spacetime)
library(gstat)

# create n space-time points over [0,1] x [0,1] x [Now, Now+some days]
t0 = Sys.time() # now
n = 10000
set.seed(13131) # fix outcomes
x = runif(n)
y = runif(n)
t = t0 + 1e6 * runif(n)
z = rnorm(n)
stidf = STIDF(SpatialPoints(cbind(x,y)),sort(t),data.frame(z=z))
stsdf = as(stidf,"STSDF")
str(stsdf)

# create a regular 20 x 20 x 10 grid of prediction locations:
grd = as(SpatialGrid(GridTopology(c(0.025,0.025), c(.05, .05), c(20,20))), "SpatialPixels")
tgrd = seq(min(t), max(t), length.out = 10)
stf = STF(grd, tgrd)

# define a variogram model
sumMetricModel <- vgmST("sumMetric",
                        space=vgm(0, "Exp", 1),
                        time =vgm(0, "Exp",  1),
                        joint=vgm(0.8, "Exp", 1, 0.2),
                        stAni=1/1e6)


# find neighbours using FNN
library(FNN)
df = as(stsdf, "data.frame")[c("x","y","time")]
df$time = as.numeric(df$time)*sumMetricModel$stAni
summary(df)

query = as(stf, "data.frame")[c("s1", "s2", "time")]
query$time = as.numeric(query$time)*sumMetricModel$stAni
summary(query)

nb = get.knnx(as.matrix(df), as.matrix(query), 50)[[1]]

sti <- as(stf, "STI")

# do the kriging
out = sapply(1:prod(dim(stf)), function(x) {
  data =  stsdf[stsdf@index[nb[x,],]]
  krigeST(z~1, data, sti[x,], sumMetricModel)$var1.pred
})

# plot the results
kr <- STFDF(stf@sp, stf@time, data.frame(pred=out))
stplot(kr, col.regions=bpy.colors(),scales=list(draw=T))