# ecrit un TSP dans un fichier aux normes Concorde
# parce que l'API TSPLIB genere des fichiers incompatibles avec Concorde
tspToFile <- function(x, filename = "ConcordeFile.tsp"){
  dimension = nrow(x)
  header <- paste("NAME: concorde
TYPE: TSP
DIMENSION:", as.character(dimension),"
EDGE_WEIGHT_TYPE: EUC_2D
NODE_COORD_SECTION")
  write(header, file=filename)
  for(i in 1:dimension){
    write(c(i, as.matrix(x[i, ])), file=filename, append = TRUE)
  }
}

generateTSPsForN <- function(n, it=20){
  for(i in 1:it){
    data <- data.frame(x = sample(0:100, n, replace=T), y = sample(0:100, n, replace=T), row.names = 1:n)
    tspToFile(data, paste("C:/Users/wafa_/TSP_benchmark/samples", n, "/ConcordeFile",i,".tsp", sep = ""))
  }
}


####################################################
# Ne generez les donnees que si vous avez concorde #
#Il faudra que vous utilisiez l'interface graphique#
#    pour resoudre les TSP a la main un par un     #
####################################################
generateTSPsForN(15)
generateTSPsForN(25)