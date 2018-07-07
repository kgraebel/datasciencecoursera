# README File for Getting and Cleaning Data Course Project

# Submission by Kevin Graebel

The analysis is done using data from the UCI HAR Data Set.

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data Loading

First, data is downloaded and unzipped on the local PC.  The working directory
is set to be inside the UCI HAR Dataset folder

The test and the train data were told to be combined, so that is just an rbind
to add them as additional observations

## Data Labeling

The "Y-train" data is the label for each of the observations, so a column
bind function is done to add that to the first column so it can be later
used for a grouping summary

The "features.txt" file is a description for each of the variables, so a column
labels command is used to apply that to the top.

Because the "Features.txt" descriptions were not unique, I appended the variable
number together with the description to create the column name

## Data manipulations

We just wanted to keep the "mean()" and the "std()" measurements of the
variables, so a select function from the dplyr function was combined with a 
cbind to create a new data set only containing those items

The activity labels were just labeled as "1-6" instead of a description, so a
loop goes through each of the items and replaces the number with the 
activity description from the activity_labels.txt file

Finally, a summary was done, first grouping by activity type, then using the
summarize_all dpylr function with the mean function.  

Data was then output to a table txt file in the working directory.
