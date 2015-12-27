The script "run_analysis.R" creates a tidydata.txt file that contains the average values of 66 selected features (out of 561 features listed in features.txt) for each subject and each activity.
There are 30 subjects and each performs 6 different activities. The selected features are those that represent the mean (mean()) and standard deviation (std()).
The steps taken:
1)Information about the subject, activity and the values of the 561 features are combined into a data frame. This is done separately for the test and the train datasets. Each resulting data frame contains 563 columns.
2)The two data frames from step 1 are combined into one data frame containing both the test and train data.
3)The selected features are extracted from the combined data frame in step 2 and rename the selected columns
4)The activity labels are replaced with more descriptive names
5)For each subject and activity, the average of each feature is computed and is stored in a new data frame
6)The new data frame is written out to "tidydata.txt" file

