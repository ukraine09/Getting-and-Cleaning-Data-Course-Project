
# this is Getting-and-Cleaning-Data-Course-Project R code 

# download, unzip files, check if data directory consist files 

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/projectdataset.zip")
unzip(zipfile="./data/projectdataset.zip",exdir="./data")
list.files("./data")

# Reading training and testing tables:
my_x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
my_y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
my_subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

my_x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
my_y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
my_subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")


# Reading features vector:
my_features <- read.table('./data/UCI HAR Dataset/features.txt')

# Reading activity labels:
activity_labels <- read.table('./data/UCI HAR Dataset/activity_labels.txt')


# Assigning column names:

colnames(my_x_train) <- my_features[,2] 
colnames(my_y_train) <-"activity"
colnames(my_subject_train) <- "subject"

colnames(my_x_test) <- my_features[,2] 
colnames(my_y_test) <- "activity"
colnames(my_subject_test) <- "subject"

colnames(activity_labels) <- c('activity','activityType')

# Merging data sets: 

merge_train <- cbind(my_y_train, my_subject_train, my_x_train)

merge_test <- cbind(my_y_test, my_subject_test, my_x_test)

finaldataset <- rbind(merge_train, merge_test)

# Extracting mean and sd measurements 

mycol_names <- colnames(finaldataset) # read column names


mean_std <- (grepl("activity" , mycol_names) | grepl("subject" , mycol_names) | grepl("mean.." , mycol_names) | 
                 grepl("std.." , mycol_names))  # Create vector to define ID, mean and standard deviation

mean_std_set <- finaldataset[ , mean_std == TRUE] # subset

# name the activities in data set using descriptive activity names

activity_names_set <- merge(mean_std_set, activity_labels, by='activity', all.x=TRUE) 


# create and write second tidy data set 

tidy_set2 <- aggregate(. ~ subject + activity, activity_names_set, mean)
tidy_set2 <- tidy_set2[order(tidy_set2$subject, tidy_set2$activity),]
View(tidy_set2)

write.table(tidy_set2, "tidy_set2.txt", row.name=FALSE)

