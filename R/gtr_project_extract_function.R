#' @title gtr_project_extract
#'
#' @description This function extracts project information, including organisational collaborators
#' @param url project URL from gtr.ukri.org
#' @export
#' @return Dataframe with projects and all organisaitonal collaborators

gtr_project_extract<-function(url){
  firmTEST<-httr::GET(url)
  firmTEXT<-httr::content(firmTEST, as="text")
  JLfirm<-jsonlite::fromJSON(firmTEXT, flatten=TRUE)

  ORG<-JLfirm$projectOverview$projectComposition

  pt<-ORG$project$title



    imp<-ORG$project$output



    PUB<-nrow(ORG$project$publication)
    if (purrr::is_empty(PUB)==TRUE){
      PUB<-0
    }else{PUB<-PUB}

    if(purrr::is_empty(imp)==TRUE){
      names_imp1<-c("collaborationOutput",
                    "intellectualPropertyOutput",
                    "policyInfluenceOutput",
                    "productOutput",
                    "researchMaterialOutput",
                    "artisticAndCreativeProductOutput",
                    "softwareAndTechnicalProductOutput",
                    "researchDatabaseAndModelOutput",
                    "spinOutOutput",
                    "impactSummaryOutput",
                    "furtherFundingOutput",
                    "otherResearchOutput",
                    "exploitationOutput",
                    "disseminationOutput")
      imp_info<-dplyr::tibble(name=names_imp1,len=0)
    }else{
      imp_l<-list()
      for (j in 1:length(imp)){
        imp_l[[j]]<-length(imp[[j]])
      }
      imp_info<-data.frame(name=names(imp),len=unlist(imp_l))
    }

    CO<-dplyr::filter(imp_info,
                      imp_info$name=="collaborationOutput")
    if(CO$len!=0){
      CO_imp<-nrow(imp[["collaborationOutput"]])
    }else{
      CO_imp<-0
    }

    IP<-dplyr::filter(imp_info,
                      imp_info$name=="intellectualPropertyOutput")
    if(IP$len!=0){
      IP_imp<-nrow(imp[["intellectualPropertyOutput"]])
    }else{
      IP_imp<-0
    }

    POL<-dplyr::filter(imp_info,
                       imp_info$name=="policyInfluenceOutput")
    if(POL$len!=0){
      POL_imp<-nrow(imp[["policyInfluenceOutput"]])
    }else{
      POL_imp<-0
    }

    PROD<-dplyr::filter(imp_info,
                        imp_info$name=="productOutput")
    if(PROD$len!=0){
      PROD_imp<-nrow(imp[["productOutput"]])
    }else{
      PROD_imp<-0
    }

    RM<-dplyr::filter(imp_info,
                      imp_info$name=="researchMaterialOutput")
    if(RM$len!=0){
      RM_imp<-nrow(imp[["researchMaterialOutput"]])
    }else{
      RM_imp<-0
    }

    ART<-dplyr::filter(imp_info,
                       imp_info$name=="artisticAndCreativeProductOutput")
    if(ART$len!=0){
      ART_imp<-nrow(imp[["artisticAndCreativeProductOutput"]])
    }else{
      ART_imp<-0
    }

    SOFT<-dplyr::filter(imp_info,
                        imp_info$name=="softwareAndTechnicalProductOutput")
    if(SOFT$len!=0){
      SOFT_imp<-nrow(imp[["softwareAndTechnicalProductOutput"]])
    }else{
      SOFT_imp<-0
    }

    RESDATA<-dplyr::filter(imp_info,
                           imp_info$name=="researchDatabaseAndModelOutput")
    if(RESDATA$len!=0){
      RESDATA_imp<-nrow(imp[["researchDatabaseAndModelOutput"]])
    }else{
      RESDATA_imp<-0
    }

    SPIN<-dplyr::filter(imp_info,
                        imp_info$name=="spinOutOutput")
    if(SPIN$len!=0){
      SPIN_imp<-nrow(imp[["spinOutOutput"]])
    }else{
      SPIN_imp<-0
    }

    SUM<-dplyr::filter(imp_info,
                       imp_info$name=="impactSummaryOutput")
    if(SUM$len!=0){
      SUM_imp<-nrow(imp[["impactSummaryOutput"]])
    }else{
      SUM_imp<-0
    }

    FUR<-dplyr::filter(imp_info,
                       imp_info$name=="furtherFundingOutput")
    if(FUR$len!=0){
      FUR_imp<-nrow(imp[["furtherFundingOutput"]])
    }else{
      FUR_imp<-0
    }

    ORO<-dplyr::filter(imp_info,
                       imp_info$name=="otherResearchOutput")
    if(ORO$len!=0){
      ORO_imp<-nrow(imp[["otherResearchOutput"]])
    }else{
      ORO_imp<-0
    }

    EXPL<-dplyr::filter(imp_info,
                        imp_info$name=="exploitationOutput")
    if(EXPL$len!=0){
      EXPL_imp<-nrow(imp[["exploitationOutput"]])
    }else{
      EXPL_imp<-0
    }

    DISS<-dplyr::filter(imp_info,
                        imp_info$name=="disseminationOutput")
    if(DISS$len!=0){
      DISS_imp<-nrow(imp[["disseminationOutput"]])
    }else{
      DISS_imp<-0
    }

    top<-ORG$project$researchTopic
    sub1<-ORG$project$researchSubject

    PROJ<-tibble::tibble(project_title=ORG$project$title,
                 project_ref=ORG$project$grantReference,
                 abstract_text=ORG$project$abstractText,
                 project_value=ORG$project$fund$valuePounds,
                 start_date=ORG$project$fund$start,
                 end_date=ORG$project$fund$end,
                 funder=ORG$project$fund$funder$name,
                 topic=paste(top$text,collapse="_"),
                 subject=paste(sub1$text,collapse="_"),
                 num_collaboration_output=CO_imp,
                 num_intellectual_property_output=IP_imp,
                 num_policy_influence_output=POL_imp,
                 num_research_material_output=RM_imp,
                 num_artistic_creative_product_output=ART_imp,
                 num_software_technical_product_output=SOFT_imp,
                 num_research_database_model_output=RESDATA_imp,
                 num_spinout_output=SPIN_imp,
                 num_impact_summary_output=SUM_imp,
                 num_further_funding_output=FUR_imp,
                 num_other_research_output=ORO_imp,
                 num_exploitation_output=EXPL_imp,
                 num_dissemination_output=DISS_imp,
                 num_publications=PUB
    )
    OM<-ORG$organisationRole

    OMR<- sapply(unlist(OM$role,
                        recursive=FALSE, use.names=FALSE), "[", 1)
    OrgRole<-data.frame(name=unlist(OM$name),
                    org_role=OMR)
    #OM$
    MEMBERS<-tibble::tibble(org=OM$name)
    M2<-MEMBERS[1,]
    DF1<-dplyr::bind_cols(M2,PROJ)
    if (length(MEMBERS$org)>1){
      DF1[2:length(MEMBERS$org),]<-NA
      DF1$org<-MEMBERS$org
      DF2<-tidyr::fill(DF1,colnames(PROJ))
    }else{DF2<-DF1}



  DF2$project_title<-gsub("&amp;","and",DF2$project_title)

  DF3<-merge(DF2,OrgRole,by.x="org",by.y ="name",all.x=TRUE)
  START_YEAR1<-as.Date(DF3$start_date)
  START_YEAR<-lubridate::year(START_YEAR1)

  END_YEAR1<-as.Date(DF3$end_date)
  END_YEAR<-lubridate::year(END_YEAR1)
  DIFF<-as.vector(abs(difftime(START_YEAR1,END_YEAR1,units="weeks")))

  DF4<-dplyr::mutate(DF3,
                     start_year=START_YEAR,
                     end_year=END_YEAR,
                     duration_weeks=DIFF)


  return(DF4)
}
