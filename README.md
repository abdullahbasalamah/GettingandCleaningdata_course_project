## Getting & Cleaning data - Course Project
This is the course project for getting & Cleaning Data Course from Coursera.
below is the step that actually done in the r script run_analysis.R :
1. Download the data and unzip it due to the data is in zip format
2. Get the activity and Features as a reference table in the next step
3. load the train and test data and combined it into one table
4. Do the filter for column, only filter the column / measureed variable for mean and std only, exclude other measurement
5. Cleaning the naming of measured variable and assign the proper names for Subject and Activity
6. Combined all measured variable into one column using function melt
7. Calculate/Summarize the mean of the value group by Subject and Activity using function dcast
8. write the result into file named tidy.txt
