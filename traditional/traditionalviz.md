---
title: 'Assignment 1: Traditional Graphics'
author: "jharner"
date: "February 7, 2015"
output: html_document
---

Develop the R code to reproduct the following plots:

1. The exponential probability density function and cumulative distribution function with $\lambda = 1.5$, where $m$ is the median.

![exponential](exponential.png)

```{r}
# Exponential Probability Density Function.
par(mai = c(1, 1, 1, 1), omi = c(0, 0, 0, 0)) #window plot and graphic area is set.
X=seq(0,5,length=200)
Y=dexp(X,rate=1.5)
plot(X,Y,type="l",lwd=2,col=gray(0.2),xlab="y",ylab="f(x)")
X=seq(0,0.462,length=200)
Y=dexp(X,rate=1.5)
polygon(c(0,X,0.462),c(0,Y,0),col="gray")
lines(c(0,5),c(0.0,0.0),col="black")
arrows(3, 0.5, 0.462, 0.0, length = 0.25, angle = 15, lwd=1)
text(3, 0.5, "m=0.462", pos=4, cex=1)

# Exponential Cumulative Distribution Function.
par(mai = c(1, 1, 1, 1), omi = c(0, 0, 0, 0))        #window plot and graphic area is set.
x<-seq(0,5,length=200)
yp <- pexp(x,rate=1.5)
plot(x,yp,type="l",xlab="y",ylab="f(y)", ylim=c(0.0,1.0))
lines(c(0.5,0.5,0),c(0,0.5,0.5))
lines(c(0,0),c(-0.2,1.2),lty=3, col = "gray80")          #similar to segments, creating lines.
lines(c(1,1),c(-0.2,1.2),lty=3, col = "gray80")
lines(c(2,2),c(-0.2,1.2),lty=3, col = "gray80")
lines(c(3,3),c(-0.2,1.2),lty=3, col = "gray80")
lines(c(4,4),c(-0.2,1.2),lty=3, col = "gray80")
lines(c(5,5),c(-0.2,1.2),lty=3, col = "gray80")
lines(c(-0.2,5.2),c(0.0,0.0),lty=3, col = "gray80")
lines(c(-0.2,5.2),c(0.2,0.2),lty=3, col = "gray80")
lines(c(-0.2,5.2),c(0.4,0.4),lty=3, col = "gray80")
lines(c(-0.2,5.2),c(0.6,0.6),lty=3, col = "gray80")
lines(c(-0.2,5.2),c(0.8,0.8),lty=3, col = "gray80")
lines(c(-0.2,5.2),c(1.0,1.0),lty=3, col = "gray80")
text(0.5, 0.03, "m", pos=1, cex=1)
```

2. Histogram of a normal random sample of $n = 100$ with $\mu = 10$ and $\sigma = 2$.

![histogram](histogram.png)

```{r}
#Histogram of a Normal Random Sample with n=100, mean=10, sd=2
set.seed(4321)
y <- rnorm(n = 100, mean = 10, sd = 2)
mean(y)
sd(y)
hist(y,prob=TRUE,breaks=seq(2,18,2),ylim=c(0,0.2),xaxt="n")    #prob is TURE to get histogram of rnorm.
axis(side=1, at=seq(2,18,2),labels=seq(2,18,2))
curve(dnorm(x,mean=10,sd=2),lwd=2,add=TRUE)
rug(y) 
```

3. Cross-section of a mine tunnel. The small dots at the bottom of the mine tunnel represent debris which is uniformly distribured from 0 to 360 with $n = 250$.

![mine](mine.png)

```{r}
# Cross-section of a mine tunnel graph-plot. 

#Using segments instead of Lines as an alternative approach, lines can produce the same results as seen above in 1st question.
set.seed(1000)
x<-runif(250,0,360)
y<-runif(250,0,1/360)
plot(x,y,xlim=c(-100,500),ylim=c(-0.01,0.05),pch=19,cex=0.3,axes=F,xlab="",ylab="")  #axes=F to remove the axes from the plot.
segments(370,0.02,370,0.035,lwd=2)                       #similar to lines.
segments(350,0.02,350,0.035,lwd=2)
segments(370,0.02,500,0.02,lwd=2)
segments(-10,0.02,-10,0.035,lwd=2)
segments(-10,0.02,-100,0.02,lwd=2)
segments(10,0.02,10,0.035,lwd=2)
segments(10,0.02,350,0.02,lwd=2)
segments(-100,0,500,0,lwd=2)
text(180,0.023,"Roof",font=2)           
text(180,0.038,"Air shafts", font=2)
text(0,-0.005,"0")
text(360,-0.005,"360")
segments(0,0,0,-0.002,lwd=3)
segments(360,0,360,-0.002,lwd=3)
arrows(125,0.038,20,0.035,length=0.15,angle=15,lwd=1.7)
arrows(235,0.038,340,0.035,length=0.15,angle=15,lwd=1.7)
```

