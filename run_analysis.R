run_analysis<-function(){
        
        ##"dplyr" and "tidyr" are the required libraries
                
        require(dplyr)
        require(tidyr)


        ## First it gets the data the program will use, that is supposed to be on the 
        ## local working directory
        
        dir<-getwd()
        xtest<-read.table(paste0(dir,"/UCI HAR Dataset/test/X_test.txt"))
        xtrain<-read.table(paste0(dir,"/UCI HAR Dataset/train/X_train.txt"))
        strain<-read.table(paste0(dir,"/UCI HAR Dataset/train/subject_train.txt"))
        ytrain<-read.table(paste0(dir,"/UCI HAR Dataset/train/y_train.txt"))
        ytest<-read.table(paste0(dir,"/UCI HAR Dataset/test/y_test.txt"))
        stest<-read.table(paste0(dir,"/UCI HAR Dataset/test/subject_test.txt"))
        
        ## Nest tbl_df is used on the tables for easier handling
        
        xtest<-tbl_df(xtest)
        xtrain<-tbl_df(xtrain)
        ytrain<-tbl_df(ytrain)
        ytest<-tbl_df(ytest)
        
        ## Then it merges the data
        
        x<-rbind(xtest, xtrain)
        x<-select(x, V1:V561)
        activities<-rbind(ytest,ytrain)
        subject<-rbind(stest,strain)
        
        ## It gets labels from "features" file and transforms each one into a valid name 
        
        l <- readLines(paste0(dir,"/UCI HAR Dataset/features.txt"))
        l<-sub("[[:alnum:]]* ", "", l)
        l<-make.names(names=l, unique=TRUE, allow_ = TRUE)
        names(x)<-c(l)
        
        ## To turn the activities from a number to a understandable description it defines
        ## the "numbertoactivity" function and proceeds to use it to write each
        ## activity
        
        numbertoactivity<-function(x){
                if (x == 1) { return("WALKING")}
                else if (x == 2) { return("WALKING_UPSTAIRS")}
                else if (x == 3) { return("WALKING_DOWNSTAIRS")}
                else if (x == 4) { return("SITTING")}
                else if (x == 5) { return("STANDING")}
                else if (x == 6) { return("LAYING")}
                
        }
        activities$V1<-lapply(activities$V1,numbertoactivity)
        x<-mutate(x, activity = activities$V1)
        x<-mutate(x,subject = subject$V1)
        
        ## Selects the columns that contain "mean" and "std" and groups the table
        ## by activity and subject.
        
        validx<-select(x, activity, subject, contains("mean"), contains("std"))
        validx$activity <- as.factor(unlist(validx$activity))
        xagrupado<-group_by(validx,activity, subject)
        
        ## Finally summarises the data to get the mean for each variable and for 
        ## the groups made 
        
        xfinal<-summarise_each(xagrupado,funs(mean))
        xfinal<-group_by(xfinal, activity, subject)
        
        ##Returns the table with the tidy data
        
        write.table(xfinal, file = paste0(dir,"/Tidy_data.txt"), row.name=FALSE)
        return(xfinal)
        
}

