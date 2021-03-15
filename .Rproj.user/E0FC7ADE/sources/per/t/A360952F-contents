#' @title gtr_topic_single
#'
#' @description This function extracts a single topic classification for a project (selecting max percentage for multiple topics)
#' @param project_id projectid
#' @export
#' @return topic name

gtr_topic_single<-function(project_id){
  url<-paste0("https://gtr.ukri.org:443/projects?ref=",
              project_id)
  firmTEST<-httr::GET(url)
  firmTEXT<-httr::content(firmTEST, as="text")
  JLfirm<-jsonlite::fromJSON(firmTEXT, flatten=TRUE)

  ORG<-JLfirm$projectOverview$projectComposition

  pt<-ORG$project$title
  pt_N<-purrr::is_null(pt)

  if (pt_N==TRUE){
    pt<-"NULL"
  }else{
    pt<-pt
  }

  topic<-ORG$project$researchTopic
  topic_N<-purrr::is_null(pt)
  if (topic_N==TRUE){
    topic_len<-0
  }else{
    topic_len<-length(topic)
  }




  if (topic_len>0){
    if (topic$text[[1]]=="Unclassified"){
      topic_NAME<-"unknown"
      #DF<-tibble::tibble(project_title=ORG$project$title,
      #                   project_ref=ORG$project$grantReference,
      #                   project_id=project_id,
      #                   topic=topic_NAME
      #)
    }
    else{
      topic_NAME<-topic$text
      TL<-length(topic_NAME)
      topic_max<-dplyr::arrange(topic,
                                dplyr::desc(percentage))
      topic_NAME<-topic_max$text[[1]]
      topic_NAME<-tolower(topic_NAME)
      topic_NAME<-stringr::str_replace_all(topic_NAME, " ", "")

      #DF<-tibble::tibble(project_title=rep(ORG$project$title,TL),
      #                   project_ref=rep(ORG$project$grantReference,TL),
      #                   project_id=rep(project_id,TL),
      #                   topic=topic_NAME
      #)

    }

  }else{
    topic_NAME<-"unknown"
    #DF<-tibble::tibble(project_title=pt,
    #                   project_ref=project_id,
    #                   project_id=project_id,
    #                   topic=topic_NAME
    #)
  }





  #DF$project_title<-gsub("&amp;","and",DF$project_title)
  topic_NAME<-gsub("&amp;","and",topic_NAME)

  return(topic_NAME)
}
