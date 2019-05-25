library(shiny)
library(titanic)
library(dplyr)


data.train <- 
    titanic_train %>%
    mutate(
        Sex = factor(Sex, levels = c("female", "male")),
        Pclass = factor(Pclass, levels = 1:3, labels = c("Upper", "Middle", "Lower"))
    ) %>%
    select(Pclass, Sex, Age, Survived) %>%
    filter(complete.cases(.))

model <- glm(Survived ~ ., family = binomial(link = 'logit'), data = data.train)

calculate <- function(pclass, sex, age) {
    data.predict <- data.frame(Pclass = pclass, Sex = sex, Age = age)
    predict(model, data.predict, type = 'response')    
}

shinyServer(function(input, output) {
    output$resultDescription <- renderUI({
        prediction <- calculate(input$ses, input$sex, input$age)
        HTML(paste0(
            "<center>",
            "<img src='titanic.png' style='max-width:100%'>",
            "If you're ", "<b>", input$age, " years old ", input$sex, "</b>",
            " and have a ", "<b>", input$ses, " Socio-Economic Status", "</b>", 
            " then the probability of surviving a Titanic maiden voyage is:", "<br>",
            "<h1>", round(100*prediction, 0), "%</h1>", 
            "</center>"
        ))
    })
})
