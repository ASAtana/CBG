library(tidyverse)
library(twitteR)
tb_twitter <- searchTwitter("travelban",n=100)

tb_twitter_df <- twListToDF(tb_twitter) 

tweet_words <- tb_twitter_df %>% select(id, text) %>% unnest_tokens(word,text)

tweet_words %>% count(word,sort=T) %>% slice(1:20) %>% 
  ggplot(aes(x = reorder(word, 
    n, function(n) -n), y = n)) + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 60, 
    hjust = 1)) + xlab("")
	

my_stop_words <- stop_words %>% select(-lexicon) %>% 
  bind_rows(data.frame(word = c("https", "t.co", "rt", "amp","travelban")))

tweet_words_interesting <- tweet_words %>% anti_join(my_stop_words)

tweet_words_interesting %>% group_by(word) %>% tally(sort=TRUE) %>% slice(1:25) %>% ggplot(aes(x = reorder(word, 
    n, function(n) -n), y = n)) + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 60, 
    hjust = 1)) + xlab("")
	
bing_lex <- get_sentiments("bing")

fn_sentiment <- tweet_words_interesting %>% left_join(bing_lex)

fn_sentiment %>% filter(!is.na(sentiment)) %>% group_by(sentiment) %>% summarise(n=n())