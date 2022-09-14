library(shiny)
library(later)
library(shinydashboard)
source("script.R")

ui <- dashboardPage(
  dashboardHeader(title = "2022 Covid stats"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Cases India", tabName = "tab1", icon = icon("globe")),
      menuItem("Cases World", tabName = "tab2", icon = icon("virus-covid")),
      menuItem("Vaccination India", tabName = "tab3", icon = icon("syringe")),
      menuItem("vaccination world",tabName = "tab4",icon = icon("syringe"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "tab1",
              fluidRow(
                box(plotOutput("plot1",height = 700,width = 900))
              )
      ),
      tabItem(tabName = "tab2",
              fluidRow(
                box(plotOutput("plot2",height = 700,width = 900))
              )
      ),
      tabItem(tabName = "tab3",
              fluidRow(
                box(plotOutput("plot3",height = 700,width = 900))
              )),
      tabItem(tabName = "tab4",
              fluidRow(
                  box(plotOutput("plot4",height = 700,width = 900))
      )
      )
      )
    
  )
)

server <- function(input, output, session) {
  shiny.auto <- function(interval = 18*60*60){
    source("script.R")
    later::later(shiny.auto, interval)
  }
  output$plot1 <- renderPlot(casevdeath_plot_IN)
  output$plot2 <- renderPlot(casevdeath_plot_W)
  output$plot3 <- renderPlot(vaccination_plot)
  output$plot4 <- renderPlot(vaccination_plot_W)
  
}

shinyApp(ui, server)
