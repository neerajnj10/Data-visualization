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
