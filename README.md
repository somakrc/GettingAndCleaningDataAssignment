# Getting and Cleaning Data: Programming Assignment

The following R Code "run_analysis.R" contains a function 
"CreateDataSet" that creates the independent, cleaned and 
merged dataset meeting the specifications given in the assignment.

### arguments of CreateDataSet
CreateDataSet has a required argument of type Character (String)
called the UnzipPath, which is essentially the absolute / full path 
for the folder "UCI HAR Dataset".

The second argument "OutputFileLocation" is optional. If not specified,
the output file containing the independent dataset is created in the
same folder.

###Note for Windows users: Please change the "\" character to "/"
while providing the input path. For example:

C:\Data Science\getdata_projectfiles_UCI HAR Dataset\UCI HAR Dataset

should be provided as 
"C:/Data Science/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset"

### Assumptions and Considerations: 
1. Only the _mean() and _std() features are extracted, meanFreq()
measures are not considered

2. In order to segregate the subjects considered in training
and in test, an additional column called "DataSetType" is added

3. Outputfile is hardcoded as "NewDataSet.csv" and of filetype .csv
The output will be overwritten if the script runs more than once
pointing to same output file location


### Call function CreateDataSet(<UnzipPath>,[<OutputFileLocation>])
after sourcing the script "run_analysis.R"