#' @title gtr_data_search
#'
#' @description This function searches in the title and abstract of a dataframe to filter project data.
#' @param dataframe Dataframe created using gtr_project_extract_function
#' @param search_term vector of search terms to reduce dataframe created using gtr_project_extract_function
#' @export
#' @return Dataframe with projects from search term - the filtered dataframe
#'
gtr_data_search<-function(dataframe,search_term){
  TERMS<-tolower(search_term)
  NT<-length(TERMS)
  dataframe$project_title<-tolower(dataframe$project_title)
  dataframe$abstract_text<-tolower(dataframe$abstract_text)
  DATA_LIST<-list()
  for(i in 1:length(TERMS)){
    st<-TERMS[[i]]
    mdf<-dplyr::filter(dataframe,stringr::str_detect(project_title, st)|
               stringr::str_detect(abstract_text, st))
    DATA_LIST[[i]]<-mdf
  }
  DATA<-purrr::map_df(DATA_LIST,data.frame)
}
