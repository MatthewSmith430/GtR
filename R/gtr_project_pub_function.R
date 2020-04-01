#' @title gtr_project_pub
#'
#' @description This function extracts pulciation output for a project
#' @param url project URL from gtr.ukri.org
#' @export
#' @return Dataframe with publication
gtr_project_pub<-function(url){
  firmTEST<-httr::GET(url)
  firmTEXT<-httr::content(firmTEST, as="text")
  JLfirm<-jsonlite::fromJSON(firmTEXT, flatten=TRUE)

  ORG<-JLfirm$projectOverview$projectComposition
  PUB<-ORG$project$publication
  if (purrr::is_empty(PUB)==TRUE){
    PUB<-dplyr::tibble(id=url,pub=0)
  }else{PUB<-PUB}
  return(PUB)
}
