library(shiny)

shinyUI(fluidPage(

    titlePanel("Social Media Helper"),

    sidebarLayout(
        sidebarPanel(
           textInput("handle", "Handle"),
           radioButtons("medium", "Medium:",
                        c("LinkedIn" = "linkedin",
                          "Twitter" = "twitter")),
           uiOutput("taggings"),
           actionButton("create_user", "Save"),
        ),

        
        mainPanel(
            dataTableOutput("users")
        )
    )
))
