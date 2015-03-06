# runApp("../GPF")
# to run the app

library(shiny)

shinyUI(navbarPage("GPF", id="nav",
                    
                   inverse = T, collapsable = T, fluid = F, responsive = F,
                   
                   tabPanel("Fit & Test",
                            div(class="outer",style="width:100%;",
                                tags$head(
                                  # Include our custom CSS
                                  includeCSS("styles.css"),#bootstrap.css//styles.css
                                  includeScript("gomap.js")
                                ),
                                
                                mainPanel(
                                  h2("Gold Price", align="center"),
                                  lineChartOutput("mychart"),
                                  plotOutput("distPlot",  width = "100%",  height = "550px", hoverId = NULL, hoverDelay = 300, hoverDelayType = c("debounce")),#width = "90%", height = "90%", clickId = NULL,,"throttle"
                                  plotOutput("snfPlot",  width = "100%",  height = "550px", hoverId = NULL, hoverDelay = 300, hoverDelayType = c("debounce"))#width = "90%", height = "90%", clickId = NULL,,"throttle"
                                  ),

                                absolutePanel(id = "controls", class = "modal", fixed = FALSE, draggable = TRUE,
                                              top = 50, left = 200, right = "auto", bottom = "auto",
                                              width = 260, height = "auto",
                                              
                                              h2("Fit&Test"),
                                              
                                              numericInput('FitFy',
                                                        label = paste('Fit From Year: '),
                                                        value = 1980,
                                                        min = 1980,
                                                        max = 2014
                                              ),
                                              numericInput('FitFm',
                                                        label = paste('Fit From Month: '),
                                                        value = 1,
                                                        min = 1,
                                                        max = 12
                                              ),
                                              numericInput('FitTy',
                                                        label = paste('Fit To Year: '),
                                                        value = 2013,
                                                        min = 1980,
                                                        max = 2014
                                              ),
                                              numericInput('FitTm',
                                                        label = paste('Fit To Month: '),
                                                        value = 1,
                                                        min = 1,
                                                        max = 12
                                              ),
                                              
                                              numericInput('TestFy',
                                                        label = paste('Test From Year: '),
                                                        value = 2013,
                                                        min = 1980,
                                                        max = 2014
                                              ),
                                              numericInput('TestFm',
                                                           label = paste('Test From Month: '),
                                                           value = 2,
                                                           min = 1,
                                                           max = 12
                                              ),
                                              numericInput('TestTy',
                                                        label = paste('Test To Year: '),
                                                        value = 2014,
                                                        min = 1980,
                                                        max = 2014
                                              ),
                                              numericInput('TestTm',
                                                           label = paste('Test To Month: '),
                                                           value = 3,
                                                           min = 1,
                                                           max = 12
                                              )

                          )
                          )),
                   
                   tabPanel("Forecasting",
                            div(class="outer",
                                tags$head(
                                  # Include our custom CSS
                                  includeCSS("styles.css"),#bootstrap.css//styles.css
                                  includeScript("gomap.js")
                                ),
                                
                                mainPanel(
                                  h2("Forecasting Gold Price", align="center"),
                                  lineChartOutput("mychartf")#,
                                  #plotOutput("distPlot",  width = "98%",  height = "550px", hoverId = NULL, hoverDelay = 300, hoverDelayType = c("debounce")),#width = "90%", height = "90%", clickId = NULL,,"throttle"
                                  #plotOutput("snfPlot",  width = "98%",  height = "550px", hoverId = NULL, hoverDelay = 300, hoverDelayType = c("debounce"))#width = "90%", height = "90%", clickId = NULL,,"throttle"
                                  
                                ),
                                
                                absolutePanel(id = "controls", class = "modal", fixed = TRUE, draggable = TRUE,
                                              top = 60, left = 300, right = "auto", bottom = "auto",
                                              width = 160, height = "auto",
                                              
                                              h2("tweak Duration"),
                                              
                                              numericInput('FitFy1',
                                                           label = paste('Start From: '),
                                                           value = 1980,
                                                           min = 1980,
                                                           max = 2014
                                              ),
                                              numericInput('FitFm1',
                                                           label = paste('Start From Month: '),
                                                           value = 1,
                                                           min = 1,
                                                           max = 12
                                              )
                                              
                                )
                            )),
                   conditionalPanel("false", icon("crosshair"))
))