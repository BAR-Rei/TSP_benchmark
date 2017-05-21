# ecrit un TSP dans un fichier aux normes Concorde
# parce que TSPLIB fait n'importe quoi
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

tspFromFile <- function(filename, rows=25){
  con<-file(filename)
  open(con)
  ab <- read.table(con,skip=5,nrow=rows) #6-th line
  close(con)
  d <- data.frame(ab$V2,ab$V3)
  return (d)
}

tspFromCyc <- function(filename, rows=25){
  con<-file(filename)
  open(con)
  ab <- read.table(con, nrow=rows)
  close(con)
  d <- data.frame(ab$V1)
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
  return(somme[1])
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

variableNeighbourhoodSearch <- function(x){
  #x_copy doit etre different de x mais de meme longueur
  #pour rentrer dans le while parce que pas de do/while
  startTime <- Sys.time()
  nIterations <- 0
  x_copy <- x+1
  while(!all(x_copy == x)){
    nIterations <- nIterations + 1
    x <- x_copy
    x_copy <- k_opt(x, 2)
    if(all(x == x_copy)){
      x_copy <- k_opt(x, 3)
    }
  }
  return(list(data = x, time = Sys.time() - startTime, iterations = nIterations))
}

#taille d'un tour aleatoire
randTourLen<-function(data){
  return(tourLen(rbind(data[1,],data[sample(2:nrow(data)),])))
}

generateTSPsForN <- function(n, it=20){
  for(i in 1:it){
    data <- data.frame(x = sample(0:100, n, replace=T), y = sample(0:100, n, replace=T), row.names = 1:n)
    tspToFile(data, paste("C:/Users/wafa_/TSP_benchmark/samples", n, "/ConcordeFile",i,".tsp", sep = ""))
  }
}

benchTSPsForN <- function(n, it=20){
  randomTours <- c()
  optTours <- c()
  #vN stands for variable neighbourhood
  vNTours <- c()
  vNTimes <- c()
  vNIt <- c()
  for(i in 1:it){
    data <- tspFromFile(paste("C:/Users/Syncrossus/Documents/GitHub/TSP_benchmark/samples", n, "/","ConcordeFile",i,".tsp", sep = ""), n)
    optimalIndexes <- tspFromCyc(paste("C:/Users/Syncrossus/Documents/GitHub/TSP_benchmark/samples", n, "/",i,".cyc", sep = ""), n)
    optimalIndexes <- optimalIndexes+1 # on passe d'indices debutant a 0 a des indices debutant a 1
    dataOptimal <- data[optimalIndexes,]
    
    randomTours <- c(randomTours, randTourLen(data))
    optTours <- c(optTours, tourLen(data))
    vNTour <- variableNeighbourhoodSearch(data)
    vNTours <- c(vNTours, tourLen(vNTour$data))
    vNTimes <- c(vNTimes, vNTour$time)
    vNIt <- c(vNIt, vNTour$iterations)
  }
  return(list(randomDist = randomTours, optDist = optTours, vnDist = vNTours, vnTime = vNTimes, vNIterations = vNIt))
}

####################################################
# Ne generez les donnees que si vous avez concorde #
#Il faudra que vous utilisiez l'interface graphique#
#    pour resoudre les TSP a la main un par un     #
####################################################
generateTSPsForN(15)
generateTSPsForN(25)


####################################################
#   vous pouvez lancer le script a partir d'ici,   #
#   Il utilisera les donnees que nous avons cree   #
####################################################
data15 <- benchTSPsForN(15)
data25 <- benchTSPsForN(25)

write.csv2(x = data15, file = "data15.csv", dec = '.')
write.csv2(x = data25, file = "data25.csv", dec = '.')

