library(shiny)
library(shinydashboard)
library(DT)
library(data.table)
library(modules)

data <- modules::use("data.R")

print(data)
shinyServer(function(input, output) {

    output$taggings <- renderUI({
        tags <- data$getTags()
        checkboxGroupInput("tags", "Tags:", tags)
    })
    
    output$users <- renderDataTable({
        users <- data$getUsers()
        datatable(users,escape = F, options = list(scrollX = T, ordering = F))
    })
    
    observeEvent(input$create_user, {
        data$saveUser(input$handle,input$medium,input$tags)
    })

})
