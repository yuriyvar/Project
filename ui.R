library(shiny)
require(markdown)

#shinyUI(headerPanel("Developing Data Products: Course Project"),

shinyUI(navbarPage("My Apps", headerPanel("Developing Data Products: Course Project"),
                   
  navbarMenu("Temperature Converter",
             tabPanel("Fahrenheit to Celcius",
              shinyUI(fluidPage(
                br(),
                      numericInput("FT",label = h4("Input Fahrenheit temperature below"),
                        value=97.9, min = -300, max = 5000, step = NA),
                     hr(),
                     fluidRow(h4("The corresponding Celcius temperature is:"),
                              column(2, verbatimTextOutput("value1")))   ))),
             tabPanel("Celcius to Fahrenheit",
              shinyUI(fluidPage(
                      numericInput("CT",label = h4("Input Celcius temperature below"),
                      value=36.6, min = -150, max = 3000, step = NA),
                    hr(),
                    fluidRow(h4("The corresponding Fahrenheit temperature is:"),
                            column(2, verbatimTextOutput("value2")))   )))
             ) # Closing Temperatue Converter
          , tabPanel("Trip Estimator",
                     shinyUI(fluidPage(
                       fluidRow(
                         column(4, h3("Choose your travel distance"), 
                                p("How many miles do you expect to cover in your trip?")),
                         column(4, h3("Select the type of your vehicle"),
                                p("Select a vehicle type for your trip(please refer to 'About' tab for more information on vehicle types)")),
                         column(4,h3("Expected fuel price") ,
                                p("How much (on average) do you expect to pay for a gallon of fuel during your trip?"))), # Closing fluidRow
                              
                       fluidRow(
                         column(4,numericInput("tripMiles","Enter number of miles you plan to travel",
                                                    value=50, min = 0, max = 5000, step = 10) ),
                         
                         column(4,selectInput('carType', 'Vehicle Type', c(Choose='',avgMPG$Carline_Class_Desc), selectize=TRUE,
                                              multiple = FALSE),
                                              fluidRow(column(7, verbatimTextOutput("value3")))),
                         
                         column(4,sliderInput("fuel", "Fuel Price per Gallon:", min = 0, max = 5, value = 1.90, step= 0.10),
                                              hr(),
                                              fluidRow("Your estimated trip cost is: ",column(7,verbatimTextOutput("value4")))
                                ) )  # Closing fluidRow
                             
                         ))
                  ),  # Closing Trip Estimator
  tabPanel("About",shinyUI(includeMarkdown("About.md"))) # Ending About tab
  ) # Closing 'My Apps'
  ) # Closing UI