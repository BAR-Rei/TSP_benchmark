install.packages("TSP")
library(TSP)
# chemin vers l'executable Concorde
concorde_path("C:/Program Files (x86)/Concorde")

# ecrit un TSP dans un fichier aux normes Concorde
toConcordeFile <- function(x, filename = "ConcordeFile.tsp"){
  dimension = nrow(x)
  header <- paste("NAME: concorde91
TYPE: TSP
DIMENSION:", as.character(dimension),"
EDGE_WEIGHT_TYPE: EUC_2D
NODE_COORD_SECTION")
  write(header, file=filename)
  for(i in 1:dimension){
    write(c(i, as.matrix(x[i, ])), file=filename, append = TRUE)
  }
}

# applique 2_opt et retourne vrai s'il trouve un meilleur tour, faux sinon
opt_2 <- function(x){
  improvement <- FALSE
  x_copy <- data.frame(x)
  for(i in 2:nrow(x_copy)){
    for(j in i:nrow(x_copy)){
      temp <- x_copy[i, ]
      x_copy[i, ] <- x_copy[j, ]
      x_copy[j, ] <- temp
      if(tourLen(x_copy) < tourLen(x)){
        x <- x_copy
        improvement <- TRUE
      }
    }
  }
  return(improvement)
}


data <- data.frame(x = sample(0:100, 100, replace=T), y = sample(0:100, 100, replace=T), row.names = 1:100)
## create a TSP
data
etsp <- ETSP(data)
etsp
#as.matrix(etsp)
## use some methods
n_of_cities(etsp)
labels(etsp)
## plot ETSP and solution
tour <- solve_TSP(etsp)
tour
plot(etsp, tour, tour_col = "red")

toConcordeFile(data)

#distance euclidienne
dist(data, method = "euclidean", diag = T, upper = FALSE, p = 2)
dist

