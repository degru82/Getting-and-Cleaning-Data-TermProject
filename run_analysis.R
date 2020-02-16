# run_analysis.R

# 1. "Merges the training and the test sets to create one data set."
#   1. a. Load training and test dataset from original dataset
path_trainx = "./data/UCI HAR Dataset/train/X_train.txt"
path_trainy = "./data/UCI HAR Dataset/train/y_train.txt"
path_trainsub = "./data/UCI HAR Dataset/train/subject_train.txt"

train_x = read.table(path_trainx, header = F)
train_y = read.table(path_trainy, header = F)
train_sub = read.table(path_trainsub, header = F)

path_testx = "./data/UCI HAR Dataset/test/X_test.txt"
path_testy = "./data/UCI HAR Dataset/test/y_test.txt"
path_testsub = "./data/UCI HAR Dataset/test/subject_test.txt"

test_x = read.table(path_testx, header = F)
test_y = read.table(path_testy, header = F)
test_sub = read.table(path_testsub, header = F)

#   1. b. Merge datasets to create total one
dataset_train = cbind(train_sub, train_x, train_y)
dataset_test = cbind(test_sub, test_x, test_y)
dataset = rbind(dataset_train, dataset_test)




# 2. "Extracts only the measurements on 
#       the mean and standard deviation for each measurement."

#   2. a. Load feature names
path_featnames = "./data/UCI HAR Dataset/features.txt"
feature_table = read.table(path_featnames, header = F, stringsAsFactors = F)
feature_names = feature_table[[2]]

#   2. b. Becuase we added subject and 'y' field to the original value
#           feature_names should be updated with those columns
feature_names = c("subject", feature_names, "activityName")

#   2. c. Extract column indices only for mean and standard variation
#           Interestingly, mean variables end with "mean()" 
#           and standard variation variables end with "std()"
idx_meanstd = grep("(mean|std)\\(", feature_names)
idx_extracted = c(1, idx_meanstd, length(feature_names))
featname_extracted = feature_names[idx_extracted]

#   2. d. Extract selected fields only 
dataset_extracted = dataset[, idx_extracted]




# 3. "Uses descriptive activity names to name the activities in the data set"

#   3. a. Load the activity label info
path_actlabel = "./data/UCI HAR Dataset/activity_labels.txt"
act_label = read.table(path_actlabel, header = F)

#   3. b. Merge the activity label to extracted dataset by column activityCode
colnames(act_label) = c("activityCode", "activityName")
colnames(dataset_extracted)[length(dataset_extracted)] = "activityCode"
dataset_extracted = merge(dataset_extracted, act_label, by="activityCode")

#   3. c. We don't want to retain 2 fields for activity, 
#           cut out the column called 'activityCode'
dataset_extracted = dataset_extracted[, 2:length(dataset_extracted)]





# 4. "Uses descriptive activity names to name the activities in the data set"
colnames(dataset_extracted) = featname_extracted





# 5. "From the data set in step 4, 
#       creates a second, independent tidy data set 
#       with the average of each variable for each activity and each subject."
path_tidydataset = "./data/tidy_datset.txt"
write.table(dataset_extracted, file=path_tidydataset)

