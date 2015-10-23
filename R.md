#reading data sets
> subtest<- read.table(file.choose())
> subtrain<- read.table(file.choose())
> xtest<- read.table(file.choose())
> xtrain<- read.table(file.choose())
> ytest<- read.table(file.choose())
> ytrain<- read.table(file.choose())

#merging data sets to create one data set
> subdata<- rbind(subtest,subtrain)
> xdata<- rbind(xtest,xtrain)
> ydata<- rbind(ytest,ytrain)

#Extracts only the measurements on the mean and std for each measurement
> features<- read.table(file.choose())
> m_std_feat <- grep("-(mean|std)\\(\\)", features[, 2])
> xdata2<- xdata[, m_std_feat]
> names(xdata2)<- features[m_std_feat, 2]

#Uses descriptive activity names to name the activities in the data set
> activity<- read.table(file.choose())
> ydata[, 1] <- activity[ydata[, 1], 2]

#Appropriately labels the data set with descriptive variable names
> names(ydata) <- "activity"
> names(subdata) <- "subject"
> Finaldata <- cbind(xdata2, ydata, subdata)

#creates a second, independent tidy data set with the average of each variable for each activity and each subject
> Finaldata2 <- ddply(Finaldata, .(subject, activity), function(x) colMeans(x[, 1:66]))
> write.table(Finaldata2, "tidy.txt", row.name=FALSE)
