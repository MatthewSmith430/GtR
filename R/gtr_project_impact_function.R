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
  if(purrr::is_empty(imp_df)){
    imp_df<-dplyr::tibble(imp_df,project=pt,project_id=pti)
  }else{
    imp_df<-dplyr::mutate(imp_df,project=pt,project_id=pti)
  }

  return(imp_df)
}
