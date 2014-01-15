BP = round(rnorm(100,105,7),1)
y = rbinom(100,1,.5)
BP1 = BP+y
BP2 = BP+2*y
BP3=BP+3*y
BP5=BP+5*y
BP7=BP+7*y
BP10=BP+10*y
BP15=BP+15*y


diet = ifelse(y==0,"LowFat","HiFat")

nuse = c(30,80,200)
for (iper in nuse){
df.nuse = data.frame(y,BP,BP1,BP2,BP3,BP5,BP7,BP10,BP15,diet)[1:nuse,]
write.csv(df.nuse,paste("Dietdat-",nuse,".csv",sep=""))
}


