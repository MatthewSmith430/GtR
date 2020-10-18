#' @title gtr_project_search
#'
#' @description This function searches for projects in GtR associated with the search term
#' @param search_term the search term for projects
#' @export
#' @return Dataframe with projects from search term
gtr_project_search<-function(search_term){
  firmNAME<-gsub(" ", "+",search_term)
  firmNAME<-gsub("&","%26",firmNAME)
  url_pg<-paste0("http://gtr.ukri.org/search/project?term=",firmNAME,"&page=1&fetchSize=100")
  firmTEST<-httr::GET(url_pg)
  pages<-firmTEST$headers$`link-pages`
  res_list<-list()
  retain<-c("projectComposition.project.title",
            "projectComposition.project.grantCategory",
            "projectComposition.project.id",
            "projectComposition.project.url",
            "projectComposition.project.fund.valuePounds",
             "projectComposition.project.fund.start",
            "projectComposition.project.fund.end",
            "projectComposition.project.fund.funder.name",
            "projectComposition.leadResearchOrganisation.name"
            )
  for (j in 1:pages){
    url<-paste0("http://gtr.ukri.org/search/project?term=",firmNAME,"&page=",j,"&fetchSize=100")
    firmTEST2<-httr::GET(url)
    firmTEXT<-httr::content(firmTEST2, as="text")
    JLfirm<-jsonlite::fromJSON(firmTEXT, flatten=TRUE)
    MM<-JLfirm$searchResult$results
    MM2<-dplyr::select(MM,tidyselect::all_of(retain))
    colnames(MM2)<-c("project_title", "grant_category",
                     "project_id","project_url",
                     "value",
                     "start_date","end_date",
                     "funder","lead_org")
    res_list[[j]]<-MM2
  }

  res_data_frame<-purrr::map_df(res_list,data.frame)

  return(res_data_frame)

}
