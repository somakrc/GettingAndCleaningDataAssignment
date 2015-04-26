## The function "CreateDataSet" that creates the independent, cleaned and 
## merged dataset meeting the specifications given in the assignment.

## arguments of CreateDataSet
## UnzipPath: required argument, which is essentially the absolute / full path
## OutputFileLocation : optional, user may specify where the output file 
## containing the independent dataset is created. 
## If not specified, it is created within "UCI HAR Dataset".

CreateDataSet <- function(UnzipPath=character(),OutputFileLocation = UnzipPath) {
  
  
  ## Read the activity types and measurement labels
  ActivityLabel<-read.table(paste(UnzipPath,"/activity_labels.txt",sep=""),header=FALSE)
  Features<-read.table(paste(UnzipPath,"/features.txt",sep=""),header=FALSE)
  
  ## Features file has all the computed metrics from the accelerometer and gyro ...
  ## ... such as mean, standard dev and others as specified in features_info.txt
  names(Features)<-c("Position","Metric")
  
  ## grep seeks for a pattern (here mean() and std()) to pull only the metrics ...
  ## ... and their positions (column number)
  ## All such metric names and their positions are stored in RequiredFeatures
  MeanMeasures<-Features[grep("mean()",Features$Metric,fixed=TRUE),]
  StDevMeasures<-Features[grep("std()",Features$Metric,fixed=TRUE),]
  RequiredFeatures<-rbind(MeanMeasures,StDevMeasures)
  
  ## Read Training DataSet
  TrainingSubject<-read.table(paste(UnzipPath,"/train/subject_train.txt",sep=""),header=FALSE)
  TrainingMetrics<-read.table(paste(UnzipPath,"/train/X_train.txt",sep=""),header=FALSE)  
  TrainingActivity<-read.table(paste(UnzipPath,"/train/y_train.txt",sep=""),header=FALSE)
  
  ## TrainingFeatures considers only the required features (as per RequiredFeatures)
  TrainingFeatures<-TrainingMetrics[,RequiredFeatures$Position]
  names(TrainingFeatures)<-RequiredFeatures$Metric
  
  ## The ActivityLabels are mapped to numbers in y_train ...
  ## ... considering the data have a 2 way classification...
  ## ... X being the metrics and y being the activities
  TrainingActivityLabel<- ActivityLabel[TrainingActivity[,1],2]
  
  ## In order to understand where the subject has come from (test or train?)
  ## a separate column is added, so that after merging it remains recognizable
  DataSetType<-rep("Train",length(TrainingSubject[,1]))
  
  ## All required feature columns, subject number, activity label and ...
  ## ... datasettype columns are bind together to create the composite ...
  ## ... training dataset
  TrainingDataSet<- cbind(DataSetType,TrainingSubject,TrainingActivityLabel)
  names(TrainingDataSet)<-c("DataSetType","Subject","ActivityLabel")
  TrainingDataSet<-cbind(TrainingDataSet,TrainingFeatures)
  
  
  ## Read Test DataSet and follow exact same steps as above
  
  TestSubject<-read.table(paste(UnzipPath,"/test/subject_test.txt",sep=""),header=FALSE)
  TestMetrics<-read.table(paste(UnzipPath,"/test/X_test.txt",sep=""),header=FALSE)  
  TestActivity<-read.table(paste(UnzipPath,"/test/y_test.txt",sep=""),header=FALSE)
  
  TestFeatures<-TestMetrics[,RequiredFeatures$Position]
  names(TestFeatures)<-RequiredFeatures$Metric
  
  TestActivityLabel<- ActivityLabel[TestActivity[,1],2]
  
  DataSetType<-rep("Test",length(TestSubject[,1]))
  
  TestDataSet<- cbind(DataSetType,TestSubject,TestActivityLabel)
  names(TestDataSet)<-c("DataSetType","Subject","ActivityLabel")
  TestDataSet<-cbind(TestDataSet,TestFeatures)
  
  ## Merge the Train and Test Dataset
  IndependentDataSet <- rbind(TrainingDataSet,TestDataSet)
  
  ## Store the current working directory, flip it to outputfile location for a while...
  CurrentWD <-getwd()
  setwd(OutputFileLocation)
  
  write.csv(IndependentDataSet,file = "NewDataSet.csv")
  
  ## Return to users Working Directory
  setwd(CurrentWD)
  
  ##Print message after successful creation of the output file
  print(paste("Output file created: ",OutputFileLocation,"/NewDataSet.csv",sep=""))
}
