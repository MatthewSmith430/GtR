#' @title gtr_project_info
#'
#' @description This function extracts basic project information only
#' @param url project URL from gtr.ukri.org
#' @export
#' @return Dataframe with project information


gtr_project_info<-function(url){
  #url<-"https://gtr.ukri.org/api/projects?ref=ES/M010163/1"
  firmTEST<-httr::GET(url,httr::add_headers("Accept: application/vnd.rcuk.gtr.json-v7"))
  firmTEXT<-httr::content(firmTEST, as="text")
  JLfirm<-jsonlite::fromJSON(firmTEXT, flatten=TRUE)

  ORG<-JLfirm$projectOverview$projectComposition

  proj_id<-ORG$project$grantReference

  pt<-ORG$project$title


  PROJ<-tibble::tibble(project_title=ORG$project$title,
                       project_ref=ORG$project$grantReference,
                       abstract_text=ORG$project$abstractText,
                       project_value=ORG$project$fund$valuePounds,
                       start_date=anytime::anytime(ORG$project$fund$start/1000),
                       end_date=anytime::anytime(ORG$project$fund$end/1000),
                       funder=ORG$project$fund$funder$name,
                       )


  PROJ$project_title<-gsub("&amp;","and",PROJ$project_title)
  START_YEAR<-lubridate::year(PROJ$start_date)#START_YEAR1)

  #END_YEAR1<-anytime::anytime(DF3$end_date/1000)
  END_YEAR<-lubridate::year(PROJ$end_date)#END_YEAR1)
  DIFF<-as.vector(abs(difftime(PROJ$start_date,
                               PROJ$end_date,units="weeks")))

  PROJ2<-dplyr::mutate(PROJ,
                     start_year=START_YEAR,
                     end_year=END_YEAR,
                     duration_weeks=DIFF)

  return(PROJ2)
}
