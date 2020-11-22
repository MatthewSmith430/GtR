#' @title gtr_policy_type
#'
#' @description This function provides a count of policy influence types for a project
#' @param url project URL from gtr.ukri.org
#' @export
#' @return Dataframe with projects, types and number of items
gtr_policy_type<-function(url){
  POL1<-gtr_policy(url)
  POL2<-dplyr::group_by(POL1,
                        policy_influence_type)
  POL3<-dplyr::tally(POL2)
  proj_id<-unique(POL1$project_id)
  POL4<-dplyr::mutate(POL3,project_id=proj_id)
  POL5<-dplyr::rename(POL4,freq=n)
  POL6<-dplyr::select(POL5,project_id,
                      dplyr::everything())
  return(POL6)
}
