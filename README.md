Getting and Cleaning Data Course Project
===========

This assignment uses measurements taken from SmartPhones to test our ability to load and minipulate data and in particular produce tidy data.

In the file run_analysis.R you will see
* data being loaded
* files being extracted from zip file
* 6 files being combined (3 test and 3 train) to make our data set
* column names being applied
* activity names being applied

A tidy data set is then produced
* One row for each subject (person) activity pair
* Each column being a variable (average of all values for that subject activity)

In order to test the tidy data set please read it in using the following command in R
tidy <- read.table("TidyData.txt", header=TRUE)