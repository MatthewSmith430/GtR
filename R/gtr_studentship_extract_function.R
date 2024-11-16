#' @title gtr_studentship_extract
#'
#' @description This function extracts studentship information, including organisational collaborators
#' @param studentship_id project id for studentship from gtr.ukri.org
#' @export
#' @return Dataframe with studentships and all organisaitonal collaborators

gtr_studentship_extract<-function(studentship_id){
  url<-paste0("https://gtr.ukri.org/api/projects?ref=studentship-",studentship_id)
  firmTEST<-httr::GET(url,httr::add_headers("Accept: application/vnd.rcuk.gtr.json-v7"))
  firmTEXT<-httr::content(firmTEST, as="text")
  JLfirm<-jsonlite::fromJSON(firmTEXT, flatten=TRUE)

  ORG<-JLfirm$projectOverview$projectComposition
  proj_id<-ORG$project$grantReference

  pt<-ORG$project$title



  PROJ<-tibble::tibble(project_title=ORG$project$title,
                       project_ref=ORG$project$grantReference,
                       abstract_text=ORG$project$abstractText,
                       project_value=ORG$project$fund$valuePounds,
                       start_date=ORG$project$fund$start,
                       end_date=ORG$project$fund$end,
                       funder=ORG$project$fund$funder$name
  )

  project_type<-rep("Studentship",length(PROJ$project_title))

  PROJ<-dplyr::mutate(PROJ,project_type=project_type)

  OM<-ORG$organisationRole
  #ORG$organisationRole

  OMR<- sapply(unlist(OM$role,
                      recursive=FALSE, use.names=FALSE), "[", 1)
  OrgRole<-data.frame(name=unlist(OM$name),
                      org_role=OMR,
                      org_region=OM$address.region,
                      org_postcode=OM$address.postCode)

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
  START_YEAR1<-anytime::anytime(DF3$start_date/1000)
  START_YEAR<-lubridate::year(START_YEAR1)

  END_YEAR1<-anytime::anytime(DF3$end_date/1000)
  END_YEAR<-lubridate::year(END_YEAR1)
  DIFF<-as.vector(abs(difftime(START_YEAR1,END_YEAR1,units="weeks")))

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

  NUM_UNI<-dplyr::filter(UO_DF,Var1==1)
  NUM_UNI<-NUM_UNI$Freq

  TOTAL_ORG<-NUM_ORG+NUM_UNI

  PROP_ORG<-NUM_ORG/TOTAL_ORG
  PROP_UNI<-NUM_UNI/TOTAL_ORG

  ####Russell Group Lead org
  LEAD_CHECK<-dplyr::filter(DF5,org_role=="LEAD_RO")
  LEAD_R<-LEAD_CHECK$russell_group

  DF6<-dplyr::mutate(DF5,
                     number_org=rep(NUM_ORG,length(DF5$org)),
                     number_uni=rep(NUM_UNI,length(DF5$org)),
                     prop_org=rep(PROP_ORG,length(DF5$org)),
                     prop_uni=rep(PROP_UNI,length(DF5$org)),
                     total_players=rep(TOTAL_ORG,length(DF5$org)),
                     lead_org_russell=rep(LEAD_R,length(DF5$org)))

  return(DF6)



}
