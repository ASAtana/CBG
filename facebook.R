library(devtools)

require (Rfacebook)

fb_oauth <- fbOAuth(app_id="1234567890", app_secret="1A2B3C4D",extended_permissions = TRUE)

save(fb_oauth, file="fb_oauth") 
load("fb_oauth")

me <- getUsers("me",token=fb_oauth)

my_likes <- getLikes(user="me", token=fb_oauth)

token <- 'YOUR AUTHENTICATION TOKEN'
me <- getUsers("me", token, private_info=TRUE)
 
getUsers(c("def", "abc"), token)