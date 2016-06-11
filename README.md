README
======

(1) Download Files and Make Tables

1.  Download the "UCI HAR Dataset" file  
2.  Set your working directory to where the file is  
3.  Unzip the file   
4.  Load required packages  

Files in folder ‘UCI HAR Dataset’ that will be used are:
    
    1) SUBJECT FILES
    test/subject_test.txt
    train/subject_train.txt
    
    2) ACTIVITY FILES
    test/X_test.txt
    train/X_train.txt
    
    3) DATA FILES
    test/y_test.txt
    train/y_train.txt
    
    4) features.txt - Names of column variables in the dataTable
    
    5) activity_labels.txt - Links the class labels with their activity name.

5.  Read the above files and create data tables.

(2) Tidy data set

1.  Merges the training and the test sets to create one data set.
2.  Extracts only the measurements on the mean and standard deviation for each measurement.
3.  Uses descriptive activity names to name the activities in the data set
4.  Appropriately labels the data set with descriptive variable names.

    leading t or f is based on time or frequency measurements.
    Body = related to body movement.
    Gravity = acceleration of gravity
    Acc = accelerometer measurement
    Gyro = gyroscopic measurements
    Jerk = sudden movement acceleration
    Mag = magnitude of movement

5. From the data set creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The tidy data set a set of variables for each activity and each subject. 10299 instances are split into 180 groups (30 subjects and 6 activities) and 66 mean and standard deviation features are averaged for each group. The resulting data table has 180 rows and 69 columns – 33 Mean variables + 33 Standard deviation variables + 1 Subject( 1 of of the 30 test subjects) + ActivityName + ActivityNum . The tidy data set’s first row is the header containing the names for each column.
