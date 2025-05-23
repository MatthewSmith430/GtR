#' @title gtr_collaboration_outcome
#'
#' @description This function extracts collaborator ouytput data for a project
#' @param url project URL from gtr.ukri.org
#' @export
#' @return Dataframe with projects and collaborating organisation output
gtr_collaboration_outcome<-function(url){
  firmTEST<-httr::GET(url,httr::add_headers("Accept: application/vnd.rcuk.gtr.json-v7"))
  firmTEXT<-httr::content(firmTEST, as="text")
  JLfirm<-jsonlite::fromJSON(firmTEXT, flatten=TRUE)

  ORG<-JLfirm$projectOverview$projectComposition
  proj_id<-ORG$project$grantReference
  COL<-ORG$project$output$collaborationOutput
  COL2<-dplyr::select(COL,description,
                      collaboratingOrganisation,
                      piContribution,impact)




  OM<-ORG$organisationRole
  OMRa<-purrr::map_df(OM$roles,data.frame)
  #ORG$organisationRole

  OMR<- OMRa$name
  OrgRole<-data.frame(name=unlist(OM$name),
                      org_role=OMR)
  #PID2<-rep(proj_id,length(OrgRole$name))
  COL_DF<-merge(OrgRole,COL,by.x="name",by.y="collaboratingOrganisation",all.x = TRUE)
  COL_DF<-dplyr::mutate(COL_DF,project_id=proj_id)
  return(COL_DF)
}
