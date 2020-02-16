GETTING AND CLEANING DATA TERM PROJECT
======================================

This R project contains following files
* README.md: explains about project & files in it
* run_analysis.R: do data modification process that explained later on this file.
* data/tidy_dataset.txt: contains the processed data from the original file
* codebook.md: explains about the fields of tidy_dataset.txt


Main job of this project is conducted by "run_analysis.R".
The R file puts some modification and cleaning process on the UCI HAR Dataset
More specifically,
* Merges training and test data to build one and whole dataset
* Extracts only the fields of mean values and standard deviations
* Instead of activity codes, uses activity name describing of what is going on
* Puts descriptive names on all the fields
* Creates "tidy_dataset.txt"