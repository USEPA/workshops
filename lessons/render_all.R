#' Render All
#' @param dir directory, defaults to current
#' @export
render_all <- function(dir = "."){
  rmds <- list.files(dir, ".Rmd",full.names = TRUE)
  for(i in rmds){
    out_i <- gsub(".Rmd",".md",i)
    knitr::knit(i,out_i)
    rmarkdown::render(i,"pdf_document")
  }
}