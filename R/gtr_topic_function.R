#' @title gtr_topic
#'
#' @description This function extracts topic classification for a project (selecting max percentage for multiple topics)
#' @param project_id projectid
#' @export
#' @return Dataframe with project id and topic

gtr_topic<-function(project_id){
  url<-paste0("https://gtr.ukri.org:443/projects?ref=",
              project_id)
  firmTEST<-httr::GET(url)
  firmTEXT<-httr::content(firmTEST, as="text")
  JLfirm<-jsonlite::fromJSON(firmTEXT, flatten=TRUE)

  ORG<-JLfirm$projectOverview$projectComposition

  pt<-ORG$project$title
  topic<-ORG$project$researchTopic
  if (topic$text=="Unclassified"){
    topic_NAME<-"unknown"
  }
  else{
    topic_len<-length(topic)
    if (topic_len>0){
      topic_max<-dplyr::arrange(topic,
                                dplyr::desc(percentage))
      topic_NAME<-topic_max$text[[1]]
      topic_NAME<-tolower(topic_NAME)
      topic_NAME<-stringr::str_replace_all(topic_NAME, " ", "")
    }else{
      topic_NAME<-"unknown"
    }
  }


  DF<-tibble::tibble(project_title=ORG$project$title,
                       project_ref=ORG$project$grantReference,
                       project_id=project_id,
                       topic=topic_NAME
                       )

  DF$project_title<-gsub("&amp;","and",DF$project_title)
  DF$topic<-gsub("&amp;","and",DF$topic)

  return(DF)
}
