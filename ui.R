library(shiny)
library(rpivotTable)

ui <- navbarPage(

  title = "Vocabulary v5.0 21-DEC-20",

  tabPanel("",
           rpivotTableOutput("default"),
           icon = icon("home")
  ),
  tabPanel("Standard Concepts per Domain and Vocabulary",
           rpivotTableOutput("StandardConcepts")
  ),
  tabPanel("Treemap per Domain and Vocabulary",
           rpivotTableOutput("breakdown")
  ),
  tabPanel("RxNorm",
           rpivotTableOutput("rxnorm")
  ),
  tabPanel("Standards per vocabulary",
           rpivotTableOutput("standardChart")
  ),
  tabPanel("Relationships between vocabularies",
           rpivotTableOutput("relationFromTo")
  )
)