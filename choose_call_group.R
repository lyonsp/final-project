
choose_call_group <- function(group) {
  chosen_group <- only_2012 %>% filter(Event.Clearance.Group == group)
  return(chosen_group)
}