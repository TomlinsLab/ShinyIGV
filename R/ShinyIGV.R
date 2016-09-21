library(htmlwidgets)

ShinyIGV <- function(tracks,search=NULL,ref,range=NULL,width=NULL,height=NULL){
  if (is.vector(range)){
    if (!is.null(search)) {
      stop("You cannot pass both a search coordinate, and a search range")
    }
    if (!all.equal(names(range),c("chr","start","stop"))) {
      stop("Improperly formatted range. Range should have format c(chr=chr,start=start,stop=stop")
    }
    search = paste(tolower(range['chr']),paste(prettyNum(range['start'],big.mark = "," ),prettyNum(range['stop'],big.mark = ","),sep="-"),sep=":")
  }
  if (is.character(ref)) {
    ref = list(id=ref)
  }
  if (!is.list(ref)) {
    stop("You must provide either a list providing a proper representation of a reference genome, or a valid UCSC identifier.")
  }
  data = list(
    tracks=tracks,
    search=search,
    ref=ref
  )
  htmlwidgets::createWidget("ShinyIGV", data, width = width, height = height)
}

shinyIGVOutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(outputId, "ShinyIGV", width, height, package = "ShinyIGV")
}
#' @export
renderShinyIGV <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, shinyIGVOutput, env, quoted = TRUE)
}
