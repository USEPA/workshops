render_all<-function(path=".",pattern="*.Rmd"){
  files <- list.files(path,pattern,full.names = T)
  for(i in files){
    out <- stringr::str_replace(i,"Rmd","md")
    knitr::knit(i,output=out)
  }
}