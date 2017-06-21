#!/usr/bin/env Rscript
main <- function(env){
body = paste('<h1>Hello World! This is Rook',env$rook.version,'.</h1>')
list(
status = 200L,
headers = list(
'Content-Type' = 'text/html'
),
body = body
)
}

if(!interactive()) {
    main(globalenv())
}

iter <- 0

Rook.app <- function(env) {
    iter <<- iter + 1

    request <- Request$new(env)
    response <- Response$new()

    # write.initial.HTML(response, iter)
    write.icebreaker.HTML(request, response)
    # write.iris.HMTL(request, response, R.server)
    # write.final.HTML(response)

    response$finish()
}


write.icebreaker.HTML <- function(request, response) {
    #if ("firstname" %in% names(request$POST()) & "favnumber" %in% names(request$POST())) {
        response$write("Your personalized icebreaker")
        response$write(paste("Hi, my name is ", "request$POST()$firstname", ".", sep = ""))

        # fav.number = as.numeric(request$POST()$favnumber)

        response$write(paste("My favorite number, plus 1, is ", "as.character(fav.number + 1)", ".", sep = ""))
    #}
}

exit <- function() {
  .Internal(.invokeRestart(list(NULL, NULL), NULL))
}

library(Rook)
s <- Rhttpd$new()
s$start(quiet=TRUE, port=80)
s$print()

while (TRUE) {
    Sys.sleep(0.5);
}
exit()

#install.packages("Rook", repos = "http://cran.us.r-project.org")

# setInternet2(TRUE)  # if you're behind a firewall
# install.packages("Rook")
library(Rook)
R.server <- Rhttpd$new()
cat("Type:", typeof(R.server), "Class:", class(R.server))

# main(globalenv())



R.server$add(app = Rook.app, name = "lfltscrpr")
#print(R.server)

#R.server$browse("lfltscrpr")
R.server$start(port = 80)

while (TRUE) {
    Sys.sleep(0.5);
}
# suspend_console()
