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
sleep
dim(sleep)
head(sleep)
tail(sleep)
?sleep
sum(is.na(sleep))
colSums(is.na(sleep))
rowSums(is.na(sleep))
complete.cases(sleep) #which rows are complete
sum(complete.cases(sleep))
sleep[complete.cases(sleep),]
sleep[!complete.cases(sleep),]

(x=200:300)
quantile(x)
quantile(x, seq(0,1,.25))

library(dplyr)

xy = colSums(is.na(sleep))
xy[xy>0]
c1 <- names(xy[xy>0])
sleep[ , c1]
sleep %>% select(c1) %>%length()
sleep %>% select(-c1) %>%length()
'%notin%' <- Negate('%in%')
c2 <- names(sleep) %notin% c1
sleep[ , c2]

#data partitioning----
(x = 1:100)
(x = trunc(rnorm(100, mean=60, sd = 15)))
set.seed(134)
s1 <- sample(x, size = 70)
length(s1)
s2 <- sample(x, size = .7 * length(x))
length(s2)
x
library(dplyr)
mtcars
mtcars %>% sample_n(24)
mtcars %>% sample_frac(.7)
dim(mtcars)
(index = sample(1:nrow(mtcars), size = .7*nrow(mtcars)))
mtcars = index
dim(mtcars[index, ])
mtcars[ -index, ]

library(caTools)
#install rpart, rpart.plot, catools, caret, arules, arulesviz, factorxtra, dendextend, NbClust,  cluster, fpc, amap, animation

pinstall <- c('rpart', 'rpart.plot', 'caTools', 'caret', 'arules', 'arulesViz', 'factoextra', 'dendextend', 'NbClust',  'cluster', 'fpc', 'amap', 'animation')

install.packages(pinstall)

pinstall1 <- c('gsheet', )

#pinstall <- c('rpart','rpart.plot', 'caTools', 'caret','arules','arulesViz', 'factoextra', 'dendextend','NbClust', 'cluster','fpc', 'amap','animation',

pinstall1 <- c( 'readxl', 'rJava', 'xlsx','wordcloud', 'wordcloud2', 'modeest','fdth','e1071' )
tspackages <- c('timeSeries','xts','zoo','forecast','TTR','quantmod', 'lubridate','smooth','Mcomp')
tmpackages <- c('rtweet',"curl", 'twitteR', 'ROAuth', 'syuzhet')
lppackages <- c('lpSolve', 'linprog', 'lpSolveAPI')

install.packages(lppackages)

#Multiple Install
list.of.packages <- plist #substitute plist with name of list of packages
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#load if avl, install if not avl---
#Load if available, install packages if not available in the system & then load
if (!require("quantmod")) {
  install.packages("quantmod")
  library(quantmod)
}


#Data Patition-------

library(caTools)
data(mtcars)
sample = sample.split(Y=mtcars$am, SplitRatio = .70)
sample
table(sample)
prop.table(table(sample))
(y1 = mtcars[sample == T, ]) #True Set
(y2 = mtcars[sample == F, ]) #False Set
table(y1$am) ; prop.table(table(y1$am))
table(y2$am) ; prop.table(table(y2$am))


library(caret)
(intrain <- createDataPartition(y = mtcars$am, p =.7, list=F))
train<-mtcars[intrain, ]
test<-mtcars[-intrain, ]
prop.table(table(train$am)) ; prop.table(table(test$am))


women
head(women)
model = lm(weight ~ height, data = women)
summary(model)
#y = mx+c
#weight = 3.45*height - 87
plot(x=women$height, y = women$weight)
abline(model, col=2)
residuals(model)
women$weight
predwt <- predict(model, newdata = women, type ='response')
head(women)
3.45*58-87
cbind(women,predwt, res = women$weight - predwt, res2 = residuals(model))
summary(model)
sqrt(sum(residuals(model)^2)) #SSE

range(women$height)
(ndata = data.frame(height=c(66.5, 75.8)))
predict(model, newdata=ndata, type='response')
confint(model)

#case2 : LR ---------
library(gsheet)
link= "https://docs.google.com/spreadsheets/d/1h7HU0X_Q4T5h5D1Q36qoK40Tplz94x_HZYHOJJC_edU/edit#gid=2023826519"
df = as.data.frame(gsheet2tbl(link))
head(df)
model2 = lm(Y ~ X, data = df)
summary(model2)
plot(df$X, df$Y)
abline(model2, col=2)
residuals(model2)

predwt <- predict(model2, newdata = df, type ='response')
head(df)
cbind(df,predwt, res = df$Y - predwt, res2 = residuals(model2))
summary(model)
sqrt(sum(residuals(model)^2)) #SSE
ndata2 = data.frame(X=c(3,4))
predict(model2, newdata=ndata2, type='response')

#Assumptions----
plot(model)

#Multiple Regression
#Adjusted R-squared = 0.7421 74% of variation is due to pricing and promotion 

link2 = "https://docs.google.com/spreadsheets/d/1h7HU0X_Q4T5h5D1Q36qoK40Tplz94x_HZYHOJJC_edU/edit#gid=1595306231"
df2 = as.data.frame(gsheet2tbl(link2))
model3 = lm(sqty ~ price+promotion, data = df2)
summary(model3) #will predict within the range- can only interpolate not extrapolate - Time series can extrapolate
range(df2$price)
range(df2$promotion)
plot(df2$price, df2$sqty)
abline(model3, col=2)
plot(df2$promotion, df2$sqty)
abline(model3, col=2)
abline(model3, col=2)
residuals(model2)
(ndata3 = data.frame(price=c(60,75),promotion = c(300,500)))
predict(model3, newdata=ndata3, type='response')
?predict
plot(model3)


#Decision Tree


# Decision Tree - Classification
#we want predict for combination of input variables, is a person likely to survive or not

#import data from online site
path = 'https://raw.githubusercontent.com/DUanalytics/datasets/master/csv/titanic_train.csv'
titanic <- read.csv(path)
head(titanic)
names(titanic)
data = titanic[,c(2,3,5,6,7)]  #select few columns only
head(data)
dim(data)
#load libraries
library(rpart)
library(rpart.plot)
str(data)
#Decision Tree
names(data)
table(data$Survived)
prop.table(table(data$Survived))
str(data)
data$Pclass = factor(data$Pclass)
fit <- rpart(Survived ~ ., data = data, method = 'class') # . other than survived "method = class for dicrete" method= annova for continous"
fit
rpart.plot(fit, extra = 104, cex=.8,nn=T)  #plot
head(data) ##nn - node number, cp - complexity parameter
printcp(fit) #select complexity parameter 
prunetree2 = prune(fit, cp=.018) #select the value of cp where error is the least
rpart.plot(prunetree2, cex=.8,nn=T, extra=104)
prunetree2
nrow(data)
table(data$Survived)
# predict for Female, pclass=3, siblings=2, what is the chance of survival

#Predict class category or probabilities
library(dplyr)
(testdata = sample_n(data,2))
predict(prunetree2, newdata=testdata, type='class')
predict(prunetree2, newdata=testdata, type='prob')
str(data)
testdata2 = data.frame(Pclass=factor(2), Sex=factor('male'), Age=15, SibSp=2)
testdata2
predict(prunetree2, newdata = testdata2, type='class')
predict(prunetree2, newdata = testdata2, type='prob')

#Use decision trees for predicting
#customer is likely to buy a product or not with probabilities
#customer is likely to default on payment or not with probabilities
#Student is likely to get selected, cricket team likely to win etc

#Imp steps
#select columns for prediction
#load libraries, create model y ~ x1 + x2 
#prune the tree with cp value
#plot the graph
#predict for new cases

#rpart, CART, classification model
#regression decision = predict numerical value eg sales
© 2020 GitHub, Inc.
Terms
Privacy
Security
Status
Help
Contact GitHub
Pricing
API
Training
Blog
About



