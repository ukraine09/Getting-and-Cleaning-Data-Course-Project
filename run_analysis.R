# this is Getting-and-Cleaning-Data-Course-Project R code 

# download, unzip files, check if data directory consist files 

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/projectdataset.zip")
unzip(zipfile="./data/projectdataset.zip",exdir="./data")
list.files("./data")

# Reading training and testing tables:

x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

View(x_train)
View(y_train)
View(subject_train)

x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

View(x_test)
View(y_test)
View(subject_test)

# Reading features vector:

features <- read.table('./data/UCI HAR Dataset/features.txt')
View(features)

# Reading activity labels:

activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')
View(activityLabels)

# Assigning column names:

colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

# Merging data sets: 

merge_train <- cbind(y_train, subject_train, x_train)
View(merge_train)

merge_test <- cbind(y_test, subject_test, x_test)
View(merge_test)

finaldataset <- rbind(merge_train, merge_test)
View(finaldataset)

# Extracting mean and sd measurements 

mycolNames <- colnames(finaldataset) # read column names


mean_std <- (grepl("activityId" , mycolNames) | grepl("subjectId" , mycolNames) | grepl("mean.." , mycolNames) | 
                 grepl("std.." , mycolNames))  # Create vector to define ID, mean and standard deviation:

mean_std_set <- finaldataset[ , mean_std == TRUE] # subset

# Name the activities in data set using descriptive activity names:

activity_names_set <- merge(mean_std_set, activityLabels, by='activityId', all.x=TRUE) 

View(activity_names_set)

# Create and write second tidy data set: 

tidy_set2 <- aggregate(. ~subjectId + activityId, activity_names_set, mean)
tidy_set2 <- tidy_set2[order(tidy_set2$subjectId, tidy_set2$activityId),]
View(tidy_set2)

write.table(tidy_set2, "tidy_set2.txt", row.name=FALSE)
