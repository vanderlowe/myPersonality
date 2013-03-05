myPersonality <- function() {
  all.tables <- myPersonalitySQL("SHOW TABLES;")[,1]
  
  defined.funcs <- data.table(
    table = c("demog", "address", "fb_employer", "swl", "fb_likes", "fb_user_likes"),
    func =  c("participants", "adress", "employers", "satisfaction_with_life","facebook_likes", "participant_likes")
  )
  cat("Currently, the following functions are available:\n")
  
  for (f in defined.funcs$func) {
    cat(f)
    cat("()\n")
  }
}