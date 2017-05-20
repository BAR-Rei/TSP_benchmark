data <- data.frame(x = sample(0:10, 6, replace=T), y = sample(0:10, 6, replace=T), row.names = 1:6)

data
distance <- dist(data, method = "euclidean", diag = T, p=2)
dist <- data.frame(data)
distance
c <- c(1,2,3,4,5,6,1)
c
distance[2,1]


dist(data[2,],data[3,])

tourLen <- function(data2){
  somme <- 0
  for (i in 1:(nrow(data2)-1)){
    print(i)
    p <- rbind(data2[i,],data2[i+1,])
    somme <- somme + dist(p)
  }
  d <- rbind(data2[1,],data2[nrow(data2),])
  somme <- somme + dist(d)
  print(somme)
}

for(i in 2:nrow(data)){
  for(j in i:nrow(data)){
    data2<-data
    temp <- data2[i, ]
    data2[i, ] <- data2[j, ]
    data2[j, ] <- temp
    tour_length(data2)
  }
}
