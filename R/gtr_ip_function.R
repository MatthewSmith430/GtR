#' @title gtr_ip
#'
#' @description This function extracts IP project information
#' @param url project URL from gtr.ukri.org
#' @export
#' @return Dataframe with projects and all organisaitonal collaborators
gtr_ip<-function(url){
  firmTEST<-httr::GET(url,httr::add_headers("Accept: application/vnd.rcuk.gtr.json-v7"))
  firmTEXT<-httr::content(firmTEST, as="text")
  JLfirm<-jsonlite::fromJSON(firmTEXT, flatten=TRUE)

  ORG<-JLfirm$projectOverview$projectComposition
  proj_id<-ORG$project$grantReference

  imp<-ORG$project$output

  ip_df<-imp$intellectualPropertyOutput

  CHECK<-purrr::is_empty(ip_df)

  if (CHECK==TRUE){
    ip_df<-data.frame(project_id=proj_id,
                      ip_category=NA,
                      description=NA,
                      protection=NA,
                      yearProtectionGranted=NA,
                      licensed=NA,
                      patent_id=NA)
  }else{
    ip_df<-dplyr::mutate(ip_df,project_id=proj_id,
                         ip_category=protection)
    patent_id<-ip_df$patentId

    HHH<-colnames(ip_df)

    YC<-"yearProtectionGranted" %in% HHH
    LEN<-length(ip_df$id)
    NA_info<-rep(NA,LEN)
    if (YC==FALSE){
      ip_df<-dplyr::mutate(ip_df,yearProtectionGranted=NA_info)
    }else{
      ip_df<-ip_df
    }

    DC<-"description"%in%HHH

    if (DC==FALSE){
      ip_df<-dplyr::mutate(ip_df,description=NA_info)
    }else{
      ip_df<-ip_df
    }

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
  }



  return(ip_df)
}
