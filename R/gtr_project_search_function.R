#' @title gtr_project_search
#'
#' @description This function searches for projects in GtR associated with the search term
#' @param search_term the search term for projects
#' @export
#' @return Dataframe with projects from search term
gtr_project_search<-function(search_term){
  firmNAME<-gsub(" ", "+AND+",search_term)
  firmNAME<-gsub("&","%26",firmNAME)
  url_pg<-paste0("http://gtr.ukri.org/search/project?term=",firmNAME,"&page=1&fetchSize=100")
  #url_pg<-gsub(#'\', "", url_pg, fixed = TRUE)
  #https://gtr.ukri.org/api

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
  ref_info_list<-list()
  ref_url_list<-list()
  for (j in 1:nrow(res_data_frame)){
    R1<-res_data_frame[j,]
    ref_split<-stringr::str_split(R1$project_url,"=",2)
    ref_split<-unlist(ref_split)
    ref_detail<-ref_split[[2]]
    ref_info_list[[j]]<-ref_detail
    ref_url1<-paste0("https://gtr.ukri.org/projects?ref=",ref_detail)
    ref_url_list[[j]]<-ref_url1

  }

  ref_info_fin<-unlist(ref_info_list)
  ref_url_fin<-unlist(ref_url_list)

  res_data_frame2<-dplyr::mutate(res_data_frame,ref_info=ref_info_fin,ref_url=ref_url_fin)

  return(res_data_frame2)

}

