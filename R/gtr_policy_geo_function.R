#' @title gtr_policy_geo
#'
#' @description This function provides a count of policy influence geography for a project
#' @param url project URL from gtr.ukri.org
#' @export
#' @return Dataframe with project id and number of  regions
gtr_policy_geo<-function(url){
  POL1<-gtr_policy(url)
  POL2<-dplyr::group_by(POL1,
                        geographic_region)
  POL3<-dplyr::tally(POL2)
  proj_id<-unique(POL1$project_id)
  POL4<-dplyr::mutate(POL3,project_id=proj_id)
  POL5<-dplyr::rename(POL4,freq=n)
  POL6<-dplyr::select(POL5,project_id,
                      dplyr::everything())
  return(POL6)
}
