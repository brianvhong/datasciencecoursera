#Load dplyr Package
library(dplyr)

#Convert text into table
features <- read.table("features.txt", col.names = c("n","functions"))
activity_labels <- read.table("activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("test/subject_test.txt", col.names = "subject")
x_test <- read.table("./test/X_test.txt", col.names = features$functions)
y_test <- read.table("./test/y_test.txt", col.names = "code")
subject_train <- read.table("./train/subject_train.txt", col.names = "subject")
x_train <- read.table("./train/X_train.txt", col.names = features$functions)
y_train <- read.table("./train/y_train.txt", col.names = "code")

#Quetion 1: Merge data set into one
X_set <- rbind(x_train, x_test)
Y_set <- rbind(y_train, y_test)
Subject_set <- rbind(subject_train, subject_test)
One_data <- cbind(Subject_set, Y_set, X_set)

#Question 2: Extracts only the measurements on the mean and standard deviation for each measurement.

mean_sd <- One_data %>%
        select(subject, code, contains("mean"), contains("std"))

#Question 3: Uses descriptive activity names to name the activities in the data set
mean_sd$code <- activity_labels[mean_sd$code, 2]

#Question 4 Appropriately labels the data set with descriptive variable names.
names(mean_sd)[2] = "Activity"
names(mean_sd)<-gsub("Acc", "Accelerometer", names(mean_sd))
names(mean_sd)<-gsub("Gyro", "Gyroscope", names(mean_sd))
names(mean_sd)<-gsub("BodyBody", "Body", names(mean_sd))
names(mean_sd)<-gsub("Mag", "Magnitude", names(mean_sd))
names(mean_sd)<-gsub("^t", "Time", names(mean_sd))
names(mean_sd)<-gsub("^f", "Frequency", names(mean_sd))
names(mean_sd)<-gsub("tBody", "TimeBody", names(mean_sd))
names(mean_sd)<-gsub("-mean()", "Mean", names(mean_sd), ignore.case = TRUE)
names(mean_sd)<-gsub("-std()", "STD", names(mean_sd), ignore.case = TRUE)
names(mean_sd)<-gsub("-freq()", "Frequency", names(mean_sd), ignore.case = TRUE)
names(mean_sd)<-gsub("angle", "Angle", names(mean_sd))
names(mean_sd)<-gsub("gravity", "Gravity", names(mean_sd))

#Question 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Last <- mean_sd %>%
        group_by(subject, Activity) %>%
        summarise_all(funs(mean))

#Second data set
write.table(Last, "Last.txt", row.name=FALSE)

