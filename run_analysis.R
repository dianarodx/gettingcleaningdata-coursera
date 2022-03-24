#download file
if (!file.exists("Coursera_DS3_Final.zip")) {
  download.file(
    "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
    "Coursera_DS3_Final.zip", method="curl")
}

#download folder
if(!file.exists("UCI HAR Dataset")) {
  unzip("Coursera_DS3_Final.zip")
}

#assign data frames to variables
activities <- read.table("UCI HAR Dataset/activity_labels.txt",
                         col.names = c("id", "activity"))
features <- read.table("UCI HAR Dataset/features.txt", 
                       col.names = c("id", "functions"))
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                          col.names = "subject")
xTest <- read.table("UCI HAR Dataset/test/X_test.txt", 
                    col.names = features$functions)
yTest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "id")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt",
                           col.names = "subject")
xTrain<- read.table("UCI HAR Dataset/train/X_train.txt",
                           col.names = features$functions)
yTrain<- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "id")

#merge training and test sets to make one data set
x <- rbind(xTrain, xTest)
y <- rbind(yTrain, yTest)
subject <- rbind(subjectTrain, subjectTest)
merged <- cbind(x, y, subject)

#extract mean and stdev measurements for each measurement
extractData <- merged %>% select(subject, id, contains("mean"), contains("std"))

#name activites in data set
extractData$id <- activities[extractData$id, 2]

#label data set
names(extractData)[2] = "activity"
names(extractData) <- gsub("Acc", "Accelerometer", names(extractData))
names(extractData) <- gsub("Gyro", "Gyroscope", names(extractData))
names(extractData) <- gsub("BodyBody", "Body", names(extractData))
names(extractData) <- gsub("Mag", "Magnitude", names(extractData))
names(extractData) <- gsub("^t", "Time", names(extractData))
names(extractData) <- gsub("^f", "Frequency", names(extractData))
names(extractData) <- gsub("tBody", "TimeBody", names(extractData))
names(extractData) <- gsub("-mean()", "Mean", names(extractData))
names(extractData) <- gsub("-std()", "Standard Deviation", names(extractData))
names(extractData) <- gsub("-freq()", "Frequency", names(extractData))
names(extractData) <- gsub("angle", "Angle", names(extractData))
names(extractData) <- gsub("gravity", "Gravity", names(extractData))

#independent tody data set wjth avg of each variable for each activity/subject
finalData <- extractData %>% 
  group_by(subject, activity) %>% 
  summarise_all(funs(mean))
write.table(finalData, "finalData.txt", row.name = FALSE)
