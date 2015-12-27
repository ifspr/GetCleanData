#-----The working directory contains the "UCI HAR Dataset" directory
datadir = "UCI\ HAR\ Dataset"

#-----Load the test data into dataframe "df_test"
setwd(paste(datadir,"/test/",sep=""))
X_test<-read.table('X_test.txt')
subject_test<-read.table('subject_test.txt')
y_test<-read.table('y_test.txt')
df_test<-Reduce(function(x,y) merge(x,y,by=0,all=TRUE),list(subject_test,y_test,X_test))[,3:565]

#-----Load the train data into dataframe "df_train"
setwd("../train")
X_train <- read.table('X_train.txt')
subject_train <- read.table('subject_train.txt')
y_train <- read.table('y_train.txt')
df_train<-Reduce(function(x,y) merge(x,y,by=0,all=TRUE),list(subject_train,y_train,X_train))[,3:565]

#-----Merge "df_test" and "df_train" into a new dataframe "df_all"
df_all <- rbind(df_test,df_train)

#-----Extract the mean and std measurements from "df_all" according to information provided in the "features.txt" in datadir, and store these in the new data frame "df_all2"
setwd("../")
flist<-read.table("features.txt")
indices<-grep("mean\\(\\)|std\\(\\)",flist[,2])
df_all2 <- df_all[,c(1,2,indices+2)]

#-----Replace the column names in df_all2 with more descriptive labels
colnames(df_all2)[3:68]<-as.character(flist[indices,2])
colnames(df_all2)[1]<-"Subject"
colnames(df_all2)[2]<-"Activity"

#-----Rename the activity labels according to "activity_labels.txt"
activity_list<-read.table('activity_labels.txt')
df_all2$Activity<-activity_list[,2][match(df_all2$Activity,activity_list[,1])]

#-----Create a new dataframe "newdf" that contains the average of the features for each subject and each activity
mtrx_example<-with(df_all2,tapply(df_all2[,3],list(df_all2[,1],df_all2[,2]),mean))
mtrx_all<-sapply(df_all2[,3:68],function(x) as.vector(with(df_all2,tapply(x,list(df_all2[,1],df_all2[,2]),mean))))
newdf <- data.frame(Activity=rep(colnames(mtrx_example),each=nrow(mtrx_example)),Subject=rep(rownames(mtrx_example),ncol(mtrx_example)),mtrx_all)

#-----Export "newdf" to a txt file
setwd("../")
write.table(newdf,file='tidydata.txt',row.names=FALSE)

#------Done----------

