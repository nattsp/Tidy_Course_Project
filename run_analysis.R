## Getting and cleaning Data
## Creating a tidy data set

library(dplyr)

# Download the Samsung into a data directory
# Create a data directory if one doesn't already exist.
if (!file.exists("data")){    
    dir.create("data")
}

# Download the zip file from the internet if it is not alreay there.
if (!file.exists(".\\data\\HAR_Dataset.zip")){
    print("Downloading")
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, destfile = ".\\data\\HAR_Dataset.zip")
} else {
    print("File already downloaded.")
}

# Get a list of all the files within the zip file Har_Dataset.zip
zipFiles <- unzip(
    zipfile=".\\data\\HAR_Dataset.zip",
    list=TRUE
    )
print("The files in the Har_Dataset.Zip are:")
print(zipFiles)


## Step 1

# Load both the training set and test set data
con <- unz(".\\data\\HAR_Dataset.zip", filename="UCI HAR Dataset/train/X_train.txt")
X_train <- read.table(con)
con <- unz(".\\data\\HAR_Dataset.zip", filename="UCI HAR Dataset/test/X_test.txt")
X_test <- read.table(con)

# Merge Training and test sets
X <- rbind(X_test, X_train)


## Step 2 (and 4)

# Read the variable names from the file called features.txt
con <- unz(".\\data\\HAR_Dataset.zip", filename="UCI HAR Dataset/features.txt")
features <- read.table(con, stringsAsFactors=FALSE)

# Rename all the columns with the names of the variables from features
names(X) <- features[, 2]

# Sub set the data X to leave only columns for mean and standard devaiation
# List all the column names with mean() or std()
# \\( allows us to search for (
meanStd <- grepl("mean\\(\\)", features[, 2]) | grepl("std\\(\\)", features[, 2])
XSub <- X[, meanStd]

# Load the list of subjects for both the training set and test set data
con <- unz(".\\data\\HAR_Dataset.zip", filename="UCI HAR Dataset/train/subject_train.txt")
subject_train <- read.table(con, col.names="Subject")
con <- unz(".\\data\\HAR_Dataset.zip", filename="UCI HAR Dataset/test/subject_test.txt")
subject_test <- read.table(con, col.names="Subject")

# Merge Training and test sets
subject <- rbind(subject_test, subject_train)

# Add the subject column to the XSub data
XSub$Subject <- subject$Subject
# As you can see there are 30 subjects with rughly the same number of observations
table(XSub$Subject)


## Step 4

# Load the list of activities for both the training set and test set data
con <- unz(".\\data\\HAR_Dataset.zip", filename="UCI HAR Dataset/train/y_train.txt")
Activity_train <- read.table(con, col.names="Activity_code")
con <- unz(".\\data\\HAR_Dataset.zip", filename="UCI HAR Dataset/test/y_test.txt")
Activity_test <- read.table(con, col.names="Activity_code")
con <- unz(".\\data\\HAR_Dataset.zip", filename="UCI HAR Dataset/activity_labels.txt")
activity_labels <- read.table(con, col.names=c("Activity_code", "Activity"), stringsAsFactors=FALSE)

# Merge Training and test sets for Activity - this is in the same order as X and Subject
Activity <- rbind(Activity_test, Activity_train)
# Add the descriptive name of the activity
ActivityName <- inner_join(Activity, activity_labels)
# Combine the descriptive name of the actvity to the data
XSub$Activity <- ActivityName$Activity

## Step 4
# Descriptive names for the variables was already perfomed before subsetting.


## Step 5

DataTbl <- tbl_df(XSub)
DataGroup <- group_by(DataTbl, Subject, Activity)

TidyMean <- DataTbl %>%
    group_by(Subject, Activity) %>%
    summarise_each(funs(mean))

write.table(TidyMean, file = "TidyData.txt", row.name=FALSE)

tidy <- read.table("TidyData.txt", header=TRUE)
