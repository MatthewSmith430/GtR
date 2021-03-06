#' @title gtr_further_funding
#'
#' @description This function checks whether a project receives further fudning
#' @param url project URL from gtr.ukri.org
#' @export
#' @return TRUE/FALSE for follow up funding
gtr_further_funding_check<-function(url){
  firmTEST<-httr::GET(url)
  firmTEXT<-httr::content(firmTEST, as="text")
  JLfirm<-jsonlite::fromJSON(firmTEXT, flatten=TRUE)

  ORG<-JLfirm$projectOverview$projectComposition
  proj_id<-ORG$project$grantReference
  imp<-ORG$project$output
  funding_df<-imp$furtherFundingOutput
  CHECK<-is.list(funding_df)
  if (CHECK==TRUE){
    FUR<-FALSE

  }else{FUR<-TRUE}


  return(FUR)
}
