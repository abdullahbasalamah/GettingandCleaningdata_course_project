library(reshape2)

#get and download the data

filename<-"datause.zip"
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile=filename,method="curl")

unzip(filename)

#get activity and features that only extract mean and standard deviation only
activity<-read.table("UCI HAR Dataset/activity_labels.txt")
activity[,2]<-as.character(activity[,2])
features<-read.table("UCI HAR Dataset/features.txt")
features[,2]<-as.character(features[,2])

#load train data
xtrain<-read.table("UCI HAR Dataset/train/X_train.txt")
activitytrain<-read.table("UCI HAR Dataset/train/y_train.txt")
subjecttrain<-read.table("UCI HAR Dataset/train/subject_train.txt")
train<-cbind(subjecttrain,activitytrain,xtrain)

#load test data
xtest<-read.table("UCI HAR Dataset/test/X_test.txt")
activitytest<-read.table("UCI HAR Dataset/test/y_test.txt")
subjecttest<-read.table("UCI HAR Dataset/test/subject_test.txt")
test<-cbind(subjecttest,activitytest,xtest)

#merge train and test data all
datause<-rbind(train,test)

#only select the features mean and std and make the name standardize
featuresmeanstd<-grep(".*mean.*|.*std.*",features[,2])
datause<-cbind(datause[,1:2],datause[,featuresmeanstd+2])

featuresmeanstd.names<-features[featuresmeanstd,2]
featuresmeanstd.names<-gsub("-mean","Mean",featuresmeanstd.names)
featuresmeanstd.names<-gsub("-std","Std",featuresmeanstd.names)
featuresmeanstd.names<-gsub("[-()]","",featuresmeanstd.names)

colnames(datause)<-c("subject","activity",featuresmeanstd.names)

#make labelling for activity
datause$activity<-factor(datause$activity,levels=activity[,1],labels=activity[,2])
datause$subject<-as.factor(datause$subject)

#combine the features by column into 1 column
datause_melted <- melt(datause, id = c("subject", "activity"))

#calculated the mean of each features grop by Subject and activity
datause_mean <- dcast(datause_melted, subject + activity ~ variable, mean)

#write the table into file name "tidy.txt"
write.table(datause_mean, "tidy.txt", row.names = FALSE, quote = FALSE)