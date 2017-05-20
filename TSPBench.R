install.packages("TSP")
library(TSP)
concorde_path("C:/Program Files (x86)/Concorde")


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



#distance euclidienne
dist(data, method = "euclidean", diag = T, upper = FALSE, p = 2)
dist
