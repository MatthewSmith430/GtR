#' @title gtr_graph one-mode
#'
#' @description This function create a inter-organisational collaboration network (projection from org-project data)
#' @param dataframe dataframe from gtr_project_extract function
#' @param weighted TRUE - uses project value, FALSE - uses number of projects
#' @param start_year start year
#' @param end_year end year
#' @export
#' @return gs igraph object
#'
gtr_graph_one_mode<-function(dataframe,weighted,start_year,
                             end_year){

  YEAR_LIST<-start_year:end_year
  ST<-start_year
  #DF<-dplyr::filter(dataframe,start_year>=ST)
  DF<-dataframe
  DF[,"CHECK"] <- NA
  for (i in 1:length(DF$project_title)){
    YEARS<-DF$start_year[[i]]:DF$end_year[[i]]
    CHECK<-dplyr::intersect(YEARS,YEAR_LIST)
    CT<-length(CHECK)>0
    DF$CHECK[[i]]<-CT
  }

  DF2<-dplyr::filter(DF,CHECK==TRUE)
  DF2<-dplyr::select(DF2,-c(CHECK))

  HH<-dplyr::select(DF2,"org","project_ref","project_value")

  colnames(HH)<-c("org","project","weight")
  HH2<-dplyr::filter(HH,"org"!="project")
  HH2<-unique(HH)

  if (weighted==TRUE){
    EDF<-weighted_projection(HH2)
    gs<-igraph::graph_from_data_frame(EDF,
                                      directed=FALSE)

    igraph::E(gs)$weight<-igraph::E(gs)$WEIGHT
  }else{
    TM<- igraph::graph.data.frame(HH2,directed = FALSE)
    igraph::V(TM)$type <- igraph::bipartite_mapping(TM)$type
    gst<-igraph::bipartite_projection(TM)
    gs<-gst$proj1
  }

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

  igraph::V(gs)$id<-igraph::V(gs)$name
  ATTR_DF<-data.frame(name=U1,russell_group=R1,
                      uni=rep(1,length(U1)))

  VERT<-igraph::get.data.frame(gs,what="vertices")
  VERT<-dplyr::mutate(VERT,order=1:igraph::vcount(gs))

  VERT2<-merge(VERT,ATTR_DF,by="name",all.x=TRUE,all.y=FALSE)

  VERT2$uni[is.na(VERT2$uni)]<-0

  VERT2$russell_group[is.na(VERT2$russell_group)]<-0

  VERT3<-dplyr::arrange(VERT2,order)

  igraph::V(gs)$uni<-VERT3$uni

  igraph::V(gs)$russell_group<-VERT3$russell_group

  bb <- graphlayouts::layout_as_backbone(gs,keep=0.4)

  igraph::E(gs)$col <- F
  igraph::E(gs)$col[bb$backbone] <- T
  return(gs)

}
