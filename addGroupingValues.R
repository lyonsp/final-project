schoolData <- schoolData %>% 
      select(Percent_Free_Lunch) %>% 
      mutate(Percent_Free_Lunch = Percent_Free_Lunch * 100) %>% 
      mutate(groupPercentLunch = Percent_Free_Lunch / 25) %>% 
      mutate(groupPercentLunch = round(groupPercentLunch, digits = 0))
 
schoolData <- schoolData %>% 
  select(Percent_One_Parent_Homes) %>% 
  mutate(Percent_One_Parent_Homes = Percent_One_Parent_Homes * 100) %>% 
  mutate(groupPercentSingle = Percent_One_Parent_Homes / 25) %>% 
  mutate(groupPercentSingle = round(groupPercentSingle, digits = 0))

schoolData <- schoolData %>% 
  select(Percent_Limited_English) %>% 
  mutate(Percent_Limited_English = Percent_Limited_English * 100) %>% 
  mutate(groupPercentLimited = Percent_Limited_English / 25) %>% 
  mutate(groupPercentLimited = round(groupPercentLimited, digits = 0))
