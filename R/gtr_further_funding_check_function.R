#' @title gtr_further_funding_check
#'
#' @description This function checks whether a project receives further funding
#' @param url project URL from gtr.ukri.org
#' @export
#' @return TRUE/FALSE follow up funding
gtr_further_funding_check<-function(url){
  firmTEST<-httr::GET(url,httr::add_headers("Accept: application/vnd.rcuk.gtr.json-v7"))
  firmTEXT<-httr::content(firmTEST, as="text")
  JLfirm<-jsonlite::fromJSON(firmTEXT, flatten=TRUE)

  ORG<-JLfirm$projectOverview$projectComposition
  proj_id<-ORG$project$grantReference
  imp<-ORG$project$output
  funding_df<-imp$furtherFundingOutput
  CHECK1<-is.data.frame(funding_df)

  if(CHECK1==TRUE){
    FUR<-TRUE
  }else{
    FUR<-FALSE
  }

  return(FUR)
}
