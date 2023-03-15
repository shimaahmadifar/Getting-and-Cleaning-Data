##  This script extracts mean and standard deviation observations from the 
##  'Human Activity Recognition Using Smartphones Dataset Version 1.0'
##  prepared by the Smartlab - Non Linear Complex Systems Laboratory in Genoa, Italy (www.smartlab.ws)
##  The dataset contains accelerometer measurements from the Samsung Galaxy S smartphone while the wearer 
##  undertakes various activities.
##  Please see the accompanying README.md  and codebook.txt files for detailed descriptions of source files and data.

##  This script is an assignment for the 'Getting & Cleaning Data' Coursera module offered by John Hopkins University
##  and the numbered steps below relate to the assignment. 

##  It requires the dplyr package.

##  It outputs two data frame variables:
##  meansandstdevs -- a tidied extract of mean and standard deviation observations
##  groupedmeansandstdevs --the mean values of these observations for each subject and activity.

## csv files containing these outputs are available at [github repo].

## Prepared 31 Jan 2016 by J Cunningham

##--------------------------------------------------------------------------------------------------------------------



##1. Merge the training and the test sets to create one data set.
 
 ##load measurements
 trainset<-read.table("UCI HAR Dataset/train/X_train.txt")
    ##7352 obs of 561 variables
 
 testset<-read.table("UCI HAR Dataset/test/X_test.txt")    
    ##2947 obs of 561 variables

 ##load labels
 trainlabels<-read.table("UCI HAR Dataset/train/y_train.txt")  
    ##7352 obs of 1 variables
 
 testlabels<-read.table("UCI HAR Dataset/test/y_test.txt")     
    ##2947 obs of 1 variables
 
 ##load subjects
 trainsubjects<-read.table("UCI HAR Dataset/train/subject_train.txt")  
    ##7352 obs of 1 variables
 testsubjects<-read.table("UCI HAR Dataset/test/subject_test.txt")  
    ##2947 obs of 1 variables
 
 ##create dataframe to hold merged data
 df <- data.frame(matrix(ncol = 564, nrow = 10299))
 colnames(df)[1:3]<-c("set","subject", "activity")
 
 #add train/test flag to "set" column to record the row source
 df[1:7352,1]<-"train"
 df[7353:10299,1]<-"test"

 
 #add subject values to "subject" column
 df[1:7352,2]<-trainsubjects
 df[7353:10299,2]<-testsubjects

 
 #add activity labels to "activity" column
 df[1:7352,3]<-trainlabels
 df[7353:10299,3]<-testlabels

 
 #add measurement data to remaining 562 columns
 df[1:7352,4:564]<-trainset
 df[7353:10299,4:564]<-testset
 #check changeover rows for any problems (looking at sample measurement columns on the left and right)
 #df[7351:7355,1:25]
 #df[7351:7355,544:564]
 
 
##2. Extract only the measurements on the mean and standard deviation for each measurement.
 
 ##load the measurement names from the feature.txt file
 features<-read.table("UCI HAR Dataset/features.txt")
 ##identify features that calculate mean() or std(), the features or interest (foi)
 foi<-grep("-mean\\(|-std",features[,2], value=FALSE)
 ##add 3 to the foi index numbers to indentify the corresponding columns numbers of df 
 foicols<-foi+3
 
 ##restrict the dataframe to these columns
 df<-df[,c(1,2,3,foicols)]

 ##label the measurement columns with the names given in features.txt
 foinames<-grep("-mean\\(|-std",features[,2], value=TRUE)
 colnames(df)<-c("set","subject", "activity", foinames)

 
##3. Rename activities so that labels are descriptive
 ##load the activity names from the activity_labels.txt file, match them to column 3 of df 
 ##and overwrite numeric values withdescriptive text
 activities<-read.table("UCI HAR Dataset/activity_labels.txt")
 df[,3]<-sapply(df[,3],  FUN=function(x) activities[x,2])
 
 
##4. Label the data set with descriptive variable names. 
  ##tidy measurement names from features.txt which are stored in the foinames variable
 #remove brackets
 foinames<-sub("()","",foinames, fixed=TRUE)
 #remove hypens
 foinames<-sub("-","",foinames, fixed=TRUE)
 #change to lower case
 foinames<-tolower(foinames)
 #change intital 't' and 'f' to 'time' and 'freq'
 foinames<-sub("t","time",foinames)
 foinames<-sub("f","freq",foinames)
 #update the column names in the dataset
 colnames(df)<-c("set","subject", "activity", foinames)
 

##5. From the data set in step 4, creates a second, independent tidy data set with the average
 ## of each variable for each activity and each subject.
 
 library(dplyr)
 
 sa <- df[,-1] %>%  group_by(subject, activity) %>% 
 summarise_each(funs(mean))

 meansandstdevs<-df
 groupedmeansandstdevs<-sa
 
 write.table(groupedmeansandstdevs,"groupedmeansandstdevs.txt",row.names=FALSE)
 
 ##clean up workspace
 rm(list=c("activities", "features", "testlabels", "testset", "df", "sa", "testsubjects",
           "trainlabels", "trainset", "trainsubjects", "foi", "foicols", "foinames"))
