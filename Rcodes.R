setwd("C:/Users/majidk/Desktop/Data Scientist/8_Practical Machine Learning/Project")
library(caret)
library(rpart)
library(rpart.plot)
library(randomForest)
test <- read.csv("pml-testing.csv", header=T, na.strings = c("NA", "#DIV/0!", ""))
train <- read.csv("pml-training.csv", header=T, na.strings = c("NA", "#DIV/0!", ""))
train2 <- train[, apply(train, 2, function(x) !any(is.na(x)))] 
test2 <- test[, apply(test, 2, function(x) !any(is.na(x)))]
train3 <- train2 [,-c(1:8)]
test3 <- test2 [,-c(1:8)]
set.seed(65478)
inTrain <- createDataPartition(y=train3$classe, p=0.75, list=FALSE)
training  <- train3[inTrain,]
testing  <- train3[-inTrain,]
set.seed(654789)
cartmodel <- rpart(classe ~ ., data=training, method="class")
prp(cartmodel)
set.seed(6547891)
rfmodel <- randomForest(classe ~. , data=training)
precart <- predict(cartmodel, testing, type = "class")
confusionMatrix(precart, testing$classe)
prerf <- predict(rfmodel, testing, type = "class")
confusionMatrix(prerf, testing$classe)