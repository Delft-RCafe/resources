# load libraries 

library(shiny)
library(tidyverse)
library(plotly)

ui <- fluidPage(
  sliderInput("point_size", "Change size of the points:", 1, 10, 3)
  ,
  selectInput("cut_filter", label = "Choose cut quality" , choices = levels(diamonds$cut) ),
  plotlyOutput("diamonds_plot"),
  tableOutput("diamonds_table")
)

server <- function(input, output){
  
  diamonds_new <- reactive({diamonds %>%
      filter(cut == input$cut_filter)
  })
  
  output$diamonds_plot <- renderPlotly({
    
    p <- ggplot(data = diamonds_new()) +
      aes(x = carat,
          y = price, 
          color = color,
          cut = cut,
          clarity = clarity, 
          table = table
          ) +
      geom_point(size = input$point_size,
                 shape = 19,
                 alpha = 0.5
      )
    
    ggplotly(p)
    
  })
  
  
  output$diamonds_table <- renderTable({
    diamonds_new() %>%
      arrange(price) %>%
      head(10)
  })
}

shinyApp(ui = ui, server = server)
