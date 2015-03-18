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

data <- read.table(unz(temp, "getdata-projectfiles-UCI HAR Dataset.zip"))