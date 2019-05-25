library(shiny)

shinyUI(fluidPage(
    titlePanel("Will I survive Titanic's maiden voyage?"),
    tags$head(tags$style(
        type = "text/css",
        "#image img {max-width: 100%; width: 100%; height: auto}"
    )),
    sidebarLayout(
        sidebarPanel(
            p("It's 1912 and you're considering buying a ticket for Titanic's maiden voyage."),
            p("Select your personal characteristics and see your chances of survival."),
            selectInput("ses", "Socio-Economic Status:", 
                        choices = list("lower" = "Lower", "middle" = "Middle", "upper" = "Upper"), 
                        selected = "Lower"),
            radioButtons("sex", "Sex:",
                         choices = list("female", "male"), selected = "male"),
            sliderInput("age", "Age:", 
                        min = 1, max = 80, value = 20)
        ),
        mainPanel(
            htmlOutput("resultDescription")
        )
    )
))
