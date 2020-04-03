#' @title weighted_projection
#'
#' @description This takes the one-mode projection of a weighted two-mode network. Where the ties in the one-mode network are an aggregation of shared event weights.
#' @param DF A dataframe with three columns - actor, event, weight
#' @export
#' @return Dataframe edgelist of the one-mode network with 3 columns - node1, node2, weight
#'

weighted_projection<-function(DF){
  colnames(DF)<-c("node1","node2","value")

  NODE2_list<-unique(DF$node2)
  DF_LINK<-list()
  for (i in 1:length(NODE2_list)){
    event<-NODE2_list[[i]]
    DF1<-dplyr::filter(DF,DF$node2==event)
    if(length(DF1$node1)>1){
      tmg<-igraph::graph_from_data_frame(DF1)
      bi_map<-igraph::bipartite_mapping(tmg)
      igraph::V(tmg)$type <- bi_map$type

      proj2 <- igraph::bipartite_projection(tmg)
      org_gs<-proj2$proj1

      org_df<-igraph::get.data.frame(org_gs,what="edges")
      VAL<-DF1$value[[1]]
      WL<-length(org_df$weight)
      org_df$weight<-rep(VAL,WL)

      order_link<-list()
      for (j in 1:length(org_df$from)){
        DFT<-org_df[j,]
        FL1<-DFT$from
        FL2<-DFT$to
        TESTalp<-FL1<FL2
        if(TESTalp==TRUE){
          link_df<-dplyr::tibble(NODE1=DFT[,1],
                                 NODE2=DFT[,2],
                                 WEIGHT=DFT[,3])

        }else{
          link_df<-dplyr::tibble(NODE1=DFT[,2],
                                 NODE2=DFT[,1],
                                 WEIGHT=DFT[,3])
        }
        order_link[[j]]<-link_df
      }
      LL<-purrr::map_df(order_link,data.frame)
    }else{
      LL<-NULL
    }

    DF_LINK[[i]]<-LL
  }

  LINK_LIST_DATAFRAME<-purrr::map_df(DF_LINK,data.frame)

  LLDF<-dplyr::mutate(LINK_LIST_DATAFRAME,
                      COMB=paste0(LINK_LIST_DATAFRAME$NODE1,"_",LINK_LIST_DATAFRAME$NODE2))
  LLDF2<-dplyr::group_by(LLDF,LLDF$COMB)
  LLDF3<-dplyr::summarise(LLDF2,Frequency = sum(LLDF2$WEIGHT))
  colnames(LLDF3)<-c("COMB","Frequency")

  LLDF4<-stringr::str_split_fixed(LLDF3$COMB, "_", 2)
  LLDF5<-as.data.frame(LLDF4,stringsAsFactors = FALSE)
  colnames(LLDF5)<-c("NODE1","NODE2")

  LLDF6<-dplyr::mutate(LLDF5,WEIGHT=LLDF3$Frequency)

  return(LLDF6)
}
