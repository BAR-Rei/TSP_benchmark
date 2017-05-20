x <- data.frame(x = runif(20, min=0, max=100), y = runif(20, min=0, max=100), row.names = seq(1,20))
## create a TSP
etsp <- ETSP(x)
etsp
#as.matrix(etsp)
## use some methods
n_of_cities(etsp)
labels(etsp)
## plot ETSP and solution
tour <- solve_TSP(etsp)
a <- 3
tour
WAFA <- "wafa"
WAFA
plot(etsp, tour, tour_col = "red")
