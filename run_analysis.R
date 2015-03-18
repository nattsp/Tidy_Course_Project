## Getting and cleaning Data
## Creating a tidy data set

# Create a data directory if one doesn't already exist.
if (!file.exists("data")){    
    dir.create("data")
}

# Download a file from the internet if it is not alreay there.
if (!file.exists(".\\data\\HAR_Dataset.zip")){
    print("Downloading")
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, destfile = ".\\data\\HAR_Dataset.zip")
}

zipFiles <- unzip(
    zipfile=".\\data\\HAR_Dataset.zip",
    list=TRUE
    )
data1 <- readLines(unz(".\\data\\HAR_Dataset.zip",
                       filename="UCI HAR Dataset/activity_labels.txt"
                       ))

body_acc_x_test <- readLines(
    unz(".\\data\\HAR_Dataset.zip",
    filename="UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
    )

columnWidths = rep(16, 128)

body_acc_x_test <- read.fwf(
    unz(
        ".\\data\\HAR_Dataset.zip",
        filename="UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt"
        ),
    widths=columnWidths
)

head(body_acc_x_test)
str(body_acc_x_test)

head(body_acc_x_test[c(1, 2, 3)], 3L)
