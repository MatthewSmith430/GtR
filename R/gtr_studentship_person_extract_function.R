#' @title gtr_studentship_person_extract
#'
#' @description This function extracts studentship information, student and supervisor name
#' @param studentship_id project id for studentship from gtr.ukri.org
#' @export
#' @return Dataframe with studentships and student supervisor details

gtr_studentship_person_extract<-function(studentship_id){
  url<-paste0("https://gtr.ukri.org/api/projects?ref=studentship-",studentship_id)
  firmTEST<-httr::GET(url,httr::add_headers("Accept: application/vnd.rcuk.gtr.json-v7"))
  firmTEXT<-httr::content(firmTEST, as="text")
  JLfirm<-jsonlite::fromJSON(firmTEXT, flatten=TRUE)


  ORG<-JLfirm$projectOverview$projectComposition
  proj_title<-ORG$project$title
  proj_id<-ORG$project$grantReference
  role<-purrr::map_df(ORG$personRole$roles,data.frame)
  student_supervisor<-data.frame(first_name=ORG$personRole$firstName,
                                 last_name=ORG$personRole$surname,role=role,project_id=proj_id)
  #OMR<- sapply(unlist(student_supervisor$role,
  #                    recursive=FALSE, use.names=FALSE), "[", 1)

  #student_supervisor<-dplyr::mutate(student_supervisor,role=OMR,project_id=proj_id,
  #                                  person_url=url,project_title=proj_title)
  #student_supervisor<-dplyr::select(student_supervisor,project_id,
  #                                  project_title,role,firstName,
  #                                  otherNames,surname,person_url)

  return(student_supervisor)
}
