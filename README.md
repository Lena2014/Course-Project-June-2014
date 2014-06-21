README for run_analysis.R
========================================================
Date: June 19, 2014
========================================================

This README document describes what the "run_analysis.R" script does. Relevant to this document are:
- "run_analysis.R" script
- "TidyDataSet2.txt" file is the resulting dataset from the run_analysis.R script.
- "CodeBook.md" is the code book for TidyDataSet2 that is created by the run_analysis script. The Code Book describes the variables, summaries, and other information relevant to the data.

All the above files are located in the "Course-Project-June-2014" repo at https://github.com/Lena2014.


Required Data files:
========================================================

run_analysis.R uses data from the "Human Activity Recognition Using Smartphones Dataset" (HARUSD). This data is located at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

For information about HARUSD, see the README.txt that is included with that dataset.

The run_analysis.R script begins by downloading and unzipping all the files in this dataset. Not all the files are read in this script, but the script downloads all of them as part of best practices to keep the entire dataset and related files together.


The Assignment:
========================================================
create one R script called run_analysis.R that does the following: 
        #1.Merges the training and the test sets to create one data set.
        #2.Extracts only the measurements on the mean and standard deviation for each measurement. 
        #3.Uses descriptive activity names to name the activities in the data set
        #4.Appropriately labels the data set with descriptive variable names. 
        #5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The run_analysis.R script performs the assignment by creating two tidy data sets:

        "The first tidy data set" performs parts #1, #2, #3 & #4 of the assignment and results in "TidyDataset1" data frame.
        "The second tidy data set" performs part #5 of the assignment and results in "TidyDataset2" data frame.

The process to create the tidy data sets is described below, referencing the script line numbers. The R script contains comments that provide more detail.


The first tidy data set:
========================================================

Line 13: Set the working directory to the directory where the downloaded "UCI HAR Dataset" resides.

Lines 15-17: Reads in the Activity Labels and Features text files.
- "activityLabels" has 6 numeric activity codes and their descriptions, corresponding to rows in the test and train data sets
- "featureLabels"" has 561 variable descriptions, corresponding to each of the columns in the test and train data sets

Lines 19-21: Fixes the activity descriptions (makes lower case and removes underscores)

Lines 23-29: Creates a vector of just the mean() and std() features, to be used to specify correct columns to extract from Test and Train data sets:
- "featureLabelsMSD" is the subset of "featureLabels" that has only the 33 mean() observations and the 33 std() observations. After subsetting, "featureLabelsMSD" is put back in original numeric order.
- "featureMSDVector" is a numeric vecor containing featureLabelsMSD's column numbers. This vector will be used to subset the Train and Test data.

Lines 31-44: Reads in the Train data set. Adds the Subject Codes and Activity Descriptions. Replaces column names with the Feature Labels.
- trainSubjects. "trainSubjects" has the numeric subject codes for all the subjects in the train data set. trainSubjects first column is renamed "SubjectId".
- trainLabels. "trainLabels" has the numeric activity codes for all the rows of the train data set. trainLabels first column is renamed "ActivityCode". Added a new column in trainLabels and populated it with the activity descriptions (from the activityLabels data frame).
- trainData. "trainData" is the train data set consisting of 7352 obs. of 561 variables.
        All columns in "trainData" are renamed to be the featureLabels.
        The columns that have mean() and std() measurements are extracted (subsetting using the featureMSDVector).
        Added trainSubjects and trainLabels to the trainData dataframe.
        Removed the ActivityCode column from trainData.
- The resulting trainData data frame has 7352 observations of 68 variables.

Lines 46-59: Reads in the Test data set. Adds the Subject Codes and Activity Descriptions. Replaces column names with the Feature Labels.
- These lines perform the same process that was done on the Train data set (Lines 31-44), to the Test data set, 
- The resulting testData data frame has 2947 observations of 68 variables.

Lines 61-62: Combines the training and the test sets into one data set.
- The resulting "TidyDataSet1" data frame has 10,299 observations of 68 variables.

Lines 65-76: Fixes the feature variable labels. 
- made the TidyDataset1 column names into a vector, so that we can clean up the feature labels.
- used gsub() function to remove ()- characters and from the names so that they don't disrupt functions we use on the data set later. Reworded some of the descriptions. Corrected 6 variable names by removing the erroneous duplication of the word "Body". I did not change these variable labels to all lowercase because some upper case letters improved readability of the labels.
- replaced all the column names in TidyDataset1 with the new, cleaned-up column names.

Line 80: Cleans up the Global Environment by removing the objects no longer needed. Keeps TidyDataset1. 


The second tidy data set:
========================================================

Lines 84-88: From TidyDataset1, creates TidyDataset2, a new data frame which has the average of each variable for each activity and each subject.
- loads in reshape2 and plyr packages.
- melts TidyDataset1 to get a "tall and skinny" data set.
- uses ddply to get the means of each subject and activity.
- creates a second, independent tidy dataset with the average of each variable for each activity and each subject.

Line 92: Cleans up the Global Environment by removing the objects no longer needed. Keeps TidyDataset1 and TidyDataset2 data frames.

Line 95: Writes TidyDataset2 to a .txt file


Instructions to load "TidyDataset2.txt":
========================================================
The following script will read the TidyDataset2.txt file back into R:
        TidyDataset2 <- read.table("TidyDataset2.txt", as.is = TRUE, header=TRUE, sep = '\t')


