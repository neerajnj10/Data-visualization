library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Shiny App for Histogram!"),
  
  fluidRow(position="center",
           
           column(3, 
                  h3("Description"),
                  h4(helpText("Note: The horizontal line drwan throught the histogram is the mean value of wt variable 
                           used for plotting histogram. Mean valueis 3.21725 and is almost same as median of wt 
                           variable which is 3.325"), align= "right"))
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
