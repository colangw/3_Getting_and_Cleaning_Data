Coursera Course - Getting and Cleaning Data (getdata-009)
Final course project
Submitted by:
Werner Colangelo
wernercolangelo@gmail.com

Getting and Cleaning Data Course Project
========================================
This file describes the steps to make the run_analysis.R script work.
1. First, unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and rename the folder with "data".
--* Make sure the run_analysis.R script is in the data directory and set your working directory to this folder:
--* setwd("~./data")
2. Run the source("run_analysis.R") command in RStudio. 
3. One output file will be generated in the current working directory.
--* tidyData.txt (63 Kb): it contains a data frame with dim of 180*21
4. Use data <- read.table("tidy_data.txt") command in RStudio to read the file. Note that there are 6 activities in total and 30 subjects in total and therefore has 180 rows.