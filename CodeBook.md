#### The run_analysis.R script takes data from a downloaded dataset and performs a number of functions:

1. Downloads the dataset under the folder "UCI HAR Dataset" <br/>

2. Assigns the data from the text files to variables <br/>
  activities: contains data from activity_labels.txt <br/>
  features: contains data from features.txt <br/>
  subjectTest: contains data from subject_test.txt from the test subfolder <br/>
  xTest: contains data from X_test.txt from the test subfolder <br/>
  yTest: contains data from y_test.txt from the test subfolder <br/>
  subjectTrain: contains data from subject_train.txt from the train subfolder <br/>
  xTrain: contains data from X_train.txt from the train subfolder <br/>
  yTrain: contains data from y_train.txt from the train subfolder <br/>
  
3. Merges the training and test sets to create one dataset <br/>
   x: uses rbind() to merge xTrain and xTest <br/>
   y: uses rbind() to merge yTrain and yTest <br/>
   subject: uses rbind() to merge subjectTrain and subjectTest <br/>
   merged: uses cbind() to merge subject, x, and y <br/>
   
4. Extracts only the measurements on the mean and standard deviation for each measurement <br/>
  extractData: subsets 'merged' using only the subject and id columns, and measurements on the mean and 
  standard deviation for each measurement
  
5. Uses descriptive activity names to name the activities in the data set by replacing numbers in the 'id' 
  column of 'extractData' with the corresponding activity from the second column of 'activities' <br/>
  
6. Appropriately labels the data set with descriptive variable names <br/>
  id renamed to activities <br/>
  Acc renamed to Accelerometer <br/>
  Gyro renamed to Gyroscope <br/>
  BodyBody renamed to Body <br/>
  Mag renamed to Magnitude <br/>
  f renamed to Frequency <br/>
  t renamed to Time <br/>
  
7. Creates a final tidy data set with the average of each variable for each activity and each subject <br/>
  finalData: summarizes 'extractData' and takes the means of each variable for each activity and subject,
  grouping by activity and subject and is then exported to a 'finalData.txt' file
