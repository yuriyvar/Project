library(shiny)

shinyServer(function(input, output) {
  output$value1 <- renderText({round((input$FT-32)*5/9,1)})
  output$value2 <- renderText({round(input$CT*9/5+32,1)})
  output$value3 <- renderText({round(avgMPG$class_MPG[avgMPG$Carline_Class_Desc ==input$carType],1)})
  output$value4 <- renderText({paste("$",round(input$fuel * (input$tripMiles / 
                                              avgMPG$class_MPG[avgMPG$Carline_Class_Desc == input$carType]),2))})

})