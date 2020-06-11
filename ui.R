library(shiny)
library(shinyjs)

shinyUI(fluidPage(
    useShinyjs(),
    titlePanel("Social Media Helper"),
    fluidRow(
        column(4,
               uiOutput("postTaggings"),
        ),
        column(4,
               radioButtons("postMedium", "Medium:",
                            c("LinkedIn" = "linkedin",
                              "Twitter" = "twitter")),
        ),
        column(4,
               sliderInput("postPeople", "People for post:",
                           min = 0, max = 10,
                           value = 5),
        ),
    ),
    fluidRow(
        column(2,
               actionButton("get_post", "Get Post"),
        ),
        column(12,
               wellPanel(
                   h3("Result to copy&paste"),
                   textOutput("post")
               )
        )
        
    ),
    
    sidebarLayout(
        sidebarPanel(
            textInput("handle", "Handle"),
            radioButtons("medium", "Medium:",
                         c("LinkedIn" = "linkedin",
                           "Twitter" = "twitter")),
            uiOutput("taggings"),
            actionButton("create_user", "Save User"),
            
            textInput("tag", "Tag"),
            actionButton("create_tag", "Save Tag")
        ),
        
        
        mainPanel(
            dataTableOutput("users")
        )
    )
))
