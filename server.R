library(shiny)
library(shinydashboard)
library(shinyjs)
library(DT)
library(data.table)
library(modules)

data <- modules::use("data.R")

shinyServer(function(input, output) {
    clearInputs <- function() {
        reset("tags")
        reset("posttags")
        reset("postMedium")
        reset("postPeople")
        reset("handle")
        reset("tag")
    }
    reac <- reactiveValues(
        tags = data$getTags(),
        users = data$getUsers()
    )

    refreshAllData <- function() {
        reac$tags = data$getTags()
        reac$users = data$getUsers()
    }
    
    output$taggings <- renderUI({
        tags <- reac$tags
        selectInput("tags", "Tag:", tags)
    })
    output$postTaggings <- renderUI({
        tags <- reac$tags
        selectInput("posttags", "Tag:", tags)
    })
    
    output$users <- renderDataTable({
        users <- reac$users
        datatable(users,escape = F, options = list(scrollX = T, ordering = F))
    })
    
    observeEvent(input$create_user, {
        data$saveUser(input$handle,input$medium,input$tags)
        refreshAllData()
        clearInputs()
    })
    
    observeEvent(input$create_tag, {
        data$saveTag(input$tag)
        refreshAllData()
        clearInputs()
    })
    
    observeEvent(input$get_post, {
        users <- data$getUsersForPost(reac$users, input$posttags, input$postMedium, input$postPeople)
        output$post <- renderText({
            users
        })
    })
})
