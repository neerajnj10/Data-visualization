---
title: ' shiny'
author: "neeraj"

output: html_document
---

Consider the variable weight (`wt`) from the `mtcars` data set which is in the builtin `datasets` package. 
```{r}
data(mtcars)
```

Use shiny to construct a histogram of `wt` in which the number of bins is controlled by a slider. Organize and label the plot appropriately.

You will need to construct two files: `ui.R` for the user interface and `server.R` for the server-side code. Explain how the app is run.

Include the code here for reference.
```
## ui.R
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Shiny App for Histogram!"),
  
  fluidRow(position="center",
  
  column(3, 
         h3("Description"),
         h4(helpText("Note: The horizontal line drawn through the histogram is the mean value of wt variable 
                           used for plotting histogram. Mean valueis 3.21725 and is almost same as median of wt 
                           variable which is 3.325"), align="right"))
  ),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(position="right",
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 10,
                  value = 8)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h2("Histogram plot for mtcars(wt)", align= "center"),
      plotOutput("distPlot")
      
    )
  )
))
```



```
## server.R
library(shiny)
library(datasets)
data(mtcars)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  wt<-reactive({
    wt <- mtcars[, input$variable]
  })
  output$distPlot <- renderPlot({
    wt<- mtcars[, "wt"]  # mtcars datasets::
    bins <- seq(min(wt), max(wt), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(wt, breaks = bins, col = 'blue', border = 'white')
    abline(h=mean(wt),lty="solid", col="red")
  })
})

```


```
library(shiny)
runApp("mtcarsapp")
```

* A Shiny application is nothing but simply a directory that contains a user-interface(ui) definition, a server script(server), and any additional data, scripts, or other resources required to support the application. We create a new empty directory wherever we'd like, then create empty ui.R and server.R files within in. After which we write the R scipt for user interface called as "ui.R" and "server.R" for server script. Server script works on the background with the data and does the major coding part and prepares the output display for application. While ui.R takes the request for output specified by the server.R and turns that into web based interactive and fluid application which is user friendly and provides dynamic as well as static interface to work along it. Title page is for title of teh app, sidebar provides ability to input the interactive sliders, in our case which is bin no. for our histogram. Mainpanel describes what appears on top of plot. The three functions headerPanel, sidebarPanel, and mainPanel define the various regions of the user-interface. Next we define the server-side of the application which will accept inputs and compute outputs. Accessing input using slots on the input object and generating output by assigning to slots on the output object. Initializing data at startup that can be accessed throughout the lifetime of the application. Using a reactive expression to compute a value shared by more than one output. The basic task of a Shiny server script is to define the relationship between inputs and outputs. Our script does this by accessing inputs to perform computations and by assigning reactive expressions to output slots. The inout is mtcars data and "wt" column for histogram with defined binwidth and breaks.
