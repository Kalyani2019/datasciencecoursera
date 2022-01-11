library(shiny) 
shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Credit Risk Calculation and Interpretation"),
    
    sidebarPanel(
      numericInput('Risk Factor1', 'Enter Risk factor 1', 0.8,min = 0, max = 1, step = 0.1) ,
      numericInput('Risk Factor 2', 'Enter Risk factor 2', 0.99, min = 0, max = 1, step = 0.1),
      numericInput('Risk Factor 3', 'Enter Risk factor 3',0.6, min = 0, max = 1, step = 0.1)
    ), 
    mainPanel(
      p('Insurance companies Ratings are determined based on their Risk factors calculated by Models'),
      p('The outcome of the risk factors was interpreted as follows:'),
      tags$div(
        tags$ul(
          tags$li('Average <0.5,       : Rating: B-'),
          tags$li('Average [0.5-0.8] , : Rating: B+'),
          tags$li('Average [0.81-0.89] ,   :Rating: A'),
          tags$li('Average >= 0.9 : Rating A+')
        )
      ),
      
      h4('Taking into account the Risk Factors calculated by Model:'), 
      p('Risk Factor 1:'), verbatimTextOutput("inputRiskFactor1"),
      p('Risk Factor 2:'), verbatimTextOutput("inputRiskFactor2"),
      p('Risk Factor 3:'), verbatimTextOutput("inputRiskFactor3"),h4('Your calulated Credit Rating is:'),
      verbatimTextOutput("estimation"),
      p('It means that you have:'),strong(verbatimTextOutput("diagnostic"))
      
    )
    
  )   
)
