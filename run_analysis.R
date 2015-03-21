## Getting and cleaning Data
## Creating a tidy data set

library(dplyr)

# Create a data directory if one doesn't already exist.
if (!file.exists("data")){    
    dir.create("data")
}

# Download a file from the internet if it is not alreay there.
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
print("")

# This function will extract the files from a compressed file
getCompressed <- function(zipfilepath, extract) {
        con <- unz(zipfilepath, filename=extract)
        on.exit(close(con))
        unziped <-readLines(con)
        unziped
}
getCompressedfwf <- function(zipfilepath, extract, columnWidths) {
        con <- unz(zipfilepath, filename=extract)
        unziped <- read.fwf(con, widths=columnWidths)
        unziped
}

activities <- getCompressed(".\\data\\HAR_Dataset.zip",
                                "UCI HAR Dataset/activity_labels.txt")
subject_Test <- getCompressed(".\\data\\HAR_Dataset.zip",
                            "UCI HAR Dataset/test/subject_test.txt")
print(subject_Test)
length(subject_Test)
body_acc_x_test <- getCompressed(".\\data\\HAR_Dataset.zip",
                                 "UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
columnWidths = rep(16, 128)
body_acc_x_test <- getCompressedfwf(".\\data\\HAR_Dataset.zip",
                                 "UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt",
                                 columnWidths)

head(body_acc_x_test)
str(body_acc_x_test)

head(body_acc_x_test[c(1, 2, 3)], 3L)
