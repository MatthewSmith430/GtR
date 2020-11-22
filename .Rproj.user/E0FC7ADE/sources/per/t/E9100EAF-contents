#' @title gtr_further_funding
#'
#' @description This function extracts further funding information for a project
#' @param url project URL from gtr.ukri.org
#' @export
#' @return Dataframe with follow up funding
gtr_further_funding<-function(url){
  firmTEST<-httr::GET(url)
  firmTEXT<-httr::content(firmTEST, as="text")
  JLfirm<-jsonlite::fromJSON(firmTEXT, flatten=TRUE)

  ORG<-JLfirm$projectOverview$projectComposition
  proj_id<-ORG$project$grantReference
  imp<-ORG$project$output
  funding_df<-imp$furtherFundingOutput
  funding_df<-dplyr::mutate(funding_df,project_id=proj_id)
  fd_cn<-colnames(funding_df)
  SC<-"start"%in%fd_cn
  EC<-"end"%in%fd_cn
  if (SC==FALSE){
    funding_df<-dplyr::mutate(funding_df,start=NA)
  }else{
    funding_df<-funding_df
  }
  if (EC==FALSE){
    funding_df<-dplyr::mutate(funding_df,end=NA)
  }else{
    funding_df<-funding_df
  }
  FDF<-dplyr::select(funding_df,
                     project_id,fundingOrg,
                     amountPounds,sector,
                     #fundingRef,
                     description,currCountryCode,
                     country,start,end)
  FDF_S<-dplyr::select(FDF,fundingOrg,amountPounds)
  FDF_S1<-dplyr::group_by(FDF_S,fundingOrg)
  TOTAL_FUND<-dplyr::summarise(FDF_S1,total_awarded = sum(amountPounds))

  FDF2<-merge(FDF,TOTAL_FUND,by="fundingOrg")

  return(FDF2)
}
