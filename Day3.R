#Day3:23-02-2020

#Missing Values ----
#na.rm = T

(x=c(1,2,4,5))
sum(x)
#(x2=c(1,2,,4,5))
(x2=c(1,2,NA,4,NA,5))
sum(x2, na.rm=T)
?sum
length(x2)
is.na(x2)
sum(is.na(x2))
sum(is.na(x2))/length(x2) # %age og missing values
mean(x2, na.rm=T)
x2[is.na(x2)]
x2[is.na(x2)] = mean(x2, na.rm=T)
x2

library(VIM)
data(sleep)
