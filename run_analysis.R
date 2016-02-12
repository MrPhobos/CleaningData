# load data if it doesn't exist (takes a long time)
library(dplyr)
if (!exists('train_x')){
  train_x <- read.table('UCI HAR Dataset/train/X_train.txt')
}
if (!exists('subject_train')){
  subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt')
}
if (!exists('train_y')){
  train_y <- read.table('UCI HAR Dataset/train/y_train.txt')
}
if (!exists('test_x')){
  test_x <- read.table('UCI HAR Dataset/test/X_test.txt')
}
if (!exists('subject_test')){
  subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt')
}
if (!exists('test_y')){
  test_y <- read.table('UCI HAR Dataset/test/y_test.txt')
}
if (!exists('features')){
  features <- read.table('UCI HAR Dataset/features.txt')
}
if (!exists('activities')){
  activities <- read.table('UCI HAR Dataset/activity_labels.txt')
}
# Organize the data
test_df <- tbl_df(cbind(subject_test, test_y, test_x))
train_df <- tbl_df(cbind(subject_train, train_y, train_x))
feature_names <- as.character(features[,2])
variable_names <- c('subject', 'activity', feature_names)
valid_column_names <- make.names(names=variable_names, unique=TRUE, allow_ = TRUE)
names(test_df) <- valid_column_names
names(train_df) <- valid_column_names

# 1. Merge the training and test data
full_df <- union(test_df, train_df, by = 'subject')

# 2. Extract the measurements on the mean and std
sel_df <- select(full_df, subject, activity, contains('mean'), contains('std'))

# 3. Name the activities with a descriptive name
names(activities) <- c('ID', 'Name')
sel_df <- mutate(sel_df, activity = activities[sel_df$activity,2] )

# 4. Appropriately label the data with descpriptive variable names
## Already done during organizing the data. No further changing of the variables is done
## since I decided the names do not become more clear by expanding 't' to 'time' and 'f' to 'freqency'
## etc.. I only remove the dots to according to the 'good variable names' convention talked about
## in the lecture.
names(sel_df) <- gsub("\\.","",names(sel_df))

# 5. Create a second, independent dataset with the average for each variable for each activity and subject
by_subj_act <- sel_df %>%
  group_by(subject, activity) %>%
  summarize_each(funs(mean))

# Write it to a txt file.
write.table(by_subj_act, 'tidy_data.txt', row.names = FALSE)