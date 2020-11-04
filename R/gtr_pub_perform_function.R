#' @title gtr_pub_perform
#'
#' @description This function extracts average SJR & H index scores for journal output for a project
#' @param url project URL from gtr.ukri.org
#' @export
#' @return Dataframe with project_id,average SJR, average h-index

gtr_pub_perform<-function(url){
  PUB_DF<-gtr_pub_df(url)
  TEST<-dplyr::ungroup(PUB_DF)
  project_id<-unique(TEST$project_id)
  AVG<-dplyr::summarise(TEST,avg_SJR=mean(SJR_mult_freq,na.rm = TRUE),
                 avg_H_index=mean(H_index_mult_freq,na.rm = TRUE))
  AVG_DF<-dplyr::mutate(AVG,project_id=project_id)
  AVG_DF<-dplyr::relocate(AVG_DF,project_id)

  return(AVG_DF)
}
