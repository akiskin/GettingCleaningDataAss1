# Getting and Cleaning Data Project

## run_analysis.R

The 'run_analysis.R' does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Running the script
Source the file, set directory with data files (where `features.txt`, etc is located) as your working directory, then run `main()`.
As a result file `result.txt` will appear there.


## Process
Firstly script read activity and feature labels.
For feature labels it selects features which names have "mean()" or "std()" in them (see `prepare_featurelabels()`).

Then reads TEST data, adding to resulting data frame column of subjects and column with factorized activities.
After that doing all the same for TRAIN data.

Next step - rbinding two data frames, then melting&casting with mean calculation on every variable for subjects and activities.
