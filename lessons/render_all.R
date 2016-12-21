files <- list.files(pattern = "*.Rmd")
for(i in files){
  knitr::knit(i)
  #rmarkdown::render(i,output_format = "pdf_document")
}