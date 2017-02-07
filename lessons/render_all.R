files <- list.files(pattern = "*.Rmd")
for(i in files){
  rmd_time <- file.info(i)
  md_time <- file.info(gsub(".Rmd",".md",i))
  if(is.na(md_time$mtime)) {md_time$mtime <- 0}
  if(md_time$mtime <= rmd_time$mtime){
    knitr::knit(i)
    rmarkdown::render(i,output_format = "pdf_document")
  }
}