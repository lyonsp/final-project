schoolData <- read.csv("finalSchoolData.csv")
selectSchoolLevel <- function(gradeLevel) {
  if(gradeLevel == "all") {
    return(schoolData)
  } else {
   selectedLevel <- schoolData %>% filter(schoolLevel == gradeLevel)
    return(selectedLevel)
  }
}

selectSchoolLevel("Elementary")
