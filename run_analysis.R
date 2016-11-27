download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "getdata_dataset.zip", method="curl")
unzip("getdata_dataset.zip") 

files <- list.files("./UCI HAR Dataset", recursive=TRUE)
Activity_Test  <- read.table("./UCI HAR Dataset/test/y_test.txt",header = FALSE)
Activity_Train <- read.table("./UCI HAR Dataset/train/y_train.txt",header = FALSE)
Subject_Train <- read.table("./UCI HAR Dataset/train/subject_train.txt",header = FALSE)
Subject_Test  <- read.table("./UCI HAR Dataset/test/subject_test.txt",header = FALSE)
Features_Test  <- read.table("./UCI HAR Dataset/test/X_test.txt",header = FALSE)
Features_Train <- read.table("./UCI HAR Dataset/train/X_train.txt",header = FALSE)

Subject <- rbind(Subject_Train, Subject_Test)
Activity<- rbind(Activity_Train, Activity_Test)
Features<- rbind(Features_Train, Features_Test)
names(Subject)<-c("subject")
names(Activity)<- c("activity")
Features_Names <- read.table("./UCI HAR Dataset/features.txt",head=FALSE)
names(Features)<- Features_Names$V2
Data <- cbind(Features, Subject, Activity)

sub_Features_Names<-Features_Names$V2[grep("mean\\(\\)|std\\(\\)", Features_Names$V2)]
selected_Names<-c(as.character(sub_Features_Names), "subject", "activity" )
Data<-subset(Data,select=selected_Names)

activity_Labels <- read.table("./UCI HAR Dataset/activity_labels.txt",header = FALSE)
Data$activity<-factor(Data$activity);
Data$activity<- factor(Data$activity,labels=as.character(activity_Labels$V2))

library(dplyr)
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)
