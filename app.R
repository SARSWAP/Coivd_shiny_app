library(shiny)
library(later)
library(shinydashboard)
source("script.R")

ui <- dashboardPage(
  dashboardHeader(title = "2022 Covid stats"),
  
  dashboardSidebar(sidebarMenu(
    menuItem(
      "Cases By Country",
      tabName = "tab1",
      icon = icon("globe")
    ),
    menuItem(
      "Cases World",
      tabName = "tab2",
      icon = icon("virus-covid")
    ),
    menuItem(
      "Vaccinations By country",
      tabName = "tab3",
      icon = icon("syringe")
    ),
    menuItem(
      "vaccination world",
      tabName = "tab4",
      icon = icon("syringe")
    )
  )),
  
  dashboardBody(tabItems(
    tabItem(tabName = "tab1",
            sidebarLayout(
              sidebarPanel(
                selectInput(
                  inputId = "countrychoose",
                  label = "country",
                  choices = unique(covid$location)
                )
              ),
              mainPanel(plotlyOutput(
                "plot1", height = 600, width = 800
              ))
            )),
    tabItem(tabName = "tab2",
            box(
              plotOutput("plot2", height = 600, width = 800)
            ))
    ,
    tabItem(tabName = "tab3",
            sidebarLayout(
              sidebarPanel(
                selectInput(
                  inputId = "vac_country",
                  label = "country",
                  choices = unique(covid$location)
                )
              ),
              mainPanel(plotlyOutput(
                "plot3", height = 600, width = 800
              ))
            )),
    tabItem(tabName = "tab4",
            fluidRow(box(
              plotOutput("plot4", height = 700, width = 900)
            )))
  ))
)


server <- function(input, output, session) {
  shiny.auto <- function(interval = 18 * 60 * 60) {
    source("script.R")
    later::later(shiny.auto, interval)
  }
  output$plot1 <-renderPlotly(ggplotly(casevdeath_plot_country(countryfn(input$countrychoose))))
  output$plot2 <- renderPlot(casevdeath_plot_W)
  output$plot3 <- renderPlotly(ggplotly(vaccination_plot(countryfn(input$vac_country))))
  output$plot4 <- renderPlot(vaccination_plot_W)
  
}

shinyApp(ui, server)
