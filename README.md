<p>
  The run_analysis.R file contains a script that is used to tidy data from a research done by UCI on accelerometer and gyroscope readings embedded on a Samsung Galaxy S II. The experiment was conducted by using 30 volunteers aged between 19-48 years doing six different activities. The activities done were, WALKING, WALKING-UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING.
<p/>

<p>
  The code starts with reading the txt files which contain the data by using the ``` read.table ``` function. The script has to be run in the same directory as the UCI HAR Dataset directory which contains the data. The files which were read are: y_test.txt, X_test.txt, X_train.txt, y_train.txt, subtect_test.txt, subject_train.txt and the features.txt 
<p/>

<p>
- y_test.txt: Testing labels
- X_test.txt: Testing set
- y_train.txt: Training labels
- X_train.txt: Training set
- subject_test.txt: Subjects test set
- subject_train.txt: Subjects training set
- features.txt: a list of all the features recorded
<p/>

<p>
The test data was merged together by using the  ``` cbind ``` function and the same was done with the train data. After that the the two merged datasets were then merged together using the ``` rbind ``` function. This made a complete data with the subject and activity labels added as columns. The feature names in the features.txt file were then used to rename the columns in the merged data set, but the Subject and Activity column were named using using the ``` names ``` function to replace the existing column names there.
<p/>
 
<p>
Only the columns which had mean and standard deviation reading were needed in the tidy data set and so, the ``` grep ``` function was used to index column which had mean and std in them as well as the Subject and Activity column. These indexed columns were then selected by using the ```select``` argument of the ```subset``` function. Both the Subject and Activity column were converted to factors and the levels of the Activity column were renamed according to the activities which were done by the subjects. To rename these, the activities in the activity_labels.txt file were used. 
<p/>

<p>
The column names in the merged data set were renamed by using the ``` gsub ``` function which replaced certain words in column names. Finally, the ```reshape2``` package was used to melt the data by using the Subject and Activity column as the IDs and every other column as the variable. The ``` dcast ``` function of the ```reshape2``` package was used to produce a table of the mean of each feature for each activity for each subject. The tidy data set produced was then written to a txt file named tidy.txt
<p/>

<p>
A code book is also added which describes what each variable is. 
<p/>
