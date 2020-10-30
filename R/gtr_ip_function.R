#' @title gtr_ip
#'
#' @description This function extracts IP project information
#' @param url project URL from gtr.ukri.org
#' @export
#' @return Dataframe with projects and all organisaitonal collaborators
gtr_ip<-function(url){
  firmTEST<-httr::GET(url)
  firmTEXT<-httr::content(firmTEST, as="text")
  JLfirm<-jsonlite::fromJSON(firmTEXT, flatten=TRUE)

  ORG<-JLfirm$projectOverview$projectComposition
  proj_id<-ORG$project$grantReference

  imp<-ORG$project$output

  ip_df<-imp$intellectualPropertyOutput

  ip_df<-dplyr::mutate(ip_df,project_id=proj_id,
                       ip_category=protection)
  patent_id<-ip_df$patentId

  ip_df<-dplyr::select(ip_df,project_id,ip_category,
                       description,protection,yearProtectionGranted,
                       licensed)



  PC<-purrr::is_empty(patent_id)

  if (PC==TRUE){
    patent_id_data<-rep(NA,length(ip_df$project_id))

  }else{
    patent_id_data<-patent_id
  }

  ip_df<-dplyr::mutate(ip_df,patent_id=patent_id_data)

  return(ip_df)
}
