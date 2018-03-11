# Server logic file

library(shiny)
library(ggplot2)
data("diamonds")


shinyServer(function(input, output) {
        
        # Fit a number of simple linear regression models one for each cut
        
        modelFair <- lm(price ~ carat, data = diamonds[diamonds$cut == 'Fair',])
        modelGood <- lm(price ~ carat, data = diamonds[diamonds$cut == 'Good',])
        modelVeryGood <- lm(price ~ carat, data = diamonds[diamonds$cut == 'Very Good',])
        modelPremium <- lm(price ~ carat, data = diamonds[diamonds$cut == 'Premium',])
        modelIdeal <- lm(price ~ carat, data = diamonds[diamonds$cut == 'Ideal',])
        
        # Predict value based on selected cut & the carat entered through the slider
        predictPrice <- reactive({
                
                if (input$cut == 0) value <-predict(modelFair, newdata = data.frame(carat = input$carat))
                else if (input$cut == 1) value <- predict(modelGood, newdata = data.frame(carat = input$carat))
                else if (input$cut == 2) value <- predict(modelVeryGood, newdata = data.frame(carat = input$carat))
                else if (input$cut == 3) value <- predict(modelPremium, newdata = data.frame(carat = input$carat))
                else if (input$cut == 4) value <- predict(modelIdeal, newdata = data.frame(carat = input$carat))
                
        })
        caratsEntered <- reactive({ input$carat   })
        
        # Render text command for the predicted price
        output$prediction <- renderText({ 
                
                predictPrice() })
        #Render output for entered carats value
        output$carats <- renderText({ 
                
                caratsEntered() })
        
        #Prepare plots based on selected cut
        
        output$distPlot <- renderPlot({
                
                if (input$cut == 0) {g <- ggplot(data = diamonds[diamonds$cut == 'Fair',], aes(x=carat, y=price)) + ylim(0, 40000) + xlim(0, 5.1) + geom_point(alpha = 0.5)
                
                if (input$checkbox) g <- g + geom_point(aes(color = color, alpha = 0.5), data = diamonds)
                g<-g+geom_abline(intercept = modelFair$coefficients[1], slope = modelFair$coefficients[2], color = "blue", lwd = 1)
                g<- g + labs(title = "Fair Cut", caption = "PRICE VS CARAT FOR FAIR CUT") 
                if (input$showPred) { value <- predict(modelFair, newdata = data.frame(carat = input$carat))
                g<- g+geom_point(aes(y=value, x=input$carat), size= 4, shape = 19, color = "red", fill = "red") }
                }
                
                else if (input$cut == 1) { g <- ggplot(data = diamonds[diamonds$cut == 'Good',], aes(x=carat, y=price)) + ylim(0, 40000) + xlim(0, 5.1) + geom_point(alpha = 0.5)
                if (input$checkbox) g <- g + geom_point(aes(color = color, alpha = 0.5), data = diamonds)
                g<-g+geom_abline(intercept = modelGood$coefficients[1], slope = modelGood$coefficients[2], color = "blue", lwd = 1)
                g<- g + labs(title = "Good Cut", caption = "PRICE VS CARAT FOR GOOD CUT") 
                if (input$showPred) { value <- predict(modelGood, newdata = data.frame(carat = input$carat))
                g<- g+geom_point(aes(y=value, x=input$carat), size= 4, shape = 19, color = "red", fill = "red") }
                }
                
                else if (input$cut == 2) {g <- ggplot(data = diamonds[diamonds$cut == 'Very Good',], aes(x=carat, y=price)) + ylim(0, 40000) + xlim(0, 5.1)+ geom_point(alpha = 0.5)
                if (input$checkbox) g <- g + geom_point(aes(color = color, alpha = 0.5), data = diamonds)
                g<-g+geom_abline(intercept = modelVeryGood$coefficients[1], slope =modelVeryGood$coefficients[2], color = "blue", lwd = 1)
                g<- g + labs(title = "Very Good Cut", caption = ("PRICE VS CARAT FOR VERY GOOD CUT"))
                if (input$showPred) { value <- predict(modelVeryGood, newdata = data.frame(carat = input$carat))
                g<- g+geom_point(aes(y=value, x=input$carat), size= 4, shape = 19, color = "red", fill = "red") }
                }
                
                else if (input$cut == 3) { g<- ggplot(data = diamonds[diamonds$cut == 'Premium',], aes(x=carat, y=price)) + ylim(0, 40000) + xlim(0, 5.1)+ geom_point(alpha = 0.5)
                if (input$checkbox) g <- g + geom_point(aes(color = color, alpha = 0.5), data = diamonds)
                g<-g+geom_abline(intercept = modelPremium$coefficients[1], slope = modelPremium$coefficients[2], color = "blue", lwd = 1)
                g<- g + labs(title = "Premium Cut", caption = "PRICE VS CARAT FOR PREMIUM CUT") 
                if (input$showPred) { value <- predict(modelPremium, newdata = data.frame(carat = input$carat))
                g<- g+geom_point(aes(y=value, x=input$carat), size= 4, shape = 19, color = "red", fill = "red") }
                }
                
                else if (input$cut == 4){ g <- ggplot(data = diamonds[diamonds$cut == 'Ideal',], aes(x=carat, y=price)) + ylim(0, 40000) + xlim(0, 5.1)+ geom_point(alpha = 0.5)
                if (input$checkbox) g <- g + geom_point(aes(color = color, alpha = 0.5), data = diamonds)
                g<-g+geom_abline(intercept = modelIdeal$coefficients[1], slope = modelIdeal$coefficients[2], color = "blue", lwd = 1)
                g<- g + labs(title = "Ideal Cut", caption = "PRICE VS CARAT FOR IDEAL CUT") 
                if (input$showPred) { value <- predict(modelIdeal, newdata = data.frame(carat = input$carat))
                g<- g+geom_point(aes(y=value, x=input$carat), size= 4, shape = 19, color = "red", fill = "red") }
                }
                print(g)
                
        })
        
})
