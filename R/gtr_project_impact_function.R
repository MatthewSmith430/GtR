#' @title gtr_project_impact
#'
#' @description This function extracts project impact information
#' @param url project URL from gtr.ukri.org
#' @export
#' @return Dataframe of project impact

gtr_project_impact<-function(url){
  firmTEST<-httr::GET(url)
  firmTEXT<-httr::content(firmTEST, as="text")
  JLfirm<-jsonlite::fromJSON(firmTEXT, flatten=TRUE)

  ORG<-JLfirm$projectOverview$projectComposition

  pt<-ORG$project$title
  pti<-ORG$project$id
  imp<-ORG$project$output
  imp_df<-purrr::map_df(imp,data.frame)
  imp_df<-dplyr::mutate(project=pt,project_id=pti,
                        potential_impact_statement=ORG$project$potentialImpactText)
  return(imp_df)
}
