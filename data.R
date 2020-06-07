import(data.table)
import(mongolite)
import(jsonlite)

export("getUsers", "saveUser", "getTags")
db <- "socialmediahelper"
mongo_users <- mongo(collection = "users", db = db)
mongo_tags <-mongo(collection = "tags", db = db)


getTags <- function() {
  tags <- mongo_tags$find("{}")
  print(as.vector(tags[,1]))
  as.vector(tags[,1])
}

getUsers <- function() {
  users <- mongo_users$find("{}")

  data.table(users)
}

saveUser <- function(handle, medium, tags = c("")) {
  if(substr(handle, 1,1) != "@") {
    handle <- paste0("@", handle)
  }

  dt <- data.table(handle=handle, medium=medium, tags=tags)
  query <- toJSON(dt)

  query <- substring(query, 2, (nchar(query)-1))
  mongo_users$insert(query)
}
