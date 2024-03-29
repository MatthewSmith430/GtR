#' @title gtr_ip_summary
#'
#' @description This function give number of IP outputs per category for a project
#' @param url project URL from gtr.ukri.org
#' @export
#' @return Dataframe with projects and number of IP output
gtr_ip_summary<-function(url){
  IP_DATA<-gtr_ip(url)
  CHECK<-is.na(IP_DATA$ip_category)
  if (CHECK==TRUE){
    IP_SUM<-tibble::tibble(project_id=IP_DATA$project_id[[1]],
                           num_copyrighted=0,
                           num_patent_application_published=0,
                           num_patent_granted=0,
                           num_Protection_not_required=0,
                           num_Protection_Not_Required=0,
                           num_trade_mark=0,
                           num_IP_REF=0
    )
  }else{
    OUTCOMEi<-table(IP_DATA$ip_category)
    Oi<-as.data.frame(OUTCOMEi)

    COPY<-dplyr::filter(Oi,Var1=="Copyrighted (e.g. software)")
    COPY<-COPY$Freq

    PAT_APP_PUB<-dplyr::filter(Oi,Var1=="Patent application published)")
    PAT_APP_PUB<-PAT_APP_PUB$Freq

    PAT_GRANT<-dplyr::filter(Oi,Var1=="Patent granted")
    PAT_GRANT<-PAT_GRANT$Freq

    PROTECT_NR1<-dplyr::filter(Oi,Var1=="Protection not required")
    PROTECT_NR1<-PROTECT_NR1$Freq

    PROTECT_NR2<-dplyr::filter(Oi,Var1=="Protection Not Required")
    PROTECT_NR2<-PROTECT_NR2$Freq

    TRADE<-dplyr::filter(Oi,Var1=="Trade Mark")
    TRADE<-TRADE$Freq

    Ce<-purrr::is_empty(COPY)

    PAT_APPe<-purrr::is_empty(PAT_APP_PUB)

    PAT_GRANTe<-purrr::is_empty(PAT_GRANT)

    PRO1e<-purrr::is_empty(PROTECT_NR1)

    PRO2e<-purrr::is_empty(PROTECT_NR2)

    TRADEe<-purrr::is_empty(TRADE)

    if (Ce==TRUE){
      COPY1<-0
    }else{
      COPY1<-COPY
    }

    if (PAT_APPe==TRUE){
      PAT_APP_PUB1<-0
    }else{
      PAT_APP_PUB1<-PAT_APP_PUB1
    }

    if (PAT_GRANTe==TRUE){
      PAT_GRANT1<-0
    }else{
      PAT_GRANT1<-PAT_GRANT
    }

    if (PRO1e==TRUE){
      PROTECT_NR1a<-0
    }else{
      PROTECT_NR1a<-PROTECT_NR1
    }

    if (PRO2e==TRUE){
      PROTECT_NR2a<-0
    }else{
      PROTECT_NR2a<-PROTECT_NR2
    }

    if (TRADEe==TRUE){
      TRADE1<-0
    }else{
      TRADE1<-TRADE
    }

    NUM_IP_REF<-dplyr::filter(IP_DATA,!is.na(patent_id))

    NUM_IP_REF<-length(NUM_IP_REF$project_id)

    IP_SUM<-tibble::tibble(project_id=IP_DATA$project_id[[1]],
                           num_copyrighted=COPY1,
                           num_patent_application_published=PAT_APP_PUB1,
                           num_patent_granted=PAT_GRANT1,
                           num_Protection_not_required=PROTECT_NR1a,
                           num_Protection_Not_Required=PROTECT_NR2a,
                           num_trade_mark=TRADE1,
                           num_IP_REF=NUM_IP_REF
    )
  }

  return(IP_SUM)

  #Copyrighted (e.g. software)
  #Patent application published
  #Patent granted
  #Protection not required
  #Protection Not Required
  #Trade Mark


}
