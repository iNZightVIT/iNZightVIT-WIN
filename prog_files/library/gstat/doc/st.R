### R code from vignette source 'st.Rnw'

###################################################
### code chunk number 1: st.Rnw:88-92
###################################################
library(spacetime)
rm(list = ls())
data(air)
ls()


###################################################
### code chunk number 2: st.Rnw:101-105
###################################################
rr = rural[,"2005::2010"]
unsel = which(apply(as(rr, "xts"), 2, function(x) all(is.na(x))))
r5to10 = rr[-unsel,]
summary(r5to10)


###################################################
### code chunk number 3: st.Rnw:109-111
###################################################
rn = row.names(r5to10@sp)[4:7]
rn


###################################################
### code chunk number 4: st.Rnw:116-121 (eval = FALSE)
###################################################
## par(mfrow=c(2,2))
## # select 4, 5, 6, 7
## for(i in rn) 
## 	acf(na.omit(r5to10[i,]), main = i)
## par(mfrow=c(1,1))


###################################################
### code chunk number 5: st.Rnw:126-131
###################################################
par(mfrow=c(2,2))
# select 4, 5, 6, 7
rn = row.names(r5to10@sp)[4:7]
for(i in rn) 
	acf(na.omit(r5to10[i,]), main = i)


###################################################
### code chunk number 6: st.Rnw:140-141 (eval = FALSE)
###################################################
## acf(na.omit(as(r5to10[rn,], "xts")))


###################################################
### code chunk number 7: st.Rnw:146-147
###################################################
acf(na.omit(as(r5to10[rn,], "xts")))


###################################################
### code chunk number 8: st.Rnw:171-172 (eval = FALSE)
###################################################
## acf(na.omit(as(r5to10[4:10,], "xts")))


###################################################
### code chunk number 9: st.Rnw:177-179
###################################################
library(sp)
print(spDists(r5to10[4:10,]@sp), digits=3)


###################################################
### code chunk number 10: st.Rnw:186-187
###################################################
rs = sample(dim(r5to10)[2], 100)


###################################################
### code chunk number 11: st.Rnw:192-194
###################################################
lst = lapply(rs, function(i) { x = r5to10[,i]; x$ti = i; x} )
pts = do.call(rbind, lst)


###################################################
### code chunk number 12: st.Rnw:197-199
###################################################
library(gstat)
v = variogram(PM10~ti, pts[!is.na(pts$PM10),], dX=0)


###################################################
### code chunk number 13: st.Rnw:202-205 (eval = FALSE)
###################################################
## plot(v, fit.variogram(v, vgm(1, "Exp", 200, 1)))
## vmod = fit.variogram(v, vgm(1, "Exp", 200, 1))
## plot(v, vmod)


###################################################
### code chunk number 14: st.Rnw:209-212
###################################################
plot(v, fit.variogram(v, vgm(1, "Exp", 200, 1)))
vmod = fit.variogram(v, vgm(1, "Exp", 200, 1))
print(plot(v, vmod))


###################################################
### code chunk number 15: st.Rnw:220-221
###################################################
vmod


###################################################
### code chunk number 16: st.Rnw:226-227
###################################################
dim(r5to10)


###################################################
### code chunk number 17: st.Rnw:232-233 (eval = FALSE)
###################################################
## vv = variogram(PM10~1, r5to10, width=20, cutoff = 200)


###################################################
### code chunk number 18: st.Rnw:238-239 (eval = FALSE)
###################################################
## vv = variogram(PM10~1, r5to10[,1:200], width=20, cutoff = 200)


###################################################
### code chunk number 19: st.Rnw:245-246
###################################################
data(vv)


###################################################
### code chunk number 20: st.Rnw:249-250
###################################################
vv <- vv[c("np", "dist", "gamma", "id", "timelag", "spacelag")]


###################################################
### code chunk number 21: st.Rnw:253-255 (eval = FALSE)
###################################################
## plot(vv, ylab = "time lag (days)")
## plot(vv, map = FALSE, ylab = "time lag (days)")


###################################################
### code chunk number 22: st.Rnw:259-261
###################################################
print(plot(vv, ylab = "time lag (days)"), split = c(1,1,1,2), more = TRUE)
print(plot(vv, map = FALSE, ylab = "time lag (days)"), split = c(1,2,1,2))


###################################################
### code chunk number 23: st.Rnw:296-301
###################################################
metricVgm <- vgmST("metric",
                   joint=vgm(50,"Exp",100,0),
                   stAni=50)

metricVgm <- fit.StVariogram(vv, metricVgm, method="L-BFGS-B")


###################################################
### code chunk number 24: st.Rnw:305-306 (eval = FALSE)
###################################################
## plot(vv, metricVgm)


###################################################
### code chunk number 25: st.Rnw:311-312
###################################################
print(plot(vv, metricVgm))


###################################################
### code chunk number 26: st.Rnw:336-343
###################################################
sepVgm <- vgmST("separable",
                space=vgm(0.9,"Exp", 123, 0.1),
                time =vgm(0.9,"Exp", 2.9, 0.1),
                sill=45)

sepVgm <- fit.StVariogram(vv, sepVgm, method = "L-BFGS-B")
plot(vv, sepVgm)


###################################################
### code chunk number 27: st.Rnw:348-349
###################################################
print(plot(vv,sepVgm))


###################################################
### code chunk number 28: st.Rnw:356-358 (eval = FALSE)
###################################################
## library(lattice)
## plot(vv,wireframe=T,col.regions=bpy.colors())


###################################################
### code chunk number 29: st.Rnw:363-365
###################################################
library(lattice)
print(plot(vv,wireframe=T,col.regions=bpy.colors()))


###################################################
### code chunk number 30: st.Rnw:388-389 (eval = FALSE)
###################################################
## demo(gstat3D)


