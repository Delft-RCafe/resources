setwd("")

#install.packages("psych")
#install.packages("bootnet")
#install.packages("mgm")
#install.packages("qgraph")
#install.packages("memisc")
#install.packages("NetworkComparisonTest")
#install.packages("graphicalVAR")

library(psych)
library(bootnet)
library(mgm)
library(qgraph)
library(memisc)
library(NetworkComparisonTest)
library(graphicalVAR)

#Load data
data("bfi")

#Check data
head(bfi)

#drop missing values
bfiNoNa <- na.omit(bfi[,])

#Some items are reverse coded (see bfi.keys), so recoding
bfiNoNa$A1 <- 7-bfiNoNa$A1
bfiNoNa$C4 <- 7-bfiNoNa$C4
bfiNoNa$C5 <- 7-bfiNoNa$C5
bfiNoNa$E1 <- 7-bfiNoNa$E1
bfiNoNa$E2 <- 7-bfiNoNa$E2
bfiNoNa$O2 <- 7-bfiNoNa$O2
bfiNoNa$O5 <- 7-bfiNoNa$O5

#calculating sumscores
bfiSumScores <- data.frame(Agreeableness = rowSums(bfiNoNa[,1:5]),
                           Conscientiousness = rowSums(bfiNoNa[,6:10]),
                           Extraversion = rowSums(bfiNoNa[,11:15]),
                           Neuroticism = rowSums(bfiNoNa[,16:20]),
                           Openness = rowSums(bfiNoNa[,21:25]))

#estimating simplest network
pmrf <- estimateNetwork(bfiSumScores, 
                        default = "pcor",     #we'll check a few later
                        corMethod = "cor"     #cor, cov, spearman... #,fun
                        #, labels = c()         #a character vector if names other than columns are to be used
                        #, .dots = list()
                        #, weighted =           #logical, should the network be weighted?
                        #, signed =             #logical, should the networks' relations have signs?
                        #, directed =           #logical, is the network directed? detected automatically
)                     #Question, what are the values of the arguments weighted, signed, and directed in our case?

#plotting network
plot(pmrf)

#TUNNING
boot_cor <- estimateNetwork(bfiSumScores, 
                            default = "pcor",
                            corMethod = "cor",
                            threshold = "sig", #Now we are saying to keep all edges significant at a specific level
                            alpha = ) #Change the threshold with values from 0 to 1, what happens?
#Does anything change? What? Why?
#Change the alpha with values from 0 to 1, what happens?
#Does anything change? What? Why?
plot(boot_cor)

#To get the results                                                     
boot_cor$graph

#PRUNNING
boot_cor <- estimateNetwork(bfiSumScores, 
                            default = "EBICglasso",
                            corMethod = "cor",
                            tuning = ) #Change the threshold with values from 0 to 1, what happens?
#Does anything change? What? Why?
#Change the alpha with values from 0 to 1, what happens?
#Does anything change? What? Why?
boot_cor$graph

plot(boot_cor)

#PRUNING WITH SMALLER SAMPLE
bfiSumScores_less <- bfiSumScores[round(runif(n=20, min=1, max=20), 0),]

boot_cor <- estimateNetwork(bfiSumScores_less, 
                            default = "EBICglasso",
                            corMethod = "cor",
                            tuning = ) #Change the threshold with values from 0 to 1, what happens?
#Does anything change? What? Why?
#Change the alpha with values from 0 to 1, what happens?
#Does anything change? What? Why?
boot_cor$graph

plot(boot_cor)

#DICHOTOMOUS DATA
boot_bi <- estimateNetwork(bfiSumScores_less, 
                           default = "IsingFit",
                           split = "median") #Change the threshold with values from 0 to 1, what happens?
#Does anything change? What? Why?
#Change the alpha with values from 0 to 1, what happens?
#Does anything change? What? Why?
boot_cor$graph

plot(boot_bi)

#MIXED DATA
data("autism_data_large")

autism_data_large <- autism_data_large$data

head(autism_data_large)

#Specify variables
type <-  c("c", "g", "g", "c", "g", "c", "c", "p", "p", "p", "p", "p", "p", "c", "p", "c", "g", "p", "p",
           "p", "p", "g", "g", "g", "g", "g", "c", "g")

level <- c(2, 1, 1, 2, 1, 5, 3, 1, 1, 1, 1, 1, 1, 2, 1, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1)

#fitting model
fit_ADS <- mgm(data = as.matrix(autism_data_large), 
               type = type,
               level = level
               #k = 2, 
               #lambdaSel = 'EBIC', 
               #lambdaGam = 0.25, 
               #pbar = FALSE
)

#extracting relations
fit_ADS$pairwise$wadj

#fit_ADS$interactions

qgraph(fit_ADS$pairwise$wadj,
       edge.color = fit_ADS$pairwise$edgecolor)

#MAKE YOUR OWN NETWORK
dataset <- data.frame(as.data.set(spss.system.file("/Users/administrator/Desktop/PhD/Conferences/TU Delft - R café/PTSD2017code.sav")))

#EXPLORE YOUR NETWORK

#Global properties:
#Number of non-zero edges?

#How connected is the network?

#Local properties
centralityPlot(yournetwork,include = c("Closeness", "Betweenness", "Strength"))

#Stability of the relations in your network
# Perform bootstrap in bootnet
Boot_nonparametric <- bootnet(
  network_PTSD,
  nBoots = 1000,
  nCores = 8)

# Plot accuracy
plot(Boot_nonparametric,
     order = "sample",
     labels = FALSE)

# Plot differences
plot(Boot_nonparametric,
     plot = "difference",
     onlyNonZero = TRUE,
     order = "sample")

#NETWORK COMPARISON TEST
#1. Split your network

#e.g. 
#ptsd_junior <- dataset[dataset[,2]<65,]
#ptsd_senior <- dataset[dataset[,2]>=65,]

network_one <- dataset[dataset[,]==,]
network_two <- dataset[dataset[,]==,]

#2. Fit the networks 



#3. Compare the networks
compare <- NCT(network_one,
               network_two,
               test.edges = TRUE)

summary(compare)

# Obtain significant different edge weights
compare$einv.pvals[which(compare$einv.pvals[,3]<0.05),]

#TEMPORAL NETWORKS
ESMdataset <- read.csv("/Users/administrator/Desktop/PhD/Conferences/TU Delft - R café/ESMdata.csv", header=TRUE, stringsAsFactors=FALSE)

vars = c("mood_relaxed", "mood_down", "mood_irritat", "mood_satisfi", "mood_lonely", "mood_anxious", "mood_enthus", "mood_suspic",     "mood_cheerf", "mood_guilty", "mood_doubt", "mood_strong")

var <- graphicalVAR(ESMdataset, vars = vars, dayvar = "dayno", beepvar = "beepno")

var$PCC

var$PDC

plot(var)

