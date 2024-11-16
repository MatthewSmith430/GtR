#' @title gtr_spin_out
#'
#' @description This function returns a 1 if a project has a spin out and 0 otherwise
#' @param url project URL from gtr.ukri.org
#' @export
#' @return Dataframe with project id and whether it has a spin out
gtr_spin_out<-function(url){
  firmTEST<-httr::GET(url,httr::add_headers("Accept: application/vnd.rcuk.gtr.json-v7"))
  firmTEXT<-httr::content(firmTEST, as="text")
  JLfirm<-jsonlite::fromJSON(firmTEXT, flatten=TRUE)

  ORG<-JLfirm$projectOverview$projectComposition
  proj_id<-ORG$project$grantReference

  imp<-ORG$project$output

  spin_df<-imp$spinOutOutput

  CHECK<-purrr::is_empty(spin_df)

  if(CHECK==TRUE){
    SPIN_RES<-0
  }else{
    SPIN_RES<-1
  }

  SPIN_RES_DF<-data.frame(project_id=proj_id,
                          spin_out=SPIN_RES)
  return(SPIN_RES_DF)
}
