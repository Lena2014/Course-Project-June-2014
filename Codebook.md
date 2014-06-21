Code Book for TidyDataSet2.txt
========================================================
Date: June 19, 2014
========================================================

This code book is for "TidyDataset2.txt" which was created by running the "run_analysis.R" script on the "Human Activity Recognition Using Smartphones Dataset" (HARUS).

This code book describes the variables, summaries, and other information specifically relevant to TidyDataset2.txt. 


Dataset Sources and Information:
========================================================

For more information about the "Human Activity Recognition Using Smartphones Dataset" (HARUS), refer to these files:

- Description of the complete HARUS Dataset at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

- The HARUS Dataset located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

- TidyDataSet2.txt and run_analysis.R located in the "Course-Project-June-2014" repo at https://github.com/Lena2014.


Description of records (rows):
========================================================

Each record in the dataset has the results for one subject performing one activity.
There are 30 subjects, each performing 6 activities, for a total of 180 records in this dataset.


Description of variables (columns):
========================================================

SubjectId:

        Numeric identifer of the subject who carried out the experiment. (Range: 1 to 30)
        
Activity:

        Activity performed by the subject. Six activities are performed:
        walking; walkingupstairs; walkingdownstairs; sitting; standing; laying
        
The remaining 66 columns contain the variables measured for each subject and activity:
        
- Each variable name begins with either 't' or 'f':

        't' denotes the variable was calculated from the time domain
        'f' denotes the variable was calculated from the frequency domain

- The middle portion of the variable name indicates the specific signal measured. These are the unique signal names and descriptions:

        BodyAccX, BodyAccY, BodyAccZ:  Body acceleration signal. 'X', 'Y', or 'Z' suffix indicates the axial signal direction. 
        
        GravityAccX, GravityAccY, GravityAccYZ:  Gravity acceleration signal. 'X', 'Y', or 'Z' suffix indicates the axial signal direction.
        
        BodyAccJerkX, BodyAccJerkY, BodyAccJerkZ:  Body acceleration with jerk signal. 'X', 'Y', or 'Z' suffix indicates the axial signal direction.

        BodyGyroX, BodyGyroY, BodyGyroZ: Body gyroscope signal. The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.
        
        BodyGyroJerkX, BodyGyroJerkY, BodyGyroJerkZ: Body gyroscope with jerk signal.
        
        BodyAccMag:  Magnitude of the three dimensional body acceleration signals.
        
        GravityAccMag:  Magnitude of the three dimensional gravity acceleration signals.
        
        BodyAccJerkMag:  Magnitude of the three dimensional body acceleration jerk signals.
        
        BodyGyroMag:  Magnitude of the three dimensional body gyroscope signals.
        
        BodyGyroJerkMag:  Magnitude of the three dimensional body gyroscope jerk signals.

- Each variable name ends with either 'mean' or 'std':

        'mean' denotes the estimated mean value of the variable is given
        'std' denotes the variable is the estimated standard deviation of the variable is given

