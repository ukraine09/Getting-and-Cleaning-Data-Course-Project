# What should you do

Upload data from source provided below into R. Use run_analysis.R 

# Data source
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# What run_analysis.R does:

Step 1: Merges the training and the test sets to create one data set. This includes: 

Reading files, reading trainings tables, reading testing tables, reading feature vector, reading activity labels, 
assigning column names, merging all data in one set.

Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. This includes:

Reading column names, creating vector for defining ID, mean and standard deviation, making nessesary subset from finaldataset

Step 3: Uses descriptive activity names to name the activities in the data set

Step 4: Appropriately labeles the data set with descriptive variable names

Step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject. This 
include: 

Making second tidy data set, writing second tidy data set in txt file. 
