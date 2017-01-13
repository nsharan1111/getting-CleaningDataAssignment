## 1. Merges the training and the test sets to create one data set.

fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = ".\\R\\dataset.zip", mode="wb")
unzip(".\\R\\dataset.zip", exdir = ".\\R\\UCI HAR Dataset")

f1<- ".\\R\\UCI HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt"
subjecttest<- read.table(f1)

f2<- ".\\R\\UCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt"
testx<-read.table(f2)

f3<- ".\\R\\UCI HAR Dataset\\UCI HAR Dataset\\test\\Y_test.txt"
testy<-read.table(f3)

f4<- ".\\R\\UCI HAR Dataset\\UCI HAR Dataset\\test\\subject_train.txt"
subjecttrain<-read.table(f4)

f5<- ".\\R\\UCI HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt"
trainx<-read.table(f5)

f6<- ".\\R\\UCI HAR Dataset\\UCI HAR Dataset\\train\\Y_train.txt"
trainy<-read.table(f6)

testdata<- cbind(subjecttest, testy, testx)
traindata<- cbind(subjecttrain, trainy, trainx)
finaldata<- rbind(traindata, testdata)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

ftrtemp<- read.table(".\\R\\UCI HAR Dataset\\UCI HAR Dataset\\features.txt", stringsAsFactors = FALSE)
ftrnames<- ftrtemp[,2]
featuresrownum<- grep("mean|std", ftrnames)
featuresnames<- grep("mean|std", ftrnames, value = TRUE)
meanstd<- finaldata[, c(1,2,featuresrownum+2)]
meanstdfinal<- setNames(meanstd, c("subject", "activity", featuresnames))

## 3. Uses descriptive activity names to name the activities in the data set

activity_labels<- read.table(".\\R\\UCI HAR Dataset\\UCI HAR Dataset\\activity_labels.txt")
meanstdfinal$activity<- factor(meanstdfinal$activity, levels = activity_labels$V1,
                             labels = activity_labels$V2)

## 4. Appropriately labels the data set with descriptive variable names.

names(meanstdfinal) <- gsub("\\()", "", names(meanstdfinal))
names(meanstdfinal) <- gsub("\\-", "", names(meanstdfinal))
names(meanstdfinal) <- gsub("mean", "Mean", names(meanstdfinal))
names(meanstdfinal) <- gsub("std", "Std", names(meanstdfinal))
names(meanstdfinal) <- gsub("BodyBody", "Body", names(meanstdfinal))
names(meanstdfinal) <- gsub("^t", "time", names(meanstdfinal))
names(meanstdfinal) <- gsub("^f", "frequency", names(meanstdfinal))
names(meanstdfinal) <- gsub("Acc", "Accelerometer", names(meanstdfinal))
names(meanstdfinal) <- gsub("Mag", "Magnitude", names(meanstdfinal))


## 5. From the data set in step 4, creates a second, 
##independent tidy data set with the average of each variable for each activity and each subject.

install.packages("dplyr")
library(dplyr)
meanstdfinalgroup<- group_by(meanstdfinal,subject,activity)
summarise_each(meanstdfinalgroup, funs(mean))



























