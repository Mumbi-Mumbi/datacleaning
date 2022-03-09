## loading the various data set into R using the read.table function and navigating to their location

test <- read.table("./UCI HAR Dataset/test/X_test.txt")
train <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#merging all the data sets for test together using the cbind() function to merge using columns
#merging all the data sets for train together using the cbind() function to merge using columns

test <- cbind(test, ytest, subject_test)
train <- cbind(train, ytrain, subject_train)

#reading all the feature names in the features.txt file which will be used to name the columns in the merged data set

features <- read.table("./UCI HAR Dataset/features.txt")
features <- t(features[2])

#merging the previously merged the data sets together to create one final data set having all the variable readings as well as the activity and subject variable 
#renaming the columns using the names in the features vector
#renaming the last two columns appropriately since their column names are not in the features.txt file

mergedDataset <- rbind.data.frame(test, train)
colnames(mergedDataset) <- features
names(mergedDataset)[562] <- "Activity"
names(mergedDataset)[563] <- "Subject"

#creating a vector with indices where the word mean, std, activity or subject appear in the column names which will used to subset the data set to just have columns with those names
#using the subset function select argument to subset the merged data set by the column indices in the column vector

columns <- grep(".*Mean.*|.*Std.*|activity|subject",colnames(mergedDataset), ignore.case = TRUE)
mergedDataset <-  subset(mergedDataset, select = columns)

#converting the activity column to a factor class
#using the levels function to rename the factors in activity column to the appropriate activity name

mergedDataset$Activity <- as.factor(mergedDataset$Activity)
mergedDataset$Subject <- as.factor(mergedDataset$Subject)
levels(mergedDataset$Activity) <- c("Walking", "Walking upstairs", "Walking downstairs", "Sitting", "Standing", "Laying")

#renaming all the other columns
names(mergedDataset)<-gsub("Acc", "Accelerometer", names(mergedDataset))
names(mergedDataset)<-gsub("Gyro", "Gyroscope", names(mergedDataset))
names(mergedDataset)<-gsub("BodyBody", "Body", names(mergedDataset))
names(mergedDataset)<-gsub("^t", "Time", names(mergedDataset))
names(mergedDataset)<-gsub("^f", "Frequency", names(mergedDataset))
names(mergedDataset)<-gsub("tBody", "TimeBody", names(mergedDataset))
names(mergedDataset)<-gsub("-mean()", "Mean", names(mergedDataset), ignore.case = TRUE)
names(mergedDataset)<-gsub("-std()", "STD", names(mergedDataset), ignore.case = TRUE)
names(mergedDataset)<-gsub("-freq()", "Frequency", names(mergedDataset), ignore.case = TRUE)
names(mergedDataset)<-gsub("angle", "Angle", names(mergedDataset))
names(mergedDataset)<-gsub("gravity", "Gravity", names(mergedDataset))

#load reshape package to use the melt function
#melt the data using Activity and Subject as IDs and everything else as variables
#use the dcast function to calculate the mean of each variable for each activity for each subject
library(reshape2)
melted <- melt(mergedDataset, id = c("Activity", "Subject"), measure.vars = c(1:86))
tidy <- dcast(melted, Subject + Activity ~ variable, mean)

#write the new data set to a file named tidy_data.txt
write.table(tidy, "tidy.txt", row.names = FALSE)


