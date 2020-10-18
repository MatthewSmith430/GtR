#' @title gtr_funder_year
#'
#' @description This function creates dataframe of funder-year that can be used to create a plot
#' @param dataframe dataframe from gtr_project_extract function
#' @param start_year start year
#' @param end_year end year
#' @export
#' @return DF datafrmae
#'
gtr_funder_year<-function(dataframe,start_year,end_year){
  proj<-dplyr::select(dataframe,"funder","start_year",
                      "project_value")
  proj2<-dplyr::group_by(proj,funder,start_year)
  proj3<-dplyr::summarise(proj2,Frequency = sum(proj2$project_value))

  colnames(proj3)<-c("Funder","Year","Value")

  return(proj3)
}
