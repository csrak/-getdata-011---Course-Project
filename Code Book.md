# Code Book

Code book describes the variables of "run_analysis.R" and details the program does (also explained in the comments of the code).

## Other variables

### dir

It's the path of the working directory, used to get the data. 


## Raw data variables

###xtest:

Data form the file /UCI HAR Dataset/test/xtest.txt

###xtrain:

Data form the file /UCI HAR Dataset/train/xtrain.txt

###ytest:

Data form the file /UCI HAR Dataset/test/ytest.txt

###ytrain:

Data form the file /UCI HAR Dataset/train/ytrain.txt

###stest: 

Data form the file /UCI HAR Dataset/test/subject_test.txt

###strain: 

Data form the file /UCI HAR Dataset/train/subject_train.txt

##Merged and manipulated data variables

###x:

Data from xtest and xtrain binded together, later the columns "activity" and "subjects" are added.

###activities:

Data from ytest and ytrain binded together, later the numbers from de data are turned into the activities descriptions.

###l: 
Contains the name of the labels from features.txt, later those names are fixed to work correctly on r.

###validx:

Contains the columns "activity", "subjects" and the ones that contain "mean" and "std" on their names that,  we suppose, means they have mean and standart deviation values.

###xagrupado:

It's the same as validx but there are two groups defined by group_by function, the "subject" group and the "activity" group.

###xfinal:

It's the final tidy data, it contains the mean for each variable and each group, also grouped by subject and activity

##Internal Functions:

###numbertoactivity:

Turns the activities numbers into their description as described in "activity_labels.txt"

## Steps followed to load data
1. The data container was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. The downloaded file was extracted into the working directory using WinRar(R)
3. run_analysis reads each file using "read.table()", with the exception of "features.txt", that was read with "readlines()"

## Steps of data manipulation

1. run_analysis binds test data and trainning data together.
2. It gets labels from "features" file and transforms each one into a valid name
3. It turns the activities from a number to a understandable description by defining and using the "numbertoactivity()" function.
4. Selects the columns that contain "mean" and "std" and groups the table by activity and subject.
5. It labels the activity names and the variable names.
6. Summarises the data to get the mean for each variable and for the groups made.
7. Returns the table with the tidy data and writes the file "Tidy_data.txt" containing said table in the working directory.

