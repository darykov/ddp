# User Interface file

library(shiny)
library(ggplot2)
data("diamonds")

# Define UI for the application
shinyUI(fluidPage(
        
        # Application title
        titlePanel("Predicting Price of Diamonds based on carat by cut"),
        
        # Sidebar with a slider input for predictions, 2 checkboxes & drop-down menu
        sidebarLayout(
                sidebarPanel(
                        
                        selectInput("cut", label = h4("Select cut:"),
                                    choices = list("Fair" = 0,"Good" = 1, "Very Good" = 2, "Premium" = 3, "Ideal"= 4), selected = 0),
                        
                        checkboxInput(inputId =  "checkbox", label = h4("Show Diamond Color"), value = FALSE) ,
                        
                        sliderInput("carat", label = "Enter carats", min = 0.2, max = 5.01, step = 0.1, value = 2.0),
                        
                        checkboxInput(inputId =  "showPred", label = h4("Show Predicted Point"), value = FALSE), 
                        submitButton()
                        
                ),
                
                
                # Show the output
                mainPanel(
                        #Create tabs for prediction and another tab for instructions
                        tabsetPanel(type = "tabs",
                                    tabPanel("Plot & Prediction", plotOutput('distPlot'),
                                             h4('Carats Entered'), textOutput('carats'),
                                             
                                             h4('Predicted Price is'), textOutput("prediction")),
                                    tabPanel("Instructions", br(),
                                             p("Diamonds library from the ggplot2 dataset is used by the app.
                                                The app fits a number of simple linear regression models 
                                                predicting the price of diamonds based on carats, one model is
                                                fitted for each level of cut."),
                                             
                                             h5("Instructions:"),
                                             p("Select the cut from the drop-down menu. The appropriate price vs. carat 
                                                graph will be created, along with the line fitted for that 
                                                cut."), 
                                             p("When the Show Diamond Color checkbox is selected,                                                  
                                                the points in the graph will be colored based on the diamonds color 
                                                (from J (worst), to D (best)) in the diamonds dataset. Using this checkbox has no 
                                                  effect on the fitted model."), 
                                             p("When Show Predicted Point is selected the predicted point is shown 
                                                on the fitted line. 
                                                One may choose different prediction points by using the carat slider
                                                or choose different cut level to display the prediction & corresponding model for a different level of cut.
                                                The system will use the already selected point for a new prediction based on newly selected cut.
                                                "), p("Please note that Apply Changes button needs to be pressed for the changes to make effect."),
                                                
                                                p("The code for the app may be found at:"), HTML("https://github.com/darykov/ddp"))
                        )
                )
        )
        
))

