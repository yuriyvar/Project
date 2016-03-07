---
title: 'about: my shiny app - course project'
author: "Yuriy Varvashenya"
date: "March 7, 2016"
output: 
  html_document: 
    keep_md: yes
runtime: shiny
---

## My Shiny App

This R Shiny Web App is built for the Developin Data Products course project from __John Hopkins' University__ *"Data Scinece Specialization"* through Coursera.com.  

When accessing the App, the user has a choice of selecting either `Temperature Converter` or `Trip Estimator` tabs. The user does have a choice of calculating the Fahrenheit/Celsius Temperature as well as determining one's car trip expenses.

### Temperature Converter  

In this tab the user is able to select via drop-down menu, which temperature conversion is needed: **Fahrenheit to Celcius** or **Celsius to Fahrenheit**. Once selected, the web page for the chosen converter is displayed. The default temperature is set to the human body temperature of 36.6 degrees Celcius or 98.6 Fahrenheit. The user may enter the desired temperature to be converted into the input box or operate up- and down- arrows and navigate to the temperature needed that way. 

### Trip Estimator

This tool allows the user to calculate a road trip taken by car. The input parameters are the `Travelled distance`, `Vehicle type` that determines the fuel efficiency of a select vehicle type, and the average `Fuel price` the user is expected to pay during the trip. The calculation is going to use datasets from the _2015-2016 Fuel Economy data_ data sets available from `www.fueleconomy.gov`.  

For the purpose of this app no Pick-up Trucks, Special Purpose Vehicles, and Luxury foreign Vehicles ('Ferrari', 'Lamborghini', 'McLaren', 'Pagani' and the likes) are excluded for a more relevant vehicle pool.
Also, the electric and hybrid vehicles are removed from the data set for more common approach to calculations.
