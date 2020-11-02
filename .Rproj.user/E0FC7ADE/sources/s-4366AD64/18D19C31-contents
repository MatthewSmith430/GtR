#' @title gtr_pub_df
#'
#' @description This function extracts publication information, number of journal articles published in a particular journal per year
#' @param url project URL from gtr.ukri.org
#' @export
#' @return Dataframe with project_id, journal title, year, number of publications in that journal for a particular year

gtr_pub_df<-function(url){
  firmTEST<-httr::GET(url)
  firmTEXT<-httr::content(firmTEST, as="text")
  JLfirm<-jsonlite::fromJSON(firmTEXT, flatten=TRUE)

  ORG<-JLfirm$projectOverview$projectComposition
  proj_id<-ORG$project$grantReference
  #COL<-ORG$project$output$collaborationOutput



  ####I need to add commands to

  pt<-ORG$project$title



  imp<-ORG$project$output

  PUB<-ORG$project$publication

  PUB2<-dplyr::filter(PUB,!is.na(parentPublicationTitle))
  PUB3<-dplyr::select(PUB2,parentPublicationTitle,date)

  PUB4<-dplyr::mutate(PUB3,year=lubridate::year(PUB3$date))

  PUB5<-dplyr::group_by(PUB4,parentPublicationTitle,year)

  PUB6<-dplyr::rename(dplyr::count(PUB5, parentPublicationTitle,year), Freq = n)

  PUB7<-dplyr::mutate(PUB6,project_id=proj_id)
  colnames(PUB7)<-c("pub_title","year","freq_per_year","project_id")
  PUB8<-dplyr::select(PUB7,project_id,pub_title,year,freq_per_year)

  return(PUB8)
}

