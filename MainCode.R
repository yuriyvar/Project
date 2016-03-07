library(devtools)
library(gdata)
setwd("~/Coursera/9 - Developing Data Products/Apps/Project")
mydf <- read.xls ("2015_2016_Car_Fuel_Economy_data.xlsx", sheet= 1,header = T, na.strings=c("NA","#DIV/0!"), 
                  stringsAsFactors = FALSE, check.names = TRUE)

mycols <- names(mydf) %in% 
  c('Carline_Class_Desc', 'Trans_Desc', 'Eng_Displ', 'Mfr_Name', 'Division', 'Carline', 'Comb_Unrd_Adj_FE_._Conventional_Fuel', 'Fuel_Usage_Desc_._Conventional_Fuel')
cardata <- mydf[mycols]
names(cardata)[names(cardata)=="Comb_Unrd_Adj_FE_._Conventional_Fuel"] <- "Fuel_Econ_MPG"
names(cardata)[names(cardata)=="Fuel_Usage_Desc_._Conventional_Fuel"] <- "Fuel_Type"

cardata$Division <- toupper(cardata$Division)
cardata$Mfr_Name <- toupper(cardata$Mfr_Name)
cardata$Carline <- toupper(cardata$Carline)
cardata$Trans_Desc <- toupper(cardata$Trans_Desc)
cardata$Carline_Class_Desc <- toupper(cardata$Carline_Class_Desc)

excldata <- subset(cardata, Division %in% toupper(c
                                                  ('Aston Martin Lagonda Ltd', 'Ferrari North America, Inc.', 
                                                  'Porsche','Bentley', 'Rolls-Royce Motor Cars Limited', 
                                                  'MASERATI', 'Roush Industries, Inc.', 'Bugatti', 
                                                  'Lamborghini', 'ALFA ROMEO','McLaren Automotive Limted', 
                                                  'McLaren', 'Pagani Automobili S.p.A.', 'RAM')) | 
                     
                     Carline_Class_Desc %in% toupper(c('Two Seaters','Minicompact Cars',
                                    'Subcompact Cars','Small Pick-up Trucks 2WD','Small Pick-up Trucks 4WD',
                                    'Standard Pick-up Trucks 2WD','Standard Pick-up Trucks 4WD',
                                    'Vans, Cargo Types','Vans, Passenger Type','Special Purpose Vehicle 2WD',
                                    'Special Purpose Vehicle 4WD','Special Purpose Vehicle cab chassis')) |
                    
                     Trans_Desc == 'MANUAL' | 
                    
                     Carline %in% grep("HYBRID", cardata$Carline, value = TRUE, ignore.case = TRUE) |
                    
                     Carline %in% grep("PRIUS", cardata$Carline, value = TRUE, ignore.case = TRUE)  )

finalCarData <- cardata[setdiff(rownames(cardata),rownames(excldata)),]

finalCarData$Carline_Class_Desc[finalCarData$Carline %in% c('JUKE AWD','JUKE NISMO RS AWD',
                                                            'GLA 45 AMG 4MATIC',
                                                            'AMG GLA 45 4MATIC')] <- "SMALL SUV 4WD"

finalCarData$Carline_Class_Desc[finalCarData$Carline %in% c('JUKE','GLA 250')] <- "SMALL SUV 2WD"

finalCarData$Carline_Class_Desc[finalCarData$Carline %in% c('QX50','MURANO FWD')] <- "STANDARD SUV 2WD"

finalCarData$Carline_Class_Desc[finalCarData$Carline %in% c('QX50 AWD','MURANO AWD')] <- "STANDARD SUV 4WD"

finalCarData$Carline_Class_Desc[finalCarData$Carline %in% c('FIT','SONIC 5','XB','500L','GOLF SPORTWAGEN',
                                                            'SOUL','SOUL ECO DYNAMICS','ELANTRA', 'FORTE',
                                                            'MAZDA3 5-DOOR', 'COROLLA', 'COROLLA LE ECO',
                                                            'IMPREZA SPORT','IMPREZA WAGON')] <- "COMPACT CARS"

finalCarData$Carline_Class_Desc[finalCarData$Carline %in% c('V60 AWD','V60 POLESTAR AWD','V60CC AWD','V60 FWD',
                                    '328I XDRIVE SPORTS WAGON','328D XDRIVE SPORTS WAGON',
                                    'E 350 4MATIC (WAGON)','E 400 4MATIC (WAGON)','ALLROAD QUATTRO',
                                    'SONATA', 'OPTIMA', 'SENTRA', 'SENTRA FE+')] <- "MIDSIZE CARS"
                                    
finalCarData$Carline_Class_Desc[finalCarData$Carline %in% c('VENZA', 'VENZA 4WD')] <- "LARGE CARS"

finalCarData$Carline_Class_Desc[finalCarData$Carline_Class_Desc==
                                  "SPECIAL PURPOSE VEHICLE, MINIVAN 2WD"] <- "MINIVAN 2WD"
finalCarData$Carline_Class_Desc[finalCarData$Carline_Class_Desc==
                                  "SPECIAL PURPOSE VEHICLE, MINIVAN 4WD"] <- "MINIVAN AWD"

finalCarData$Carline_Class_Desc[finalCarData$Eng_Displ>=5.0] <- "GAS GUZZLER: 5+L Eng < 20PMG"

#subset(finalCarData, Carline_Class_Desc=="GAS GUZZLER: 5+L Eng < 20PMG", select=c(Division,Carline, Eng_Displ, Fuel_Econ_MPG))

#unique(finalCarData[, 8] <- as.character(finalCarData[, 8])

require(dplyr)

avgMPG <- finalCarData %>%
  group_by(Carline_Class_Desc) %>%
  summarize(min_MPG =  round(min(Fuel_Econ_MPG),digits = 2),
            class_MPG =  round(mean(Fuel_Econ_MPG),digits = 2),
            max_MPG =  round(max(Fuel_Econ_MPG),digits = 2))
