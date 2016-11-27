This is the codebook for run_analysis.R

#download the file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "getdata_dataset.zip", method="curl")
unzip("getdata_dataset.zip") 

#read all required files
files <- list.files("./UCI HAR Dataset", recursive=TRUE)
Activity_Test  <- read.table("./UCI HAR Dataset/test/y_test.txt",header = FALSE)
Activity_Train <- read.table("./UCI HAR Dataset/train/y_train.txt",header = FALSE)
Subject_Train <- read.table("./UCI HAR Dataset/train/subject_train.txt",header = FALSE)
Subject_Test  <- read.table("./UCI HAR Dataset/test/subject_test.txt",header = FALSE)
Features_Test  <- read.table("./UCI HAR Dataset/test/X_test.txt",header = FALSE)
Features_Train <- read.table("./UCI HAR Dataset/train/X_train.txt",header = FALSE)

#merge all files together
Subject <- rbind(Subject_Train, Subject_Test)
Activity<- rbind(Activity_Train, Activity_Test)
Features<- rbind(Features_Train, Features_Test)

#label files
activity_Labels <- read.table("./UCI HAR Dataset/activity_labels.txt",header = FALSE)
Data$activity<-factor(Data$activity);
Data$activity<- factor(Data$activity,labels=as.character(activity_Labels$V2))

#output tidy file
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)
