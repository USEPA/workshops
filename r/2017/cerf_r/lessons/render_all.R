render_all<-function(path=".",pattern="*.Rmd"){
  files <- list.files(path,pattern,full.names = T)
  for(i in files){
    out <- stringr::str_replace(i,"Rmd","md")
    out_html <- stringr::str_replace(i,"Rmd","html")
    if(!file.exists(out) | !file.exists(out_html) ){
      knitr::knit(i,output=out)
      knitr::knit(i,output=out_html)
    } else if((file.info(i)$mtime-file.info(out)$mtime)>0){
      knitr::knit(i,output=out)
    } else if((file.info(i)$mtime-file.info(out_html)$mtime)>0){
      knitr::knit(i,output=out_html)
    }
  }
}