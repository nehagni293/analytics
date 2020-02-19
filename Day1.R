#IIMLN
#Day1

mtcars
?mtcars #help on mtcars
class(mtcars) #type of dataset
x= 1:5
class(x)
x
str(mtcars)
?str(mtcars)
y=c(1,3.5,5)
class(y)
z=c(1L, 3L, 5L)
class(z)
y
as.integer(y)
class(as.integer(y)) #type conversion
summary(mtcars)

#vectors----
#basic dataset - single dimension one datatype only
x=1:5
x
x1 = c(1,2,3,4,5) #c - concatenates
x1
x-1:10
(x3 = c(2,4,36,3))
x3
print(x3)
x3[2] #print 2nd position
(x4 = rnorm(n=100, mean = 60, sd=10))
plot(x4)
plot(density(x4))
hist(x4) #histogram - continous values
hist(x4, breaks=10, col = 1:10)
range(x4)
min(x4); max(x4) 
mean(x4)
median(x4)
boxplot(x4)
sort(x4, decreasing = T)
plot(sort(x4), type='b') #l- line; b- (both)line+point
plot(x4, type='l')
x4[x4>65]
mean(x4[x4>65]) #mean of values more than 65
x4[-c(1:10)]
x4>65 #True False
x4[x4>65]  #Prints values greater than 64
length(x4[x4>65])
sum(x4[x4>65])
x4[x4>65 && x4<70]
rev(x4) #reverses the original seq of data
?sum

plot(women) #not a vector
#


#matrices----
(data=c(10,30,50,70,90,110))
(m1 = matrix(data = data, nrow=2)) # data gets filled column-wise
(m2 = matrix(data = data, nrow=2, byrow = T)) #row-wise
#dimnames(m1) = c(list('R1','R2'), list('C1','C2','C3'))
rownames(m1) = c('R1','R2')
colnames(m1) = c('C1','C2','C3')
m1
m1[1,]
m1['R1',]
m1[,'C3']
m1[,2:3]
m1[, c('C1','C3')]
colSums(m1)
rowSums(m1)
rowMeans(m2)
colMeans(m2)
apply(m1,1,FUN=min) # 1 - rows
apply(m1,2,FUN=max) # 1 - col
max(m1); min(m1)
apply(m1[, 'C2', drop=F], 2, FUN=max)
#array - multidimension matrix

#dataframes----
(rollno = paste('IIMLN', 1:13, sep='-'))
(name = paste('student',1:13, sep=' & '))
(age = round(runif(13, min=24, max=32),2))
(marks = trunc(rnorm(13, mean=60,sd=10)))
set.seed(1234) #set the pattern
(gender = sample(c('M','F'),size=13,replace=T, prob=c(.7,.3)))
table(gender) #summarises the count of M & F
prop.table(table(gender))

set.seed(55)
(grade = sample(c('Ex','Good','Sat'), size=13, replace= T,prob=c(.6, .3, .1)))
table(grade)
prop.table(table(grade))

sapply(list(rollno, name, age, gender, grade), length) #check the length of diff rows

(students = data.frame(rollno, name, age, gender, grade))


x=c(-14.35, 14.35, -14.55, 15.35)
x
floor(x)
ceiling(x)
trunc(x)

#csv - comma separted values
write.csv(students, 'data/students.csv', row.names= F)

df1 = read.csv('data/students.csv') #from any subfolder
df1 #df will always have a row & col name; matrix need not

(df2 = read.csv('https://raw.githubusercontent.com/DUanalytics/rAnalytics/master/data/students.csv')) #from internet

df3 = read.csv(file.choose()) #from system
df3

students

#deploy a package - install only once, use anytime
#install.packages("dplyr")
library(dplyr) #loads library

class(students)
summary(students)
str(students)
(students = data.frame(rollno, name, age, gender, grade, stringsAsFactors = F)) #factor is a category
students$gender = factor(students$gender)
str(students)
students$grade = factor(students$grade, ordered=T, levels=c('Sat','Good','Ex')) #factor should be ordered
str(students)
table(students$grade)

students %>% group_by(gender) %>% tally()
students %>% group_by(gender) %>% summarise(mean(age), n(), min(marks), max(marks))
students %>% group_by(gender,grade) %>% summarise(mean(age))
