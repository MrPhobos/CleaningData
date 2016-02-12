The file run_analysis.R performs several steps for tidying up the data set. These are:

1. It loads dplyr which is used later on through the script.

2. If the variables are not loaded into the environment yet, they will be loaded first. The files are .txt files so read.table is used for this. 

3. The test and training data is then converted to tbl class using the tbl_df function from dplyr. This is done with the subject, y and x data binded together.

4. The feature names from the feature set are put in a vector, and are used as the variable names for the test and training datasets, which are more descriptive than V1 ... V500 etc.
The funciton 'make.names' is used in order to make the features into valid names (dropping brackets etc).

5. After this prework, the actual excercise starts at #1. Here, the merge is easily performed by the union function of dplyr with the previously created test_df and train_df, already in the right format and with the right names attached to it.

6. At #2 the variables containing std and mean are selected from the variables. Note that due to make.names, std() and mean() became std and mean already, so no further selection is needed.

7. At #3, the names of the activities are made descriptive instead of using the number, by using the activity table as a look-up table. 

8. At #4, I choose not to expand things like 't' to time, 'f' to frequency, etc etc. This would make impossible to read names due to the enourmous length. The dots introduced by make.name are removed to follow the good name conventions as closely as relevant though.

9. At #5, the data is grouped by subject and activity, and summarized. In this way, the data has finaly become tidy data with no variables having multiple observations per subject and activity. 

10. This data is stored in a txt file called 'tidy_data.txt'.