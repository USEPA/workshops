files <- list.files(pattern = "*.Rmd")
for(i in files){
  rmd_time <- file.info(i)
  md_time <- file.info(gsub(".Rmd",".md",i))
  if(md_time$mtime <= rmd_time$mtime){
    knitr::knit(i)
    rmarkdown::render(i,output_format = "pdf_document")
  }
}