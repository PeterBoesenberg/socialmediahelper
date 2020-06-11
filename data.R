import(data.table)
import(mongolite)
import(jsonlite)
import(config)

config <- config::get()

mongo_url <- config$mongo_url
export("getUsers", "saveUser", "getTags", "saveTag", "getUsersForPost")
db <- "socialmediahelper"
mongo_users <- mongo(collection = "users", db = db, url=mongo_url)
mongo_tags <-mongo(collection = "tags", db = db, url=mongo_url)


getTags <- function() {
  tags <- data.table(mongo_tags$find("{}"))
  if(ncol(tags) > 0 ) {
    return(as.vector(tags[,1]))
  }
}

saveTag <- function(tag) {
  dt <- data.table(name=tag)
  query <- toJSON(dt)
  
  query <- substring(query, 2, (nchar(query)-1))
  mongo_tags$insert(query) 
}

getUsers <- function() {
  users <- mongo_users$find("{}")

  data.table(users)
}

saveUser <- function(handle, medium, tags = c("")) {
  if(substr(handle, 1,1) != "@") {
    handle <- paste0("@", handle)
  }
  tags <- paste(tags, collapse=",")

  dt <- data.table(handle=handle, medium=medium, tags=tags)
  query <- toJSON(dt)

  query <- substring(query, 2, (nchar(query)-1))
  mongo_users$insert(query)
}


getUsersForPost <- function(users, taggings, med, count) {
  filtered <- users[grep(taggings, users$tags)][medium==med]
  if(nrow(filtered) > count) {
    filtered <- filtered[sample(.N,count)]
  }
  filtered[, handle]
}
