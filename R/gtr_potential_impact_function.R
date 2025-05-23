#' @title gtr_potential_impact
#'
#' @description This function extracts potential project impact statement
#' @param url project URL from gtr.ukri.org
#' @export
#' @return Dataframe of potential project impact

gtr_potential_impact<-function(url){
  firmTEST<-httr::GET(url,httr::add_headers("Accept: application/vnd.rcuk.gtr.json-v7"))
  firmTEXT<-httr::content(firmTEST, as="text")
  JLfirm<-jsonlite::fromJSON(firmTEXT, flatten=TRUE)

  ORG<-JLfirm$projectOverview$projectComposition

  pt<-ORG$project$title
  pti<-ORG$project$id

  pot_imp<-ORG$project$potentialImpactText
  if(purrr::is_null(pot_imp)==TRUE){
    pot_imp<-NA
  }else{pot_imp<-pot_imp}

  potential_imp<-dplyr::tibble(project=pt,project_id=pti,
                               potential_impact_statement=pot_imp)

  return(potential_imp)
}

