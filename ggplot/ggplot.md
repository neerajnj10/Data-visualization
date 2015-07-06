---
title: 'ggplot2'
author: "neeraj"
output: html_document
---

Graphically analyze using `ggplot2` the 1970 Boston housing dataset. This dataset consists of 14 variables with 506 observations. The target variable, `medv`, is the median owner-occupied home value in 1000's of dollars. The Boston dataset is found in the `MASS` package. 
```{r}
library(MASS)
data(Boston)
Boston$chas <-factor(Boston$chas, levels = c(0,1),
                     labels = c("Not on River", "On River"))
Boston$rad <-factor(Boston$rad)
head(Boston)
```

Fit a linear model to `log(medv)` using select predictors.
```{r}
attach(Boston)
Boston.lm <- lm(log(medv) ~ crim + chas + rad + lstat)
summary(Boston.lm)
```
All variables are highly significant.

See the variable descriptions using `help` in the `MASS` package.

1. Plot and discuss the distributions of the log of the median home value (`log(medv)`) faceted by both Charles River (`chas`) and radial highway location (`rad`). Does the log transformation improve symmetry?



* The plot chosen is Histogram distribution as it allows easy and clear exploration of just one dimension of our data, imposed with other attributes, faceted on it. Various different methods of facets are used with and without log transformation to execise on different or similar results we may get.

* 1st plot is basic histogram facted with both "chas" & "rad" with out log transform for comparison. It shows that median home are "overall" much higher that are located in "not on river" location and on radial highway other than highway no. 24.

* 2nd & 3rd plot provide for2 different options on how the data can be faceted, with grid, here we have used log transform to show the difference.

* 4th plot is optional, and is just to show an alternative way to get the bove results.

* Quite clearly log transformation makes the distribution more symmetric.
 
 
 
```{r}
library(ggplot2)
#plotting without log transformation.
ggplot(Boston, aes(x=(medv))) + 
  geom_histogram(binwidth=5)+ 
  facet_grid(.~chas+rad)

#plotting with log transformation.
ggplot(Boston, aes(x=log(medv))) + geom_histogram(binwidth=5)+ 
  facet_grid(chas~rad, margins=T)

ggplot(Boston, aes(x=log(medv))) + 
  geom_histogram(binwidth=5)+ facet_grid(.~chas+rad, margins=T)

#alternative way of using log transformation, 
#however it changes the x-axis "lim" since it is applied to whole of it.
ggplot(Boston, aes(x=(medv))) + geom_histogram(binwidth=5)+ 
  facet_grid(.~chas+rad, margins=T) + scale_x_log10() 

```


2. Plot and discuss the boxplot distributions of the log of the median home values (`log(medv)`) by the Charles River (`chas`) and separately by radial highway locations (`rad`). Draw horizontal lines at `mean(log(medv))` in each plot.



* Here log transfromation of "medv" is taken to avoid absurd distribution and too many outliers. Two separate plots are made for "log(medv)" reflecting the effects and relation of "chas" & "rad" individually with log(medv). 

* As we can see from the first plot for log(medv) vs chas, log of median home values, log(medv) values, are almost same as Mean for "Not on River" plot, while for "On River" plot of chas with log(medv) shows that mean lies near the 25th quantile of the data,thereby reiterating our conclusion rom 1st question, that "not on a river" has high value for median homes.

* The 2nd plot for rad vs log(medv) that only in two cases where rad=4 & 6, it has its median close to mean, while for the rest, it is either above or below it, thereby showing the difference in the mean values of each log(medv) wrt to rad. here, it shows that log of median home values have value higher than the "overall average value" at radial highway other than highway no. 24.


```{r}
#log(medv) vs chas.
ggplot(Boston, aes(y=log(medv),x=chas, fill=chas)) + geom_boxplot() +
  geom_hline(aes(yintercept=mean(log(medv)))) 



#log(medv) vs rad.
ggplot(Boston, aes(y=log(medv),x=rad, fill= rad)) + geom_boxplot()+ 
  geom_hline(aes(yintercept=mean(log(medv)))) 


```



3. Explore graphically the relationship of crime (`crim`) to the log of the median home values (`log(medv)`) with and without faceting on the radial highway locations (`rad`). What difficulties do you see in using `crim` as a predictor?


* Since both the vaiables are continuous, it is preferable to use to scatterplot to show relationship betweent the two. "crim" is a predictor therefore placed on x-axis. In some cases, Linear model method is used to draw a straight line through the plot to depict any relation possible. 

* 1st plot is very basic, which shows the smoothing curve along the data and pattern that the relation between log(medv) and crim is following. It depicts crime rates are almost negligible for log of median home values above the mean, and crime rate increases as log(medv) fall below the mean and picks up afet a certain value.

* In 2nd plot we are showing points interaction between the variables along with the smoothing curve with confidence interval, suggesting how much uncertainty there is in this smoothing curve, which is considerable in our case. Another way to show crime rates are 0, for higher median home values, therefore has negative relation upto certain value, beyond which it again increases. 

* In 3rd plot, Here we have simply turned off our "standard error" as se=F and instead used the "lm" to show a best fit straight line. As we can see not many data points are along this line and are mostly scattered.

* In 4th plot, we have used another technique by using geom_line, to show the actual points with peaks in comparison to mean value of log(medv) which is close to 3. As we can see, for a lot no. of values of variable of "crim" that lies predominantely between 0 & 1 , has close interaction with the values of log(medv) at its "Mean value", whcih mean most for the value of "crim" are in this range. As the value of "crim" increases, the interaction decreases.

* In 5th plot, we have included faceting with another variable "rad" to superimpose its effects on the two variable on x and y axis. We can see that for radial highway 24, crime rates are "highest" among all the highways and median home value log is around mean and then it decreases. Crime rate are lowest for highway 3, 6 and 8 and alsothe median home value are quite favorable here, so these are best options. Statistically, It shows in "almost" all cases, the relation ship is negative along the line, except at "rad=8".

* In earlier plot, we used "facet wrap, which is usually recommended when overlapping the attribute of a single variable to the variables represented in the plots, however "facet_grid" can also substituted to show the similar results.


```{r}
ggplot(Boston, aes(x=crim, y=log(medv))) + 
  geom_smooth(se=F)

ggplot(Boston, aes(x=crim, y=log(medv))) + 
  geom_point() +geom_smooth()

ggplot(Boston, aes(x=crim, y=log(medv))) + 
  geom_point() +geom_smooth(method="lm", se=F)

ggplot(Boston, aes(x=crim, y=log(medv))) + geom_line() +
  geom_smooth(method="lm", se=F)+geom_hline(aes(yintercept=mean(log(medv))))+ 
  geom_vline(aes(xintercept=0), colour="red", linetype="dashed")+ 
  geom_vline(aes(xintercept=1), colour="red", linetype="dashed")

ggplot(Boston, aes(x=crim, y=log(medv), color=rad)) + 
  geom_point() +geom_smooth(method="lm", se=F) + 
  facet_wrap(~rad, scale="free")

ggplot(Boston, aes(x=crim, y=log(medv), color=rad)) + 
  geom_point() +geom_smooth(method="lm", se=F) + 
  facet_grid(~rad)

```

> difficulties do you see in using `crim` as a predictor.

* "crim" variable has high number of datapoints/values present in between 0 & 10, while very few present in the other half, that is beyond 20, which shows the "crim" variable has "very high" skewness in as compared to other variables when realted to log(medv). $suggestion$ : There it would make sense to scale the "crim" variable in our model as shown below. The plot looks much better and there are more points between 0 & 10 for "crim" and on the line of mean value of log(medv), i.e. 3.0, which is a very good result. The plot then shows, there are new options available wrt to low crime rate and high median homes values above the mean=3.0, of many options, 4 and 5  are additional safe choices.


```{r}
#suggestion.
# Demo plot after, logged "crim" introduced to relation with log(medv)
ggplot(Boston, aes(x=crim, y=log(medv))) + 
  geom_point() +geom_smooth(method="lm", se=F) + scale_x_log10()
ggplot(Boston, aes(x=log(crim), y=log(medv), color=rad)) + 
  geom_point() +geom_smooth(method="lm", se=F) + 
  facet_wrap(~rad, scale="free")
```

4. To explore the the crime variable (`crim`):  
a) Plot the density histogram of the log of crime (`log(crim)`). Superimpose a density curve.   
b) Plot and discuss the boxplot distribution of crime (`crim`) relative to the radial highway locations (`rad`). Should crime be logged in the linear model?


* Density histogram with superimposed density curve.

```{r}

ggplot(Boston, aes(x=crim)) + 
  geom_histogram(aes(y=..density..), 
                 binwidth=1, colour="black", 
                 fill="white") #density histogram

ggplot(Boston, aes(x=crim)) + 
  geom_histogram(aes(y=..density..), 
                 binwidth=1, colour="black", fill="white") + 
  geom_density(alpha=.2, fill="blue") #den. hist. with superimposed density curve

ggplot(Boston, aes(x=crim)) + 
  geom_histogram(aes(y=..density..), 
                 binwidth=1, colour="black", fill="white") + 
  geom_density(alpha=.2, fill="blue") + scale_x_log10() #transformation to clear the skewness.
```


* Boxplot distribution

* As we can see from the plots below. Without log distribution, since there are a large number of outliers especially on rad = 24, it is a good practice to try putting the y-axis on a log scale, i.e., "crim" needs to be logged in the model.

* we can learn from our previous question, i.e. question 3, where we found the relation between log(medv) and "crim" both with and without "rad" facetting, through the plot, that "crim" has large no. of skewed points and it is recommended and suggessted to log transform the variable. There the box plot in this question presents a very strong affirmation to our assumption and inferences from the plots. It shows relatively very high crime rate at highway =24 than other highways and lowest on highway 1.


```{r}
#without log transformation of "crim" variable.
ggplot(Boston, aes(x=rad, y=crim, fill=rad)) + geom_boxplot() 

#with log transformation.
ggplot(Boston, aes(x=rad, y=crim, color=rad)) + geom_boxplot() + 
  scale_y_log10()
```

5. To explore the effect of `lstat` on the model:  
a) Explore graphically the relationship of percent lower status (`lstat`) to the log of the median home (`log(medv)`) values with and without faceting on the radial highway locations (`rad`).
b) Add linear fits overall and for each facet. Discuss the efficacy of the fits and whether or not there appears to be an interaction between `lstat` and `rad`.


* 1st plot is again a basic scatter plot, which gives an indication of some sort of relation between lstat ad log(medv). There is very high median home value for lower status from 0 to 10~20.

* 2nd plot, draws the smoothing curve along the points showing the relation ship path between the two variables. It is somewhat nicely spread along the line, specially from 0 to 10~20 on x-axis, that is for lower status there is a high median home value, whcih decreases as the lower status increases and also therefore, becomes less significant in relation, as shown from the plot. Therefore, lower status on overall will not buy median homes with high values.

* In the 3rd plot, we go beyond the 2 variable and facet it with the another variable called "rad" to see the combined effectof rad and lstat on the log(medv). As we can see, for radial highway 24, the lstat is between and 10 and 30, therefore value of the log of median home is below the  mean here. Clearly, for rad = 24, it can be seen  that there are arge percent of lower status here, and therefore higher crime rates (a found in other questions) and therefore lower median home values, according to the affordability. The highway 3, 4 and 5 have high log of median values of homes and relatively low lower status percent, therefore they are safe options. While 1, 2, , 7 and 8 highways do not have very high no. of median home values(logof) above the mean, the ae safest the safest highways and have very low lwer status percent.

* As we can see from the plot, there is definite relation between the radial highways and lower status percent, "rad" vs "lstat" and the use of "linear fit" makes it even more clear. Again we can re-iterate on our assumptions and conclude, that highway 24 has highest no. of lower status percent of all, while highway 3,4,5 have medium range of lower status under 20% and have considerably high median home value(log of) as well. Highway 1 has lowest of all, lower status percent, followed by highway 7,2,8 and 6 in an order in an increasing order. So it clearly shows the relation between the highways and the lower status percents.


```{r}
#Exploring the effect of "lstat" on the model.

#without facetting "rad".

ggplot(Boston, aes(x=lstat, y=log(medv))) + geom_point()

ggplot(Boston, aes(x=lstat, y=log(medv))) + geom_point() +
  geom_smooth(se=F)

#facetting with "rad" to include the another variable effect.

ggplot(Boston, aes(x=lstat, y=log(medv))) + geom_point() + 
  facet_wrap(~rad, scale="free") + geom_smooth(se=F)

#Adding linear fit.

ggplot(Boston, aes(x=lstat, y=log(medv))) + geom_point() + 
  geom_smooth(method="lm", se=F)

ggplot(Boston, aes(x=lstat, y=log(medv))) + geom_point() + 
  facet_wrap(~rad, scales = "free") + 
  geom_smooth(aes(colour = rad),method="lm", se=F)
```
