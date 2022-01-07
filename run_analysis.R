-----------------------------
#title: "R_Analysis"
  #author: "Kalyani Tholeti"
  #date: "1/6/2022"

  #Description:  Data collected from the accelerometers from the Samsung Galaxy S smartphone
  #You should create one R script called run_analysis.R that does the following. 
  #1. Merges the training and the test sets to create one data set.
  #2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  #3. Uses descriptive activity names to name the activities in the data set
  #4. Appropriately labels the data set with descriptive variable names. 
  #5. From the data set in step 4, creates a second, independent tidy data set "tidy_data.txt" with the average of each variable for each activity and each subject.
# 1. Read Data
# read training data
trainingSubjects <- read.table(file.path("UCI HAR Dataset/", "train", "subject_train.txt"))
trainingValues <- read.table(file.path("UCI HAR Dataset/", "train", "X_train.txt"))
trainingActivity <- read.table(file.path("UCI HAR Dataset/", "train", "y_train.txt"))

# read test data
testSubjects <- read.table(file.path("UCI HAR Dataset/", "test", "subject_test.txt"))
testValues <- read.table(file.path("UCI HAR Dataset/", "test", "X_test.txt"))
testActivity <- read.table(file.path("UCI HAR Dataset/", "test", "y_test.txt"))

# read features
features <- read.table(file.path("UCI HAR Dataset/", "features.txt"), as.is = TRUE)

# read activity labels
activities <- read.table(file.path("UCI HAR Dataset/", "activity_labels.txt"))
colnames(activities) <- c("activityId", "activityLabel")

# Step 1 - Merge the training and the test sets to create one data set
all_data <- rbind(
  cbind(trainingSubjects, trainingValues, trainingActivity),
  cbind(testSubjects, testValues, testActivity)
)

# Step 2 - Extract only the measurements on the mean and standard deviation for each measurement
# Extract only the data on mean and standard deviation
# assign column names
colnames(all_data) <- c("subject", features[, 2], "activity")
columnsToKeep <- grepl("subject|activity|mean|std",colnames(all_data))



#3. Uses descriptive activity names to name the activities in the data set
# Read activity labels from the txt file
#turn activities & subjects into factors
all_data <- all_data[, columnsToKeep]

all_data$activity <- factor(all_data$activity, levels = activities[,1], labels = activities[,2])
all_data$subject <- as.factor(all_data$subject)



# 4.Appropriately label the data set with descriptive variable names
#creating one dataset
# get column names
# get column names
all_dataCols <- colnames(all_data)

# remove special characters
all_dataCols <- gsub("[\\(\\)-]", "", all_dataCols)

# expand abbreviations and clean up names
all_dataCols <- gsub("^f", "frequencyDomain", all_dataCols)
all_dataCols <- gsub("^t", "timeDomain", all_dataCols)
all_dataCols <- gsub("Acc", "Accelerometer", all_dataCols)
all_dataCols <- gsub("Gyro", "Gyroscope", all_dataCols)
all_dataCols <- gsub("Mag", "Magnitude", all_dataCols)
all_dataCols <- gsub("Freq", "Frequency", all_dataCols)
all_dataCols <- gsub("mean", "Mean", all_dataCols)
all_dataCols <- gsub("std", "StandardDeviation", all_dataCols)

# correct typo
all_dataCols <- gsub("BodyBody", "Body", all_dataCols)

# use new labels as column names
colnames(all_data) <- all_dataCols


# group by subject and activity and summarise using mean
tidy_data <- all_data %>% 
  group_by(subject, activity) %>%
  summarise_each(funs(mean))



# output to file "tidy_data.txt"
write.table(tidy_data, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)

write.csv(tidy_data, "tidy_data.csv", row.names = FALSE)
