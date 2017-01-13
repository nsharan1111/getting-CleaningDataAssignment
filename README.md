# getting-CleaningDataAssignment
Programming Assignment for Getting and Cleaning Data Module

This file explains how run_analysis.R works to achieve the goal of the assignment

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The first section of the code helps in combining train and test datasets

1. The zipped file is downloaded using the url and unzipped
2. subject, Y and X datasets for both train and test data are read
3. test and train data columns are each column binded separately to create two datasets
4. In the next step, the two datasets are combined to create one data set by binding them row wise

The second section of the code helps in extracting the mean and standard deviation measurements of the combined dataset

1. In order to figure out which columns correpsond to mean and standard deviation measurements, the features.txt file is read
2. This file has two columns, first is the numeric column and the second one stores the column names
3. The second column of this dataset is stored in a variable 'ftrnames'
4. The indices of the columns which correspond to mean or std measurements are stored in featuresrownum
5. Using featuresrownum, the column values for corresponding columns are extracted from the earlier combined dataset. The first and second columns are subject number and activity performed. hence the column index is moved ahead by 2 to point to the correct column value 
6. The column names are set using set names and the final dataset 'meanstdfinal' is obtained

The third section of the code helps in assigning descriptive activity names to name the activities in the dataset

1. the activity_labels dataset is read. It has two columns:
    v1 - activity number
    v2 - activity label
    
2. The activity column in the 'meanstdfinal' dataset is converted into a factor column so each numeric value corresponds to the activity label

The fourth section of the code helps in appropriately labeling the dataset with descriptive variable names:

1. removed all '()' and '-' for better readability of column names
2. replaced 'mean', 'std', 'BodyBody', 'Acc', 'Mag' with 'Mean', 'Std', 'Body', 'Accelerometer' and 'Magnitude' respectively to set column names that are easy to read and understand 
3. Replaced 't' and 'f' at the start of the column names with 'time' and 'frequency' again for legibility and better description

The fifth section of the code helps in creating a second, independent tidy data set with the average of each variable for each activity and each subject.

1. load the dplyr package
2. group the 'meanstdfinal' dataset by subject and activity
3. summarize each of the columns in terms of their mean value as per the grouping and store in a new dataset 'meanstdfinalgroup'
4. write this to a text file and save it in your local using write.table



