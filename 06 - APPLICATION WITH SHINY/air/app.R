library(shiny)

data("airquality", package = "datasets")
names(airquality)

vars<-setdiff(names(airquality), "Ar")

#Interface Gráfica IU
ui<-pageWithSidebar(
  headerPanel("Qualidade do Ar"),
  sidebarPanel(
    selectInput("colx", "variávelx", vars),
    selectInput("coly", "variávely", vars)
  ),
  mainPanel(plotOutput("plot1"))
)


#Cálculos
server<-function(input, output){
  selectedData<-reactive({
    airquality[,c(input$colx, input$coly)]
  })
  output$plot1<-renderPlot(plot(selectedData()))
}


shinyApp(ui, server)
