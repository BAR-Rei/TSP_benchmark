# TSP_benchmark
## Français
Ce script R compare les performances des méthodes de résolution de TSP avec un "vrai" solveur, à savoir [Concorde](https://www.math.uwaterloo.ca/tsp/concorde.html).
Comme n'importe quel script R, il faut installer R pour l'exécuter.

### Ce que vous voulez probablement faire:
Exécutez TSPBench.R pour comparer les performances de la recherche à voisinage variable avec les solutions au hasard et du solveur Concorde sur les données que nous avons générées.

#### Windows
```
Cd "<chemin d'installation de R>\<version de R>\bin"
.\Rscript.exe "<chemin vers le projet>\TSPBench.R"
```
Répertoire principal par défaut de R: Mes documents

#### Linux
```
Cd <chemin vers le projet>
Rscript TSPBench.R
```
Répertoire principal par défaut de R: ~/



Cela créera deux fichiers CSV dans le répertoire principal de R, data15.csv et data25.csv.
data15.csv contient la comparaison de performances pour 20 TSP de taille 15.
data25.csv contient la comparaison de performances pour 20 TSP de taille 25.

Étiquettes dans les CSV:
* RandomDist: longueur du tour aléatoire
* OptDist: longueur du tour optimal
* VnDist: longueur du tour par recherche à voisinage variable
* VnTime: temps de calcul du tour par recherche à voisinage variable
* VNItérations: nombre d'itérations dans le calcul du tour par recherche à voisinage variable


### Ce que vous ne voulez probablement pas faire:
Exécutez TSPGenerate.R pour générer des fichiers TSPLIB aléatoires utilisables par Concorde (et la plupart des autres solveurs de TSP).
Exécutez seulement TSPGenerate.R si vous avez une installation de Concorde qui fonctionne et êtes prêt à générer les fichiers de tour optimal à la main.
Après avoir exécuté TSPGenerate.R, les fichiers TSP seront dans /samples15 pour les TSP de taille 15 et /samples25 pour les TSP de taille 25.
Utilisez Concorde pour générer le fichier de tour optimal pour chaque fichier ConcordeFile\<i\>.tsp et enregistrez-le sous le nom \<i\>.cyc.
Cela peut être automatisé avec un langage de script d'automatisation de GUI tel que [AutoIT](https://www.autoitscript.com/site/autoit/).


## English
This R script benchmarks TSP resolution methods against a "real" solver, namely [Concorde](https://www.math.uwaterloo.ca/tsp/concorde.html).
As any R script, it requires R to run.

### What you probably want to do :
run TSPBench.R to benchmark Variable Neighbourhood Search against random and Concorde's true optimal solutions on the data we generated

#### Windows
```
cd "<R Installation path>\<R version>\bin"
.\Rscript.exe "<path to project>\TSPBench.R"
```
default R home directory : My Documents

#### Linux
```
cd <path to project>
Rscript TSPBench.R
```
default R home directory : ~/



This will create two CSV files in your R home directory, data15.csv and data25.csv.
data15.csv contains the benchmark for 20 TSPs of size 15.
data25.csv contains the benchmark for 20 TSPs of size 25.

Labels in the CSV files:
* RandomDist : length of random tour
* optDist : length of optimal tour
* vnDist : length of Variable Neighbourhood tour
* vnTime : time of Variable Neighbourhood tour computation
* vNIterations : number of iterations in Variable Neighbourhood tour computation


### What you probably don't want to do :
run TSPGenerate.R to generate random TSPLIB files usable by Concorde (and most other TSP solvers).
Only run TSPGenerate.R if you have a working installation of Concorde and are willing to generate the optimal tour files by hand.
After having run TSPGenerate.R, the TSP files will be in /samples15 for the TSPs of size 15 and in /samples25 for the TSPs of size 25.
Use Concorde to generate the optimal tours for each ConcordeFile\<i\>.tsp file and save them as \<i\>.cyc.
This can be automated with a GUI automation scripting language such as [AutoIT](https://www.autoitscript.com/site/autoit/).
