
---
title: 'ggvis'
author: "neeraj"
date: "March 2, 2015"
output: html_document
---

Graphically analyze using `ggvis` the 1970 Boston housing dataset. This dataset consists of 14 variables with 506 observations. The target variable, `medv`, is the median owner-occupied home value in 1000's of dollars. The Boston dataset is found in the `MASS` package. 
```{r}
library(MASS)
data(Boston)
Boston$chas <-factor(Boston$chas, levels = c(0,1),labels = c("Not on River", "On River"))
Boston$rad <-factor(Boston$rad)
head(Boston)
```

The fit of a linear model to `log(medv)` using select predictors is:
```{r}
attach(Boston)
Boston.lm <- lm(log(medv) ~ crim + chas + rad + lstat)
summary(Boston.lm)
```
All variables are highly significant.

See the variable descriptions using `help` in the `MASS` package.

In each of the following plots, **label the axes appropriately**.

1. Plot the boxplot distributions of the log of the median home values (`log_medv = log(medv)`) by the Charles River (`chas`) and separately by radial highway locations (`rad`). Draw horizontal lines at `mean(log(medv))` in each plot. Discuss each plot.

```{r}
library(dplyr, warn.conflicts = FALSE)
library(ggvis)
mean_medv=mean(log(medv))
mean_medv
```

* The mean of log of median home values is 3.034513 and we see a line going by that as shown in the plot. We can clearly see that median of Charles river that is "NOT on River" shows an overlap with the mean value of log of medv, therefore, mean home value that are not on the river is 3.03, however the median of home values that are "On River"
is higher than the overall mean home values. Hence, it is profitable to buy the home that are on or near the river, as the median is higher than the overall average, that is relative to else where.

```{r}
#boxplot distributions of the log of the median home values (`log_medv = log(medv)`) by the Charles River (`chas`)
Boston %>% ggvis(~chas,~log(medv)) %>% layer_boxplots(fill= ~chas) %>% layer_paths(y=mean_medv) %>%add_axis("x", title = "chas") %>% add_axis("y", title = "log_medv")
```


* Here we see clearly that value of homes that are on or closer to radial highway no. $1$, $2$ , $3$ , $5$ , $7$ and $8$ have very high values, therefore are expensive, while homes that are on highway $6$, have still little high value than the average value overall. But the value of homes are $significantly$ low for those that are specifically on highway $24$, while only little lower than mean for highway $4$.

```{r}
#boxplot distributions of the log of the median home values (`log_medv = log(medv)`) by the Radial highway locations (`rad`)
Boston %>% ggvis(~rad,~log(medv)) %>% layer_boxplots(fill= ~rad) %>% layer_paths(y=mean_medv) %>% add_axis("x", title = "rad") %>% add_axis("y", title = "log_medv")
```

2. Explore graphically the relationship of log crime (`log_crim = log(crim)`) to the log of the median home values (`log_medv`). Add the linear model fit and a smoothed fit with their standard error bands. Do you see any difficulties in using `log_crim` as a predictor? 

* We can see from the plot that there is definite problem with using log(crim) as a predictor. The log of crime rate values or log_crim=log(crim) is very densely populated in a very thin region and does not provide good estimate of mean value of homes with respect to crime rate alone. Therefore, either we would need to change the axis (but since median home value is response variable we can not) or we have to use some other variable in association with log(crim) to accurately determine the median values.

```{r}
Boston %>% 
  ggvis(~log(crim), ~log(medv), fill:= "blue") %>%
  layer_points() %>%
  layer_model_predictions(model = "lm",se=TRUE, stroke:= "darkgray") %>% add_axis("x", title = "log_crim") %>% add_axis("y", title = "log_medv")
```


3. Explore graphically the relationship of log crime (`log_crim`) to the log of the median home values (`log_medv`) as in 2.
a) Fill (color) the points according to the radial highway locations (`rad`). Group by `rad` and fit linear models. Does there appear to be an interaction between `rad` and `log_crim`? Discuss.

* Now adding the third variable (2 predictors and 1 response)to our analysis, we see that log(crim) makes more sense as a predictor. It shows that there is overlap between the log_crim (crime rates) and the radial highways where the homes are located and hence their values. Most distinctive of it all is the Highway no. 24, as we have seen in earlier plots as well, that mean/median value of homes on this highway is fairly low, which can be also be seen to be affected due to the amount of crime rates, which is highest and very distinct with respect to crime rates on other highways shown by lighter green color. While for other highways, though mostly the median home values is above the mean, the crime rate is lesser than that on highway24. Therefore, it is a good indication of interaction and correlation between the two predictors, that is rad and log(crim).

```{r}
Boston %>% ggvis(~log(crim), ~log(medv), fill= ~rad) %>% 
  layer_points() %>% 
  group_by(rad)%>%
  layer_model_predictions(model = "lm") %>% add_axis("x", title = "log_crim") %>% add_axis("y", title = "log_medv")
```
b) a) Fill (color) the points according to the Charles River (`chas`). Group by `chas` and fit linear models. Does there appear to be an interaction between `chas` and `log_crim`? Discuss.

* here we can see another type of interaction which is between log(crim) and chas. It shows that there is higher crime rate on area that are not on the river and that crime rate on the river area is lesser comparatively, which comfirms our findings looking back at the box plot we made earlier, therefore there is low crime rate and higher median home value on the river area.

```{r}
 Boston %>%  ggvis(~log(crim), ~log(medv), fill = ~chas) %>% 
  layer_points() %>% 
  group_by(chas)%>%
  layer_model_predictions(model = "lm") %>% add_axis("x", title = "log_crim") %>% add_axis("y", title = "log_medv")
```

4. To see how the the log crime variable (`crim`) depends on `rad` and `chas`, **make the x-axis scales equal** and:

a) Plot the density curve of the log of crime (`log_crim`).

* we see the crime rate values extend from -6 to 6+ and are heavely centered around -2 value with density of .20 and there is another smaller peak at around +2 with density on this value as .12

```{r}
Boston %>% ggvis(~log(crim)) %>% layer_densities() %>% scale_numeric("x", nice = FALSE) %>% add_axis("x", title = "log_crim")
```

b) Plot the density curve of  log crime (`lob_crim`) grouped by and filled (coloured) by the radial highway locations (`rad`). Discuss differences due to highway locations and compare to the plot in a).

* By grouping with radial highway we see that the peak on the right most side belongs to highway 24 therefore highest crime rate, while most of the highway crime rates belong to left side, which is negative side of the crime rate even though with much higher density value. 

* comparing to lone density plot of log(crim), we find that the heap or the denisty peak we see on original plot, right side is solely contributed by highway 24, while all the other highway form the density peak on left side all put together. 

```{r}
#plotting along with making x-axis scale equal.
Boston %>% ggvis(~log(crim), fill= ~rad) %>% group_by(rad)%>%
  layer_densities() %>% scale_numeric("x", domain = c(-6, 6), nice = FALSE)%>%add_axis("x", title = "log_crim")
```

c) Plot the density curve of  log crime (`lob_crim`) grouped by and filled (coloured) by the Charles River (`chas`). Discuss differences due to Charles River and compare to the plot in a).

* here we find that the denisty plot formed and grouped by charles river has two variation due to "not on river" and "on river" factor. The "not on river" plot is similar to original lone plot of log(crim) while the "on river" plot shows much wider denisty plot spreading between.16 to .18 density value, which is lower than the "on river" plot.

```{r}
Boston %>% ggvis(~log(crim), fill= ~chas) %>% group_by(chas) %>% 
  layer_densities() %>% scale_numeric("x", domain= c(-6,6), nice = FALSE) %>%add_axis("x", title = "log_crim")
```

5. Explore the effect of `lstat` on the median home (`log_medv`) by:
a) Plotting percent lower status (`lstat`) relative to the log of the median home (`log_medv`) with points coloured (filled) by the radial highway locations (`rad`). Add the linear fits and standard errors grouped by `rad`. Discuss the efficacy of the fits and whether or not there appears to be an interaction between `lstat` and `rad`.

*  Efficacy of the fits can be considered here to be fairly decent however it is less deducible with respect to determining the interaction between the rad and the lstat "clearly" as can be seen from the plot. However, it still confirms certain aspect of the relation and it can be understood that for radial highway 24, there is highest no. of lower status pop., and therefore lower median home value, while most of the other highway seem to have lower status percent of around 3 to 17%, bundled around densely more in 10 to 15 % region, which is much lesser than radial highway 24. Therefore,highway 24 seem to have different values depicted by the data points.

```{r}
Boston %>% ggvis(~lstat, ~log(medv), fill= ~rad) %>% 
  layer_points() %>%  
  group_by(rad)%>%
  layer_model_predictions(model = "lm")%>%add_axis("x", title = "lstat") %>% add_axis("y", title = "log_medv")
```

b)  Plotting percent lower status (`lstat`) relative to the log of the median home (`log_medv`) with points coloured (filled) by the Charles River (`chas`). Add the linear fits and standard errors grouped by `chas`. Discuss the efficacy of the fits and whether or not there appears to be an interaction between `lstat` and `chas`.

* While here we see, the efficacy of the fit is much better and clearly understandable or deducible.There are clear parallel lines which depict fitting lines for each of the applied factor that is, charles river-on river and not on river. The decency of efficacy could also be said to be contributed by no. of factors fitted in the model. In the previous model, we had more no. of factors to deal with, here it is only 2. The "on river" data extends from 2 to 27 on lower status percent value, and extends from 2.6 to 3.9 on median home values, best fitted to 2.6 to 3.7 where most of the values (two-third) is above 3.1 to close to 3.5, whereas for "not on river" the data extends from 2 to 37 on lower status percent value, and extends from 1.6 to 3.9 on median home values best fitted to 1.9 to 3.5 where there is "slightly" more no. on lower side of mean of home values. Therefore comparing these numbers we can cleaarly see, that median home values on river is higher than mean home value for not  on river, also simultaneously there is percent of lower status pop for "not on river" than it is for "on river" 

```{r}
Boston %>% 
  ggvis(~lstat, ~log(medv), fill= ~chas)%>% 
  layer_points()%>%
  group_by(chas)%>%
  layer_model_predictions(model="lm")%>%add_axis("x", title = "lstat") %>% add_axis("y", title = "log_medv")
```


 
