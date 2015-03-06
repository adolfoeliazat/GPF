
library(forecast)
library(shiny)



shinyServer(function(input, output) {
   
  output$mychart <- renderLineChart({
    # Return a data frame. Each column will be a series in the line chart.
    GPtrain <- window(GPts, start=c(input$FitFy, input$FitFm), end=c(input$FitTy, input$FitTm), freq=12)
    GPtest <- window(GPts, start=c(input$TestFy, input$TestFm), end=c(input$TestTy, input$TestTm), freq=12)
    ActualGP = ts(c(GPtrain, GPtest), start = start(GPtrain), frequency = frequency(GPtrain)) 
    autoArima <- auto.arima(GPtrain)
    exfor = forecast(autoArima, length(GPtest))
    auto.arima = c(autoArima$residuals, exfor$mean)
    nnetexf <- nnetar(GPtrain)#, h=39)
    nneexrff = forecast(nnetexf, length(GPtest))
    nnetar = c(nnetexf$residuals, nneexrff$mean)
    
    meanff <- meanf(GPtrain, h=length(GPtest))
    meanf = c(meanff$fitted, meanff$mean)
    
    thetaff <- thetaf(GPtrain, h=length(GPtest))
    thetaf = c(thetaff$residuals, thetaff$mean)
    
    naivef <- naive(GPtrain, h=length(GPtest))
    naive = c(naivef$residuals, naivef$mean)
    
    snaivef <- snaive(GPtrain, h=length(GPtest))
    snaive = c(snaivef$residuals, snaivef$mean)
    
    #rwff <- rwf(GPtrain, h=length(GPtest))
    crostonf <- croston(GPtrain, h=length(GPtest))
    croston = c(crostonf$residuals, crostonf$mean)
    
    stlff <- stlf(GPtrain, h=length(GPtest))
    stlf = c(stlff$residuals, stlff$mean)
    
    sesf <- ses(GPtrain, h=length(GPtest))
    ses = c(sesf$residuals, sesf$mean)
    
    holtf <- holt(GPtrain, h=length(GPtest))
    holt = c(holtf$residuals, holtf$mean)
    
    hwf <- hw(GPtrain, h=length(GPtest))
    hw = c(hwf$residuals, hwf$mean)
    
    data.frame(
      ActualGP,
      auto.arima,
      nnetar,
      meanf,
      thetaf,
      naive,
      snaive,
      croston,
      stlf,
      ses,
      holt,
      hw
      #GPtrain <- window(GPts, start=c(input$FitFy, input$FitFm), end=c(input$FitTy, input$FitTm), freq=12),
      #GPtest <- window(GPts, start=c(input$TestFy, input$TestFm), end=c(input$TestTy, input$TestTm), freq=12)
    )
  })
  
  output$mychartf <- renderLineChart({
    # Return a data frame. Each column will be a series in the line chart.
    GPtrain <- window(GPts, start=c(input$FitFy1, input$FitFm1), freq=12)
    
    #ActualGP = ts(c(GPtrain, 6), start = start(GPtrain), frequency = frequency(GPtrain)) 
    autoArima <- auto.arima(GPtrain)
    exfor = forecast(autoArima, 6)
    auto.arima =  exfor$mean
    nnetexf <- nnetar(GPtrain)#, h=39)
    nneexrff = forecast(nnetexf, 6)
    nnetar = nneexrff$mean
    
    meanff <- meanf(GPtrain, h=6)
    meanf =  meanff$mean
    
    thetaff <- thetaf(GPtrain, h=6)
    thetaf = thetaff$mean
    
    naivef <- naive(GPtrain, h=6)
    naive =  naivef$mean
    
    snaivef <- snaive(GPtrain, h=6)
    snaive = snaivef$mean
    
    #rwff <- rwf(GPtrain, h=length(GPtest))
    crostonf <- croston(GPtrain, h=6)
    croston =  crostonf$mean
    
    stlff <- stlf(GPtrain, h=6)
    stlf = stlff$mean
    
    sesf <- ses(GPtrain, h=6)
    ses = sesf$mean
    
    holtf <- holt(GPtrain, h=6)
    holt =  holtf$mean
    
    hwf <- hw(GPtrain, h=6)
    hw = hwf$mean
    
    data.frame(
      #ActualGP,
      auto.arima,
      nnetar,
      meanf,
      thetaf,
      naive,
      snaive,
      croston,
      stlf,
      ses,
      holt,
      hw
      #GPtrain <- window(GPts, start=c(input$FitFy, input$FitFm), end=c(input$FitTy, input$FitTm), freq=12),
      #GPtest <- window(GPts, start=c(input$TestFy, input$TestFm), end=c(input$TestTy, input$TestTm), freq=12)
    )
  })
  
  
  output$distPlot <- renderPlot({
     
    GPtrain <- window(GPts, start=c(input$FitFy, input$FitFm), end=c(input$FitTy, input$FitTm), freq=12)
    GPtest <- window(GPts, start=c(input$TestFy, input$TestFm), end=c(input$TestTy, input$TestTm), freq=12)
    arfimaf <- arfima(GPts)#, h=39)
    arfimaff = forecast(arfimaf, 6)
    plot(arfimaff, xlim=c(2010,2014.5), ylim=c(1100,2000))
    
  })
  
  output$snfPlot <- renderPlot({
    
    GPtrain <- window(GPts, start=c(input$FitFy, input$FitFm), end=c(input$FitTy, input$FitTm), freq=12)
    GPtest <- window(GPts, start=c(input$TestFy, input$TestFm), end=c(input$TestTy, input$TestTm), freq=12)
    
    snaivef <- snaive(GPts, h=length(GPtest))
    snf = forecast(snaivef, 6)
    plot(snf, xlim=c(2010,2014.5), ylim=c(1100,2000))
  })
  
  output$ziptable <- renderDataTable({
    cleantable %.%
      filter(
        Score >= input$minScore,
        Score <= input$maxScore,
        is.null(input$states) | State %in% input$states,
        is.null(input$cities) | City %in% input$cities,
        is.null(input$zipcodes) | Zipcode %in% input$zipcodes
      ) %.%
      mutate(Action = paste('<a class="go-map" href="" data-lat="', Lat, '" data-long="', Long, '" data-zip="', Zipcode, '"><i class="fa fa-crosshairs"></i></a>', sep=""))
  })
  
})
