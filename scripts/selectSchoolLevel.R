# Reads in the csv file that contains the data for the Seattle schools
schoolData <- read.csv("data/schoolData.csv")

# A function that takes in a grade level (all, elementary, middle school, or high school) and filters the dataset to contain only the schools that fit the grade level parameter
selectSchoolLevel <- function(gradeLevel) {
  if(gradeLevel == "all") {
    return(schoolData)
  } else {
   selectedLevel <- schoolData %>% filter(School_Level == gradeLevel)
    return(selectedLevel)
  }
}

