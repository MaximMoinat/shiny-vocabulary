library(shiny)
library(rpivotTable)

ui <- navbarPage(
  
  title = "Vocabulary v5.0 Oct-17",
  
  tabPanel("", 
           rpivotTableOutput("default"),
           icon = icon("home")
  ),
  tabPanel("Standard Concepts per Domain and Vocabulary",
           rpivotTableOutput("StandardConcepts")
  ),
  tabPanel("RxNorm",
           rpivotTableOutput("rxnorm")
  ),
  tabPanel("Standards per vocabulary",
           rpivotTableOutput("standardChart")
  )
)

server <- function(input, output) {
  vocabData <- reactive({
    read.csv("stratified_concepts.csv")
  })
  
  output$default <- renderRpivotTable(
    rpivotTable(data = vocabData(), vals = "CONCEPT_COUNT", aggregatorName = "Integer Sum")
  )
  
  output$StandardConcepts <- renderRpivotTable(
    rpivotTable(
      data = vocabData(), 
      rows = "DOMAIN_ID", 
      cols = "VOCABULARY_ID", 
      vals = "CONCEPT_COUNT", 
      aggregatorName = "Integer Sum",
      rendererName = "Row Heatmap",
      inclusions = list(
        STANDARD_CONCEPT="S", 
        DOMAIN_ID=c("Condition", 'Device', 'Drug', 'Procedure', 'Measurement', 'Observation', 'Unit')
      ),
      exclusions = list(
        VOCABULARY_ID=c("UB04 Pri Typ of Adm", "VOCABULARY")
      )
    )
  )
  output$rxnorm <- renderRpivotTable(
    rpivotTable(
      data = vocabData(), 
      rows = "CONCEPT_CLASS_ID", 
      cols = "VOCABULARY_ID", 
      vals = "CONCEPT_COUNT", 
      aggregatorName = "Sum as Fraction of Total",
      inclusions = list(
        VOCABULARY_ID = c('RxNorm', 'RxNorm Extension')
      )
    )
  )
  
  output$standardChart <- renderRpivotTable(
    rpivotTable(
      data = vocabData(), 
      rows = "STANDARD_CONCEPT", 
      cols = "VOCABULARY_ID", 
      vals = "CONCEPT_COUNT", 
      aggregatorName = "Integer Sum",
      rendererName = "Stacked Bar Chart"
    )
  )
}

shinyApp(ui, server)