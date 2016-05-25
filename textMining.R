#Extracting data from twitter
library(RCurl)
library(twitteR)
library(tm)
library(wordcloud)
#get following details from apps.twitter.com
API_Key='########################################'
API_Secret='##################################################'
Access_Token='##################################################'
Access_Token_Secret='##################################################'
setup_twitter_oauth(API_Key,API_Secret,Access_Token,Access_Token_Secret)

#searching for 50 recent tweets which mention the word 'sultan' and 'Salman Khan'
sultan<-searchTwitteR("Sultan+Salman Khan",n=500,lang = 'en',resultType = "recent")
sultan
head(sultan)
#convert messey list to character vector
sultan_text=sapply(sultan,function(x) x$getText())
sultan_text
sultan_c=Corpus(VectorSource(sultan_text))
sultan_c
#for reading from sultan_c
sultan_c[[1]]$content

#remove unwanted things
?tm_map
?tm_filter
sultan_clean=tm_map(sultan_c,removePunctuation)
sultan_clean=tm_map(sultan_c,removeNumbers)
sultan_clean=tm_map(sultan_c,content_transformer(tolower))
sultan_clean=tm_map(sultan_c,removeWords,stopwords("english"))
sultan_clean=tm_map(sultan_c,removeWords,c("https","via","and","httpstco0rusf.."))
sultan_clean=tm_map(sultan_c,stripWhitespace)

#Using wordcloud for fancy result
wordcloud(sultan_clean)
wordcloud(sultan_clean,random.order = F,scale = c(5,0.5))
wordcloud(sultan_clean,random.order = F,scale = c(5,0.5),colors = rainbow(100))
