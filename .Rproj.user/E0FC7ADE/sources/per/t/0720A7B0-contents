#' @title gtr_pub_df
#'
#' @description This function extracts publication information, number of journal articles published in a particular journal per year
#' @param url project URL from gtr.ukri.org
#' @export
#' @return Dataframe with project_id, journal title, year, number of publications in that journal for a particular year

gtr_pub_df<-function(url){
  firmTEST<-httr::GET(url)
  firmTEXT<-httr::content(firmTEST, as="text")
  JLfirm<-jsonlite::fromJSON(firmTEXT, flatten=TRUE)

  ORG<-JLfirm$projectOverview$projectComposition
  proj_id<-ORG$project$grantReference

  pt<-ORG$project$title

  imp<-ORG$project$output

  PUB<-ORG$project$publication

  COL_PUB<- "parentPublicationTitle" %in% colnames(PUB)
  EMP<-purrr::is_empty(PUB)

  if (COL_PUB==FALSE& EMP==FALSE){
    PUB11<-data.frame(project_id=proj_id,
                      Title=NA,
                      year=NA,
                      freq_per_year=0,
                      H_index=0,
                      SJR=0,
                      SJR_mult_freq=0,
                      H_index_mult_freq=0)
  }else if(COL_PUB==FALSE& EMP==TRUE){
    PUB11<-data.frame(project_id=proj_id,
                      Title=NA,
                      year=NA,
                      freq_per_year=0,
                      H_index=0,
                      SJR=0,
                      SJR_mult_freq=0,
                      H_index_mult_freq=0)
  }else{
    PUB2<-dplyr::filter(PUB,!is.na(parentPublicationTitle))
    PUB3<-dplyr::select(PUB2,parentPublicationTitle,date)

    PUB4<-dplyr::mutate(PUB3,year=lubridate::year(PUB3$date))

    PUB5<-dplyr::group_by(PUB4,parentPublicationTitle,year)

    PUB6<-dplyr::rename(dplyr::count(PUB5, parentPublicationTitle,year), Freq = n)

    PUB7<-dplyr::mutate(PUB6,project_id=proj_id)
    colnames(PUB7)<-c("Title","year","freq_per_year","project_id")
    PUB8<-dplyr::select(PUB7,project_id,Title,year,freq_per_year)

    PUB8$Title<-tolower(PUB8$Title)
    PUB8$Title<-gsub("&","and",PUB8$Title)


    JOURNAL_DATA<-base::get("JOURNAL_DATA")

    PUB9<-dplyr::left_join(PUB8,JOURNAL_DATA, by=c("Title","year"))
    PUB10<-dplyr::mutate(PUB9,SJR_mult_freq=SJR*freq_per_year)
    PUB11<-dplyr::mutate(PUB10,H_index_mult_freq=H_index*freq_per_year)

    if (length(PUB11$project_id)==0){
      PUB11<-data.frame(project_id=proj_id,
                        Title=NA,
                        year=NA,
                        freq_per_year=0,
                        H_index=0,
                        SJR=0,
                        SJR_mult_freq=0,
                        H_index_mult_freq=0)
    }else{
      PUB11<-PUB11
    }
  }


  return(PUB11)
}

