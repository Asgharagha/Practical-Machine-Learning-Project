## Uploading Required Packages
> library(caret)
> library(rpart)
> library(rpart.plot)
> library(randomForest)

# Importing Data
> train <- read.csv(file.choose(), header=T, na.strings = c("NA", "#DIV/0!", ""))
> str(train)
> test <- read.csv(file.choose(), header=T, na.strings = c("NA", "#DIV/0!", ""))
> str(test)

# Cleaning Data
> train2 <- train[, apply(train, 2, function(x) !any(is.na(x)))] 
> test2 <- test[, apply(test, 2, function(x) !any(is.na(x)))] 
> train3 <- train2 [,-c(1:8)]
> test3 <- test2 [,-c(1:8)]

# Spliting Data
> set.seed(95137)
> inTrain <- createDataPartition(y=train3$classe, p=0.75, list=FALSE)
> training  <- train3[inTrain,]
> testing  <- train3[-inTrain,]

# Modeling
> set.seed(654123)
> cartmodel <- rpart(classe ~ ., data=training, method="class")
> fancyRpartPlot(cartmodel)
> prp(cartmodel)
> rfmodel <- randomForest(classe ~. , data=training)

## Results
> precart <- predict(cartmodel, testing, type = "class")
> confusionMatrix(precart, testing$classe)
> prerf <- predict(rfmodel, testing, type = "class")
> confusionMatrix(prerf, testing$classe)
