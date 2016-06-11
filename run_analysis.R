filesPath <- "C:/Users/Howard/Documents/Coursera Data Science Stream/03. Cleaning Data/Project"
setwd(filesPath)
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile="./data/Dataset.zip"
download.file(fileUrl,destfile=destfile)

# Unzip DataSet
unzip(zipfile="./data/Dataset.zip",exdir="./data")

# Load required packages
library(dplyr)
library(data.table)
library(tidyr)

filesPath <- "C:/Users/Howard/Documents/Coursera Data Science Stream/03. Cleaning Data/Project/data/UCI HAR Dataset"

# Read Subject files
dataSubjectTrain <- tbl_df(read.table(file.path(filesPath, "train", "subject_train.txt")))
dataSubjectTest  <- tbl_df(read.table(file.path(filesPath, "test" , "subject_test.txt" )))

# Read Activity files
dataActivityTrain <- tbl_df(read.table(file.path(filesPath, "train", "y_train.txt")))
dataActivityTest  <- tbl_df(read.table(file.path(filesPath, "test" , "y_test.txt" )))

# Read data files
dataTrain <- tbl_df(read.table(file.path(filesPath, "train", "X_train.txt" )))
dataTest  <- tbl_df(read.table(file.path(filesPath, "test" , "X_test.txt" )))

# For both Activity and Subject files, merge training and test sets by row binding and rename variables "subject" and "activityNum"
alldataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
setnames(alldataSubject, "V1", "subject")
alldataActivity<- rbind(dataActivityTrain, dataActivityTest)
setnames(alldataActivity, "V1", "activityNum")

# Combine the training and test dataset
dataTable <- rbind(dataTrain, dataTest)

# Name variables according to features
dataFeatures <- tbl_df(read.table(file.path(filesPath, "features.txt")))
setnames(dataFeatures, names(dataFeatures), c("featureNum", "featureName"))
colnames(dataTable) <- dataFeatures$featureName

# Name column of activity labels according to activities
activityLabels <- tbl_df(read.table(file.path(filesPath, "activity_labels.txt")))
setnames(activityLabels, names(activityLabels), c("activityNum","activityName"))

# Merge columns of subject, activity and data
alldataSubAct<- cbind(alldataSubject, alldataActivity)
dataTable <- cbind(alldataSubAct, dataTable)

# Read "features.txt" and extract featureName of mean and standard deviation
dataFeaturesMeanStd <- grep("mean\\(\\)|std\\(\\)",dataFeatures$featureName,value=TRUE) #var name

# Add "subject","activityNum" to featureName of mean and standard deviation
# Subset corresponding dataset 
dataFeaturesMeanStd <- union(c("subject","activityNum"), dataFeaturesMeanStd)
dataTable<- subset(dataTable,select=dataFeaturesMeanStd) 

# Merge "activityLabels" and "dataTable" with "activityNum" as key
dataTable <- merge(activityLabels, dataTable , by="activityNum", all.x=TRUE)
dataTable$activityName <- as.character(dataTable$activityName)

# Create dataTable with variable means sorted by Subject and Activity
dataAggr<- aggregate(. ~ subject - activityName, data = dataTable, mean) 
dataTable<- tbl_df(arrange(dataAggr,subject,activityName))

# Column names before rename
head(str(dataTable),2)

# Rename columns
names(dataTable)<-gsub("std()", "SD", names(dataTable))
names(dataTable)<-gsub("mean()", "MEAN", names(dataTable))
names(dataTable)<-gsub("^t", "time", names(dataTable))
names(dataTable)<-gsub("^f", "frequency", names(dataTable))
names(dataTable)<-gsub("Acc", "Accelerometer", names(dataTable))
names(dataTable)<-gsub("Gyro", "Gyroscope", names(dataTable))
names(dataTable)<-gsub("Mag", "Magnitude", names(dataTable))
names(dataTable)<-gsub("BodyBody", "Body", names(dataTable))

# Column names after rename
head(str(dataTable),6)

# Write table result to "TidyData.txt"
write.table(dataTable, "TidyData.txt", row.name=FALSE)
