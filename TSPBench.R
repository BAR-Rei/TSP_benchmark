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
  
  increment<-function(indexList){
    if(length(indexList)==1){
      indexList[1] <- indexList[1] + 1
    } else {
      last <- length(indexList)
      if(indexList[last] == finalIndexValues[last]){
        indexList[-last]<-increment(indexList[-last])
        indexList[last]<-indexList[last-1]+1
      }else{
        indexList[last]<-(indexList[last]+1)
      }
    }
    return(indexList)
  }
  
  initialIndexValues <- 2:(k+1)
  i<-initialIndexValues
  finalIndexValues <- (nrow(x)-(k-1)):nrow(x)
  new_x <- x
  while(or(i != finalIndexValues)){
    x_copy <- x
    temp <- x_copy[i[1], ]
    for(j in 1:(k-1)){
      x_copy[i[j], ] <- x_copy[i[j+1], ]
    }
    x_copy[i[k], ] <- temp
    if(tourLen(x_copy) < tourLen(x)){
      new_x <- x_copy
    }
    i<-increment(i)
  }
  return(new_x)
}

data <- data.frame(x = sample(0:100, 5, replace=T), y = sample(0:100, 5, replace=T), row.names = 1:5)
newData <- k_opt(data, 5)
opt_2(data)
tourLen(newData)
tourLen(data)
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



#générer 20 fichiers
set.seed(100)
data <- data.frame(x = sample(0:100, 15, replace=T), y = sample(0:100, 15, replace=T), row.names = 1:15)
toConcordeFile(data,paste("C:/Users/wafa_/Desktop/samples/ConcordeFile1.tsp"))

n<- 30
for (i in 2:20){
  data <- data.frame(x = sample(0:100, n, replace=T), y = sample(0:100, n, replace=T), row.names = 1:n)
  toConcordeFile(data,paste("C:/Users/wafa_/Desktop/samples/ConcordeFile",i,".tsp"))
  n <- n + 10
}

#tour aléaroirs
set.seed(100)
n<- 30
for (i in 2:20){
  data <- data.frame(x = sample(0:100, n, replace=T), y = sample(0:100, n, replace=T), row.names = 1:n)
  randTourLen(data)
  n <- n + 10
}
randTourLen(data <- data.frame(x = sample(0:100, 15, replace=T), y = sample(0:100, 15, replace=T), row.names = 1:15))

randTourLen<-function(data){
  data2 <- rbind(data[1,],data[sample(2:nrow(data)),])
  len <- tourLen(data2)
  return(len)
}


tourLen <- function(data2){
  somme <- 0
  for (i in 1:(nrow(data2)-1)){
    p <- rbind(data2[i,],data2[i+1,])
    somme <- somme + dist(p)
  }
  d <- rbind(data2[1,],data2[nrow(data2),])
  somme <- somme + dist(d)
  return(somme)
}
