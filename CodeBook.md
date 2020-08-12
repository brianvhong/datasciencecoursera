---
title: "CodeBook"
author: "Brian"
output: 
html_document:
        keep_md: true
---

1st: **Dataset**
- Data was downloaded directly from [Here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and unzipped manually in my R project folder.

2nd: **Create an object for each data within .txt file**

- `features` <- `features.txt` **561 observations, 2 variables**
        Raw signals derived from accelerometer and gyroscope
        
- `activity_labels` <- `activity_labels.txt` **6 observations, 2 variables**
        Contains the code that referes to the specific activities conducted and         measurements
        
- `subject_test` <- `subject_test.txt` **2947 observation, 1 variables**
        Observational data from test subject
        
- `x_test` <- `x_test.txt` **2947 observation, 561 variables** 
        Raw test data
        
- `y_test` <- `y_test.txt` **2947 observation, 1 variable**
        Activties code with levels 1:6
        
- `subject_train` <- `subject_train.txt` **7352 observation, 1 variable**
        Subjects data from training
        
- `x_train` <- `x_train.txt` **7352 observation, 561 variables**
        Raw training data
        
- `y_train` <- `y_train.txt` **7352 observation, 1 variable**
        Code levels 1:6 for activities label

3rd: **Here we combine the data set by row using** `rbind()` **and column using** `cbind()`

- `X_set` has **10299 observation and 561 variables** by row binding `x_train` and `x_test`

- `Y_set` has **10299 oservation and 1 variable** by row binding `y_train` and `y_test`

- `Subject_set` has **10299 observation and 1 variable** by row binding `subject_train` and `subject_test`

- `One_data` has **10299 observation and 563 variables** by column binding `Subject_set`, `Y_set`, and `X_set`

4th: **Here we extract the measurement on the mean and standard devation for all measurements**

- `mean_sd` <- `One_data`**10299 observations and 563 variables**

selects measurements that contains mean and standard deviation for column `code` and `subject`

5th: **Here we use descriptive activity names to name the activities in the data set**

-`mean_sd$code` <- `activity_labels[mean_sd$code, 2]`

6th: **Here we label the data set with descriptive variable names**

- `code` to `Activities`

- `Acc` to `Accelerometer`

- `Gyro` to `Gyroscope`

- `BodyBody` to `Body`

- `Mag` to `Magnitude`

- `^t` to `Time` 

- `^f` to `Frequency`

- `tBody` to `TimeBody`

- `-mean()` to `Mean`

- `-std()` to `STD`

- `freq()` to `Frequency`

- `angle` to `Angle`

- `gravity` to `Gravity` 

7th **Lastly, I created  a second, independent tidy data set with the average of each variable for each activity and each subject.**

`Last` <- using `dplyr` package to summarize means for the groups `subject` and `Activtiy`


