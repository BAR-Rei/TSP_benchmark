install.packages("TSP")
library(TSP)
# chemin vers l'executable Concorde
concorde_path("C:/Program Files (x86)/Concorde")

# ecrit un TSP dans un fichier aux normes Concorde
toConcordeFile <- function(x, filename = "C:/Users/wafa_/TSP_benchmark/ConcordeFile.tsp"){
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
  
  while(or(i != finalIndexValues)){
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

data <- data.frame(x = sample(0:100, 25, replace=T), y = sample(0:100, 25, replace=T), row.names = 1:25)
newData<-data
newData2 <- newData+1
while(!all(newData == newData2)){
  newData <- newData2
  newData2 <- k_opt(newData, 2)
  if(all(newData == newData2)){
    newData2 <- k_opt(newData, 3)
  }
}
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


#generation des fichiers et  tour alearoirs
set.seed(100)
randTourLen<-function(data){
  data2 <- rbind(data[1,],data[sample(2:nrow(data)),])
  len <- tourLen(data2)
  print(len)
  return(len)
}
for (i in 1:20){
  data <- data.frame(x = sample(0:100, 25, replace=T), y = sample(0:100, 25, replace=T), row.names = 1:25)
  #toConcordeFile(data,paste("C:/Users/wafa_/TSP_benchmark/samples 25/ConcordeFile",i,".tsp"))
  randTourLen(data)
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




# read All files
readDf <- function(f){
  con<-file(f)
  open(con)
  ab <- read.table(con,skip=5,nrow=25) #6-th line
  close(con)
  d <- data.frame(ab$V2,ab$V3)
  # print("ok")
  return (d)
}

for (i in 1:20){
  readDf(paste("C:/Users/wafa_/TSP_benchmark/samples 25/ConcordeFile",i,".tsp"))
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
