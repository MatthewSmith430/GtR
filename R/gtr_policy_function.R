#' @title gtr_policy
#'
#' @description This function provides the policy influence items for a project
#' @param url project URL from gtr.ukri.org
#' @export
#' @return Dataframe with projects and policy outcome
gtr_policy<-function(url){
  firmTEST<-httr::GET(url)
  firmTEXT<-httr::content(firmTEST, as="text")
  JLfirm<-jsonlite::fromJSON(firmTEXT, flatten=TRUE)

  ORG<-JLfirm$projectOverview$projectComposition
  proj_id<-ORG$project$grantReference
  imp<-ORG$project$output
  pol_imp<-imp$policyInfluenceOutput

  desc<-pol_imp$description
  pol_type<-pol_imp$type
  impact<-pol_imp$impact
  geo<-pol_imp$geographicReach
  LEN<-length(desc)
  ref_rep<-rep(proj_id,LEN)

  DATA<-tibble::tibble(project_id=ref_rep,
                       policy_influence_type=pol_type,
                       description=desc,
                       impact=impact,
                       geographic_region=geo)

  return(DATA)
}
