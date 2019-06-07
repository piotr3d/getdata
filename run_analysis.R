# configuration
uci_har_dataset_location = 'UCI_HAR_Dataset\\'
train_data_location = paste0(uci_har_dataset_location,'train\\')
test_data_location = paste0(uci_har_dataset_location,'test\\')

# include additional libraries (install if needed)
if(!require('dplyr')) install.packages('dplyr')
library(dplyr)

## Step 0 - read source data
# read activity labels dictionary
activity_labels <- read.table(paste0(uci_har_dataset_location,'activity_labels.txt'))
  
# read training data
subject_train <- read.table(paste0(train_data_location,'subject_train.txt'))
x_train <- read.table(paste0(train_data_location,'X_train.txt'))
y_train <- read.table(paste0(train_data_location,'y_train.txt'))

# read test data
subject_test <- read.table(paste0(test_data_location,'subject_test.txt'))
x_test <- read.table(paste0(test_data_location,'X_test.txt'))
y_test <- read.table(paste0(test_data_location,'y_test.txt'))


## Step 1 - merge training an test data
# change variable names
names(subject_train) <- c('subject')
names(subject_test) <- c('subject')
names(y_train) <- c('activity_id')
names(y_test) <- c('activity_id')

# merge data
training_data <- cbind(subject_train, y_train, x_train)
test_data <- cbind(subject_test, y_test, x_test)
step1_data <- rbind(training_data, test_data)

## Step 2 
# calculate mean and standard deviation for each measurement
step1_data$mean <- rowMeans(step1_data[,3:563])
step1_data$sd <- apply(step1_data[,3:563],1,sd)

# add a new variable for identifing each measurement
step1_data$measurement_id <- seq(along = step1_data[,1])

# create new data set with only subject, activity_id, mean and standard deviation for each measurement
step2_data <- step1_data[,c('measurement_id','subject','activity_id','mean','sd')]

## Step 3
# change variable names for activity labels for merge purposes
names(activity_labels) <- c('activity_id','activity_name')

# merge data set from step 2 with activity labels (dropping activity_id after merge)
step3_data <- merge(step2_data,activity_labels)[,c('subject','activity_name','mean','sd','measurement_id')]
clean_data <- arrange(step3_data, subject, activity_name)

## Step 4 - summarize the data creating new data set
summary_data <- summarize(group_by(clean_data,subject,activity_name), avg_mean = mean(mean), avg_sd = mean(sd))

## Step 5 - save output data sets
write.table(clean_data,'clean_data.txt', row.names = F)
write.table(summary_data,'summary_data.txt', row.names = F)

