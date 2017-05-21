install.packages("TSP")
library(TSP)
# chemin vers l'executable Concorde
concorde_path("C:/Program Files (x86)/Concorde")

# ecrit un TSP dans un fichier aux normes Concorde
# parce que TSPLIB fait n'importe quoi
tspToFile <- function(x, filename = "C:/Users/wafa_/TSP_benchmark/ConcordeFile.tsp"){
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

tspFromFile <- function(filename){
  con<-file(f)
  open(con)
  ab <- read.table(con,skip=5,nrow=25) #6-th line
  close(con)
  d <- data.frame(ab$V2,ab$V3)
  # print("ok")
  return (d)
}

# Longueur d'un tour
tourLen <- function(data){
  somme <- 0
  for (i in 1:(nrow(data)-1)){
    p <- rbind(data[i,],data[i+1,])
    somme <- somme + dist(p)
  }
  d <- rbind(data[1,],data[nrow(data),])
  somme <- somme + dist(d)
  print(somme)
  return(somme)
}

# applique k_opt et retourne vrai s'il trouve un meilleur tour, faux sinon
k_opt <- function(x, k=2){
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
  
  while(!all(i == finalIndexValues)){
    x_copy <- x
    temp <- x_copy[i[1], ]
    for(j in 1:(k-1)){
      x_copy[i[j], ] <- x_copy[i[j+1], ]
    }
    x_copy[i[k], ] <- temp
    if(tourLen(x_copy) < tourLen(x)){
      return(x_copy)
    }
    i<-increment(i)
  }
  return(x)
}

rechercheVoisinagesVariables <- function(x){
  #x_copy doit etre different de x mais de meme longueur
  #pour rentrer dans le while parce que pas de do/while
  x_copy <- x+1
  while(!all(x_copy == x)){
    x <- x_copy
    x_copy <- k_opt(x, 2)
    if(all(x == x_copy)){
      x_copy <- k_opt(x, 3)
    }
  }
  return(x)
}

#taille d'un tour aleatoire
randTourLen<-function(data){
  return(tourLen(rbind(data[1,],data[sample(2:nrow(data)),])))
}




for (i in 1:20){
  data <- data.frame(x = sample(0:100, 25, replace=T), y = sample(0:100, 25, replace=T), row.names = 1:25)
  tspToFile(data,paste("C:/Users/wafa_/TSP_benchmark/samples 25/ConcordeFile",i,".tsp"))
  newData <- rechercheVoisinagesVariables(data)
  tourLen(newData)
  randTourLen(data)
}

# read All files


for (i in 1:20){
  data <- tspFromFile(paste("C:/Users/Syncrossus/Documents/GitHub/TSP_benchmark/samples 25/ConcordeFile",i,".tsp"))
  
}















?tsp
tsp<- TSP(dist(ab, method = "euclidean", diag = T, upper = FALSE, p = 2))
ab
tsp
tour<-solve_TSP(tsp, method = "linkern", control = c("-V"))
tour
linkern_help()
typeof(tour)
image(tsp)
tour
t <- c()
for (i in 1:40){
  t <- c(t,tour[[i]])
}
t


dataSorted <-ab[match(t, row(ab)),]
dataSorted <- rbind(dataSorted,dataSorted[1,])
dataSorted
plot(x=dataSorted$V2,y=dataSorted$V3,type='b',xlab='X',ylab='Y')

plot(tsp, tour, tour_col = "red")
plot(data, tour, cex=.6, col = "red", pch= 3, main = "TSPLIB: d493")
d <- dist(data, method = "euclidean", diag = T, upper = FALSE, p = 2)
tsp
tsp <- insert_dummy(d, label = "cut")
tsp
