##For information about this R script, see the README.md in the "Course-Project-June-2014" repository at https://github.com/Lena2014.

##############   DOWNLOAD AND UNZIP THE DATA FILES   ##############

setwd("C:/Users/Lena/Documents/Coursera/Course3/Course Project")                                ##set your working directory
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"   ##url where the data is in a .zip file
download.file(url, destfile = "HARdata.zip")                                                    ##download .zip file
dateDownloaded <- date()                                                                        ##record data of download
unzip("HARdata.zip", files = NULL, list = FALSE, overwrite = TRUE, junkpaths = FALSE, exdir = ".", unzip = "internal", setTimes = FALSE)  ##unzip the files

###################   THE FIRST TIDY DATA SET   ###################

setwd("C:/Users/Lena/Documents/Coursera/Course3/Course Project/UCI HAR Dataset")  ##set your working directory

##Read in the Activity Labels and Features text files:
        activityLabels <- read.table("activity_labels.txt")                     ##6 numeric activity codes and their descriptions, corresponding to rows in the test and train data sets
        featureLabels <- read.table("features.txt")                             ##561 variable descriptions, corresponding to each of the columns in the test and train data sets

##Fix the activity descriptions:
        activityLabels$V2 <-gsub("[_]","", activityLabels$V2)                   ##remove undescores
        activityLabels$V2 <- tolower(activityLabels$V2)                         ##make all lowercase 

##Create a vector of just the mean() and std() features, to be used to specify correct columns to extract from Test and Train data sets:
        featureLabelsM <- featureLabels[grep("mean", featureLabels$V2), ]       ##subset of feature labels containing "mean"
        featureLabelsM <- featureLabelsM[!grepl("meanFreq", featureLabelsM$V2), ]  ##removes feature labels with "meanFreq" so all that's left are the 33 mean() obs
        featureLabelsSD <- featureLabels[grep("std", featureLabels$V2), ]       ##subset of feature labels containing "std" so we have only the 33 std() obs
        featureLabelsMSD <- rbind(featureLabelsM, featureLabelsSD)              ##combined mean() and std() subsets = total of 66 obs.
        featureLabelsMSD<-featureLabelsMSD[order(featureLabelsMSD$V1),]         ##puts data frame back in original numeric order
        featureMSDVector<-as.vector(featureLabelsMSD$V1)                        ##makes the MSD's column numbers into a vector. This vector will be used to subset the Train and Test data

##Train data set: Add in the Subject Codes, Activity Descriptions, and replaced column names with the Feature Labels:
        trainSubjects <- read.table("train/subject_train.txt")                  ##the numeric subject codes for all the subjects in the train data set 
        colnames(trainSubjects)[1] <- "SubjectId"                               ##rename 1st column of trainSubjects

        trainData <- read.table("train/X_train.txt")                            ##the train data set consisting of 7352 obs. of 561 variables
        names(trainData) <- featureLabels$V2                                    ##renames all the columns in trainData to be the featureLabels
        trainData <- trainData[,(featureMSDVector)]                             ##extracts only the columns that have mean() and std() measurements

        trainLabels <- read.table("train/Y_train.txt")                          ##the numeric activity codes for all the rows of the train data set
        colnames(trainLabels)[1] <- "ActivityCode"                              ##rename 1st column of trainLabels
        trainLabels$Activity <- activityLabels[trainLabels$ActivityCode, 2]     ##added a new column and populated it with the activity descriptions (from the activityLabels data frame)

        trainData <- cbind(trainSubjects, trainLabels, trainData)               ##adds trainSubjects and trainLabels to the trainData dataframe = 7352 obs. of 68 variables
        trainData$ActivityCode<-NULL                                            ##remove the ActivityCode column  

##Test data set: Add in the Subject Codes, Activity Descriptions, and replaced column names with the Feature Labels:
        testSubjects <- read.table("test/subject_test.txt")                     ##the numeric subject codes for all the subjects in the test data set
        colnames(testSubjects)[1] <- "SubjectId"                                ##rename 1st column of testSubjects

        testData <- read.table("test/X_test.txt")                               ##the test data set consisting of 2947 obs. of 561 variables
        names(testData) <- featureLabels$V2                                     ##renames all the columns in testData to be the featureLabels
        testData <- testData[,(featureMSDVector)]                               ##extracts only the columns that have mean() and std() measurements

        testLabels <- read.table("test/Y_test.txt")                             ##the numeric activity codes for all the rows of the test data set
        colnames(testLabels)[1] <- "ActivityCode"                               ##rename 1st column of testLabels
        testLabels$Activity <- activityLabels[testLabels$ActivityCode, 2]       ##added a new column and populated it with the activity descriptions (from the activityLabels data frame)

        testData <- cbind(testSubjects,testLabels, testData)                    ##adds testSubjects and testLabels to the testData dataframe = 2947 obs. of 68 variables
        testData$ActivityCode<-NULL                                             ##remove the ActivityCode column

##Combined data set: Used rbind to merge the Train and Test data sets into one data set
        TidyDataset1 <- rbind(trainData, testData)                              ##Now we have a data frame with are 10,299 obs. of 68 variables
        ## TidyDataset1 <- merge(trainData, testData, all=TRUE)                 ##I could have used this merge() function instead, since both data frame have exactly the same columns

##Fix the feature variable labels:
        columnnames<-as.vector(colnames(TidyDataset1))                          ##makes the TidyDataset1 column names into a vector, so that we can clean up the feature labels
        columnnames<-gsub("[()-]","", columnnames)                              ##remove ()- characters from the names so that they don't disrupt functions we use on the data set later.
        columnnames<-gsub("meanX","Xmean", columnnames)                         ##these next 6 lines are meant to clean up wording of the descriptions 
        columnnames<-gsub("meanY","Ymean", columnnames)
        columnnames<-gsub("meanZ","Zmean", columnnames)
        columnnames<-gsub("stdX","Xstd", columnnames)
        columnnames<-gsub("stdY","Ystd", columnnames)
        columnnames<-gsub("stdZ","Zstd", columnnames)
        columnnames<-gsub("BodyBody","Body", columnnames)                       ##corrects 6 variable names by removing erroneous duplication of the word "Body".
        columnnames<-as.data.frame(columnnames)                                 ##make vector back into a data frame.
        colnames(TidyDataset1) <- columnnames$columnnames                       ##renames all the columns in TidayDataset1 to be the cleaned up columnnames.

##We now have completed our first tidy data set, the data frame "TidyDataset1".
##Clean up the Global Environment by removing the objects no longer needed:
        rm("activityLabels","featureLabels","featureLabelsM","featureLabelsMSD","featureLabelsSD","featureMSDVector","testData","testLabels","testSubjects","trainData","trainLabels","trainSubjects", "columnnames")

###################   THE SECOND TIDY DATA SET   ###################

library(reshape2)                                                               ##Load in the reshape2 and plyr packages
library(plyr)
TD1melt <- melt(TidyDataset1,id=c("SubjectId", "Activity"),measure.vars=c(3:68),)   ##melt TidyDataset1 into a "tall and skinny" data set.
x <- ddply(TD1melt, .(SubjectId, Activity, variable), summarize, mean=mean(value))  ##use ddply to add a column that has each variable's mean.
TidyDataset2<- dcast(x, SubjectId+Activity~variable, value.var="mean")              ##use dcast to summarize the variable means by SubjectId and Activity.

##We now have completed our second tidy data set, the data frame "TidyDataset2".
##Clean up the Global Environment by removing the objects no longer needed:
        rm("TD1melt", "x")

##Write TidyDataset2 to a .txt file for Coursera:
        write.table(TidyDataset2, "TidyDataset2.txt", sep='\t', quote=FALSE)    ##Write to a .txt file

