
## ----cast_longform_examp-------------------------------------------------
#Some long from data
long_df<-data.frame(id=c(rep(1,3),rep(2,3),rep(3,3)),
                    variable=rep(c("a","b","c"),3),
                    value=runif(9,1,10))
#cast
reshape::cast(long_df)


