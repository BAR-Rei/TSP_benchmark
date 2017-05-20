install.packages("TSP")
library(TSP)
# chemin vers l'executable Concorde
concorde_path("C:/Program Files (x86)/Concorde")

# ecrit un TSP dans un fichier aux normes Concorde
toConcordeFile <- function(x, filename = "C:/Users/wafa_/Desktop/ConcordeFile.tsp"){
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

tourLen <- function(data2){
  somme <- 0
  for (i in 1:(nrow(data2)-1)){
    p <- rbind(data2[i,],data2[i+1,])
    somme <- somme + dist(p)
  }
  d <- rbind(data2[1,],data2[nrow(data2),])
  somme <- somme + dist(d)
  print(somme)
  return(somme)
}

# applique k_opt et retourne vrai s'il trouve un meilleur tour, faux sinon
k_opt <- function(x, k=2){
  or <- function(array){
    for(i in array){
      if(i){
        return(TRUE)
      }
    }
    return(FALSE)
  }
  
  improvement <- FALSE
  initialIndexValues <- 2:(k+1)
  i<-initialIndexValues
  finalIndexValues <- (length(x)-(k-1)):length(x)
  while(or(i != finalIndexValues)){
    x_copy <- x
    temp <- x_copy[i[1], ]
    for(j in i[-k]){
      x_copy[i[j], ] <- x_copy[i[j+1], ]
    }
    x_copy[i[k], ] <- temp
    
    if(tourLen(x_copy) < tourLen(x)){
      new_x <- x_copy
      improvement <- TRUE
    }
    
    for(j in k:1){
      if(i[j] == finalIndexValues[j]){
        i[j]<-initialIndexValues[j]
      }else{
        i[j]<-i[j]+1
        break()
      }
    }
  }
  
  return(improvement)
}

# applique 2_opt et retourne vrai s'il trouve un meilleur tour, faux sinon
opt_2 <- function(x){
  improvement <- FALSE
  x_copy <- x
  for(i in 2:(nrow(x_copy)-1)){
    for(j in (i+1):nrow(x_copy)){
      temp <- x_copy[i, ]
      x_copy[i, ] <- x_copy[j, ]
      x_copy[j, ] <- temp
      if(tourLen(x_copy) < tourLen(x)){
        new_x <- x_copy
        improvement <- TRUE
      }
    }
  }
  x<-new_x
  return(improvement)
}




data <- data.frame(x = sample(0:100, 5, replace=T), y = sample(0:100, 5, replace=T), row.names = 1:5)
opt_2(data)
data
toConcordeFile(data)



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

