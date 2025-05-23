#' @title gtr_project_summary_extract
#'
#' @description This function extracts project information, without organisational collaborators
#' @param url project URL from gtr.ukri.org
#' @export
#' @return Dataframe with project information


gtr_project_summary_extract<-function(url){
  #url<-"https://gtr.ukri.org/api/projects?ref=ES/M010163/1"
  firmTEST<-httr::GET(url,httr::add_headers("Accept: application/vnd.rcuk.gtr.json-v7"))
  firmTEXT<-httr::content(firmTEST, as="text")
  JLfirm<-jsonlite::fromJSON(firmTEXT, flatten=TRUE)

  ORG<-JLfirm$projectOverview$projectComposition

  proj_id<-ORG$project$grantReference

  pt<-ORG$project$title

  imp<-ORG$project$output

  H1<-ORG$project$publication
  HC<-colnames(H1)
  HC_CHECK<-"parentPublicationTitle"%in%HC
  PUB<-nrow(ORG$project$publication)
  if (purrr::is_empty(PUB)==TRUE){
    PUB<-0
    JPUB_num<-0
  }else{
    PUB<-PUB
    if (HC_CHECK==TRUE){
      JPUB<-dplyr::filter(H1,!is.na(parentPublicationTitle))
      JPUB_num<-length(JPUB$title)
    }else{
      JPUB_num<-0
    }

  }



  if(purrr::is_empty(imp)==TRUE){
    names_imp1<-#c("collaborationOutput",
      #  "intellectualPropertyOutput",
      #  "policyInfluenceOutput",
      #  "productOutput",
      #  "researchMaterialOutput",
      #  "artisticAndCreativeProductOutput",
      #  "softwareAndTechnicalProductOutput",
      #  "researchDatabaseAndModelOutput",
      #  "spinOutOutput",
      #  "impactSummaryOutput",
      #  "furtherFundingOutput",
      #  "otherResearchOutput",
      #  "exploitationOutput",
      #  "disseminationOutput")

      c("collaborationOutputs","sortedCollaborationOutputs",
        "intellectualPropertyOutputs","sortedIntellectualPropertyOutputs",
        "policyInfluenceOutputs","sortedPolicyInfluenceOutputs",
        "productOutputs","sortedProductOutputs",
        "researchMaterialOutputs","sortedResearchMaterialOutputs",
        "artisticAndCreativeProductOutputs","sortedArtisticAndCreativeProductOutputs",
        "softwareAndTechnicalProductOutputs","sortedSoftwareAndTechnicalProductOutputs",
        "researchDatabaseAndModelOutputs","sortedResearchDatabaseAndModelOutputs",
        "spinOutOutputs","sortedSpinOutOutputs",
        "impactSummaryOutputs","sortedImpactSummaryOutputs",
        "furtherFundingOutputs","sortedFurtherFundingOutputs",
        "otherResearchOutputs","sortedOtherResearchOutputs",
        "exploitationOutputs","sortedExploitationOutputs",
        "disseminationOutputs","sortedDisseminationOutputs",
        "keyFindingsOutput","hasOutput")



    imp_info<-dplyr::tibble(name=names_imp1,len=0)
  }else{
    imp_l<-list()
    for (j in 1:length(imp)){
      imp_l[[j]]<-length(imp[[j]])
    }
    imp_info<-data.frame(name=names(imp),len=unlist(imp_l))
  }

  CO<-dplyr::filter(imp_info,
                    imp_info$name=="collaborationOutputs")
  if(CO$len!=0){
    CO_imp<-nrow(imp[["collaborationOutputs"]])
  }else{
    CO_imp<-0
  }

  IP<-dplyr::filter(imp_info,
                    imp_info$name=="intellectualPropertyOutputs")
  if(IP$len!=0){
    IP_imp<-nrow(imp[["intellectualPropertyOutputs"]])
  }else{
    IP_imp<-0
  }

  POL<-dplyr::filter(imp_info,
                     imp_info$name=="policyInfluenceOutputs")
  if(POL$len!=0){
    POL_imp<-nrow(imp[["policyInfluenceOutputs"]])
  }else{
    POL_imp<-0
  }

  PROD<-dplyr::filter(imp_info,
                      imp_info$name=="productOutputs")
  if(PROD$len!=0){
    PROD_imp<-nrow(imp[["productOutputs"]])
  }else{
    PROD_imp<-0
  }

  RM<-dplyr::filter(imp_info,
                    imp_info$name=="researchMaterialOutputs")
  if(RM$len!=0){
    RM_imp<-nrow(imp[["researchMaterialOutputs"]])
  }else{
    RM_imp<-0
  }

  ART<-dplyr::filter(imp_info,
                     imp_info$name=="artisticAndCreativeProductOutputs")
  if(ART$len!=0){
    ART_imp<-nrow(imp[["artisticAndCreativeProductOutputs"]])
  }else{
    ART_imp<-0
  }

  SOFT<-dplyr::filter(imp_info,
                      imp_info$name=="softwareAndTechnicalProductOutputs")
  if(SOFT$len!=0){
    SOFT_imp<-nrow(imp[["softwareAndTechnicalProductOutputs"]])
  }else{
    SOFT_imp<-0
  }

  RESDATA<-dplyr::filter(imp_info,
                         imp_info$name=="researchDatabaseAndModelOutputs")
  if(RESDATA$len!=0){
    RESDATA_imp<-nrow(imp[["researchDatabaseAndModelOutputs"]])
  }else{
    RESDATA_imp<-0
  }

  SPIN<-dplyr::filter(imp_info,
                      imp_info$name=="spinOutOutputs")
  if(SPIN$len!=0){
    SPIN_imp<-nrow(imp[["spinOutOutputs"]])
  }else{
    SPIN_imp<-0
  }

  SUM<-dplyr::filter(imp_info,
                     imp_info$name=="impactSummaryOutputs")
  if(SUM$len!=0){
    SUM_imp<-nrow(imp[["impactSummaryOutputs"]])
  }else{
    SUM_imp<-0
  }

  FUR<-dplyr::filter(imp_info,
                     imp_info$name=="furtherFundingOutputs")
  if(FUR$len!=0){
    FUR_imp<-nrow(imp[["furtherFundingOutputs"]])
  }else{
    FUR_imp<-0
  }

  ORO<-dplyr::filter(imp_info,
                     imp_info$name=="otherResearchOutputs")
  if(ORO$len!=0){
    ORO_imp<-nrow(imp[["otherResearchOutputs"]])
  }else{
    ORO_imp<-0
  }

  EXPL<-dplyr::filter(imp_info,
                      imp_info$name=="exploitationOutputs")
  if(length(EXPL$len)!=0){
    EXPL_imp<-nrow(imp[["exploitationOutputs"]])
  }else{
    EXPL_imp<-0
  }

  DISS<-dplyr::filter(imp_info,
                      imp_info$name=="disseminationOutputs")
  if(DISS$len!=0){
    DISS_imp<-nrow(imp[["disseminationOutputs"]])
  }else{
    DISS_imp<-0
  }

  top<-gtr_topic_single(proj_id)
  sub1<-ORG$project$researchSubject

  FFund<-gtr_further_funding_check(url)

  PROJ<-tibble::tibble(project_title=ORG$project$title,
                       project_ref=ORG$project$grantReference,
                       abstract_text=ORG$project$abstractText,
                       project_value=ORG$project$fund$valuePounds,
                       start_date=anytime::anytime(ORG$project$fund$start/1000),
                       end_date=anytime::anytime(ORG$project$fund$end/1000),
                       funder=ORG$project$fund$funder$name,
                       topic=top,
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
                       further_funding=FFund,
                       num_further_funding_output=FUR_imp,
                       num_other_research_output=ORO_imp,
                       num_exploitation_output=EXPL_imp,
                       num_dissemination_output=DISS_imp,
                       num_publications=PUB,
                       num_journal_articles=JPUB_num
  )
  OM<-ORG$organisationRole
  #ORG$organisationRole
  OMRa<-OM$roles
  OMRlist<-list()
  for (z in 1:length(OM$name)){
    NAMEom<-OM$name[[z]]
    OMrole<-OMRa[[z]]
    OrgRole_DF<-data.frame(name=NAMEom,
                           org_role=OMrole$name[[1]])

    OMRlist[[z]]<-OrgRole_DF
  }
  #OMR1<-purrr::map_df(OM$roles,data.frame)

  #OMR<-OMR1$name
  #OMR<- sapply(unlist(OM$role,
  #                    recursive=FALSE, use.names=FALSE), "[", 1)



  OrgRole<-purrr::map_df(OMRlist,data.frame)

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
  #START_YEAR1<-anytime::anytime(DF3$start_date/1000)
  #START_YEAR1<-as.Date(as.POSIXct(DF3$start_date/1000, origin="1970-01-01"))

  START_YEAR<-lubridate::year(DF3$start_date)#START_YEAR1)

  #END_YEAR1<-anytime::anytime(DF3$end_date/1000)
  END_YEAR<-lubridate::year(DF3$end_date)#END_YEAR1)
  DIFF<-as.vector(abs(difftime(DF3$start_date,DF3$end_date,units="weeks")))

  DF4<-dplyr::mutate(DF3,
                     start_year=START_YEAR,
                     end_year=END_YEAR,
                     duration_weeks=DIFF)

  U1<-c("University of Aberdeen",
        "University of Abertay Dundee",
        "Aberystwyth University",
        "Anglia Ruskin University",
        "Aston University",
        "Bangor University",
        "Bath Spa University",
        "University of Bath",
        "University of Bedfordshire",
        "Queen's University of Belfast",
        "Birkbeck College",
        "Birmingham City University",
        "University of Birmingham",
        "Bishop Grosseteste University",
        "University of Bolton",
        "Arts University Bournemouth",
        "Bournemouth University",
        "University of Bradford",
        "University of Brighton",
        "University of Bristol",
        "Brunel University London",
        "Buckinghamshire New University",
        "The University of Buckingham",
        "University of Cambridge",
        "Institute of Cancer Research",
        "Canterbury Christ Church University",
        "Cardiff University",
        "Cardiff Metropolitan University",
        "University of Central Lancashire",
        "University of Chester",
        "University of Chichester",
        "City, University of London",
        "Conservatoire for Dance and Drama",
        "Courtauld Institute Of Art",
        "Coventry University",
        "Cranfield University",
        "University for the Creative Arts",
        "University of Cumbria",
        "De Montfort University",
        "University of Derby",
        "University of Dundee",
        "Durham University",
        "University of East Anglia",
        "University of East London",
        "Edge Hill University",
        "Edinburgh Napier University",
        "University of Edinburgh",
        "University of Essex",
        "University of Exeter",
        "Falmouth University",
        "National Film and Television School",
        "Glasgow Caledonian University",
        "Glasgow School of Art",
        "University of Glasgow",
        "University of Gloucestershire",
        "Glyndwr University",
        "Goldsmiths College",
        "University of Greenwich",
        "Guildhall School of Music and Drama",
        "Harper Adams University",
        "Heriot-Watt University",
        "University of Hertfordshire",
        "University of Huddersfield",
        "University of Hull",
        "Imperial College London",
        "Keele University",
        "University of Kent",
        "King's College London",
        "Kingston University",
        "Lancaster University",
        "Leeds Beckett University",
        "University of Leeds",
        "Leeds Trinity University",
        "University of Leicester",
        "University of Lincoln",
        "Liverpool Hope University",
        "Liverpool John Moores University",
        "University of Liverpool",
        "Liverpool School of Tropical Medicine",
        "University of the Arts London",
        "London Business School",
        "University of London",
        "London Metropolitan University",
        "London South Bank University",
        "London School of Economics & Pol Sci",
        "London Sch of Hygiene and Trop Medicine",
        "Loughborough University",
        "Manchester Metropolitan University",
        "University of Manchester",
        "Middlesex University",
        "Newcastle University",
        "University of Northampton",
        "Northumbria University",
        "Norwich University of the Arts",
        "University of Nottingham",
        "Nottingham Trent University",
        "Open University",
        "Oxford Brookes University",
        "University of Oxford",
        "Plymouth College of Art and Design",
        "University of Plymouth",
        "University of Portsmouth",
        "Queen Margaret University Edinburgh",
        "Queen Mary, University of London",
        "University of Reading",
        "The Robert Gordon University",
        "Roehampton University",
        "Royal Academy of Music",
        "Royal Agricultural University (RAU)",
        "Royal College of Art",
        "Royal College of Music (RCM)",
        "Royal Conservatoire of Scotland",
        "Royal Central School of Speech and Drama",
        "Royal Holloway College and Bedford New College",
        "Royal Northern College of Music",
        "Royal Veterinary College",
        "University of St Andrews",
        "St George's University of London",
        "St Mary's University, Twickenham",
        "University of Salford",
        "School of Oriental & African Studies",
        "SRUC",
        "Sheffield Hallam University",
        "University of Sheffield",
        "Southampton Solent University",
        "University of Southampton",
        "Staffordshire University",
        "University of Stirling",
        "University of Strathclyde",
        "University of Suffolk",
        "University of Sunderland",
        "University of Surrey",
        "University of Sussex",
        "Swansea University",
        "University of Teesside",
        "Trinity Laban Conservatoire of Music and Dance",
        "University of Wales Trinity Saint David",
        "University of the Highlands and Islands",
        "University of Ulster",
        "University College London",
        "University of South Wales",
        "University of Warwick",
        "University of the West of England",
        "University of the West of Scotland",
        "University of West London",
        "University of Westminster",
        "University of Winchester",
        "University of Wolverhampton",
        "University of Worcester",
        "Writtle College",
        "York St John University",
        "University of York")

  R1<-c(0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 1, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 1, 0, 0, 1, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 1, 0, 0, 0, 0, 1, 0, 1,
        0, 0, 0, 0, 1, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 1, 0, 0, 1, 0,
        0, 0, 1, 0, 0, 0, 0, 0, 1, 0,
        0, 0, 0, 0, 0, 1, 0, 0, 0, 1,
        0, 1, 0, 0, 0, 1, 0, 0, 0, 1,
        0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 1)


  ATTR_DF<-data.frame(name=U1,russell_group=R1,
                      uni=rep(1,length(U1)))

  ATTR_DF$name<-tolower(ATTR_DF$name)
  DF4$org<-tolower(DF4$org)

  DF5<-merge(DF4,ATTR_DF,by.x="org",by.y="name",all.x=TRUE,all.y=FALSE)

  DF5$russell_group[is.na(DF5$russell_group)]<-0
  DF5$uni[is.na(DF5$uni)]<-0

  UNIORG<-table(DF5$uni)

  UO_DF<-as.data.frame(UNIORG)


  NUM_ORG<-dplyr::filter(UO_DF,Var1==0)
  NUM_ORG<-NUM_ORG$Freq
  OC<-purrr::is_empty(NUM_ORG)
  if (OC==TRUE){
    NUM_ORG<-0
  }else{
    NUM_ORG<-NUM_ORG
  }

  NUM_UNI<-dplyr::filter(UO_DF,Var1==1)
  NUM_UNI<-NUM_UNI$Freq
  UC<-purrr::is_empty(NUM_UNI)
  if (UC==TRUE){
    NUM_UNI<-0
  }else{
    NUM_UNI<-NUM_UNI
  }
  TOTAL_ORG<-NUM_ORG+NUM_UNI

  PROP_ORG<-NUM_ORG/TOTAL_ORG
  PROP_UNI<-NUM_UNI/TOTAL_ORG

  ####Russell Group Lead org
  LEAD_CHECK<-dplyr::filter(DF5,org_role=="LEAD_RO")
  LEAD_LEN<-length(LEAD_CHECK$org)
  if (LEAD_LEN==0){
    LEAD_R<-0
  }else{
    LEAD_R<-LEAD_CHECK$russell_group[[1]]
  }



  DF6<-dplyr::mutate(DF5,
                     number_org=rep(NUM_ORG,length(DF5$org)),
                     number_uni=rep(NUM_UNI,length(DF5$org)),
                     prop_org=rep(PROP_ORG,length(DF5$org)),
                     prop_uni=rep(PROP_UNI,length(DF5$org)),
                     total_players=rep(TOTAL_ORG,length(DF5$org)),
                     lead_org_russell=rep(LEAD_R,length(DF5$org))
  )

  DF6<-unique(DF6)

  DF7<-dplyr::select(DF6,-c(org,org_role,russell_group,uni))

  Df8<-unique(DF7)

  return(DF6)
}
