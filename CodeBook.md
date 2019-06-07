# Description of the analysis and generated output 

This document provides information on the data collecation, transformation and explains the generated output. It is assumed that user have already access to Samsung data (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) in their working directory. 

To use provided script *run_analysis.R* first you should verify if the path to data in you working is correct. This can be modified in the configuration section of the script:

>uci_har_dataset_location = 'UCI_HAR_Dataset\\' <br/>
>train_data_location = paste0(uci_har_dataset_location,'train\\') <br/>
>test_data_location = paste0(uci_har_dataset_location,'test\\') 

where *uci_har_dataset_location* is the location of the main directory od the data set that contains *test* and *train* subdirectories.

### description of newly created variables:
For the clean data set (*clean_data.txt*):
<li>**subject** - is the idenfier of the subject - one of the 30 participants of the experiment</li>
<li>**activity_name** - is the name of the activity that the subject was doing during measurement</li>
<li>**mean** - is the mean value of the measurement points captured during experiment</li>
<li>**sd** - is the standard deviation value of the measurement points captured during experiment</li>
<li>**measurement_id** - is the unique measurement identifier created to make further analysis easier</li>
<br/>
For the summarized data set (*summary_data.txt*):
<li>**subject** - is the idenfier of the subject - one of the 30 participants of the experiment</li>
<li>**activity_name** - is the name of the activity that the subject was doing during measurement</li>
<li>**avg_mean** - is the average value of the mean value of the measurement points captured during experiment</li>
<li>**avg_sd** - is the average value of the standard deviation value of the measurement points captured during experiment</li>
<br/>

### Analysis steps:
<li>When the configuration is correct script verifies (and install if necessary) the required library *dplyr*. </li>
<li>Scripts read the source data for both training and test sets as well as it read activity labels into data frames in R</li>
<li>Next thing to do is to prepare data for merging by changing variable names and to merge train and data sets</li>
<li>After the train and test data is merged the script calculates mean and standard deviation for each measurement and adds additional variable for identifing each measurement </li>
<li>Next the script removes the measurement points for each measurement leaving only mean and standard deviation and adds activity names to the set, and sorts the data by subject and activity name</li>
<li>As a result a clean_data data frame is created</li>
<li>The the script creates a new data set that contains only average of mean and standard deviation for each activity and each subject base on the clean_data set</li>
<li>Finally the script saves the resulting data sets as *clean_data.txt* and *summary_data.txt* files in user's working directory</li>
