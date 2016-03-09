schoolData <- read.csv("schoolData.csv")
selectSchoolLevel <- function(gradeLevel) {
  if(gradeLevel == "all") {
    return(schoolData)
  } else {
   selectedLevel <- schoolData %>% filter(School_Level == gradeLevel)
    return(selectedLevel)
  }
}

