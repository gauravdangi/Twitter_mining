#Extracting data from twitter for Game of thrones
library(RCurl)
library(twitteR)
library(tm)
library(wordcloud)
library(SnowballC)
#get following details from apps.twitter.com
API_Key='hbuUzNQy5R5ynnpCI8vf3PH0K'
API_Secret='pkYesEirOZPIGpEN5n4kOBtyyCVcol04equSattxx7Iaixp5N2'
Access_Token='466563423-tHBRzZAaDNjfZF1bE7qKMuhKJFxrBls6F7NDdYej'
Access_Token_Secret='r25LJWoqK3v5gqu9WzcnevQpsqroG9a5y63xAwo1Tseb3'
setup_twitter_oauth(API_Key,API_Secret,Access_Token,Access_Token_Secret)

##searching for 50 recent tweets which mention the word 'GOT' and 'Game of thrones' and 'Hodor'
got<-searchTwitter("Game of thrones",n=1000,lang = 'en',resultType = "recent")
head(got)

got <- sapply(got, function(x) x$getText())
head(got)

gotC<-Corpus(VectorSource(got))
#to view gotC(Example view 3rd tweet)
gotC[[3]]$content

#Now we need to clean them

gotC=tm_map(gotC,removePunctuation)
gotC=tm_map(gotC,removeWords,stopwords("english"))
gotc=tm_map(gotC,removeNumbers)
gotC=tm_map(gotC,content_transformer(tolower))
gotC=tm_map(gotC,stripWhitespace)
gotC=tm_map(gotC,removeWords,c("httpst..","https","now","how","via","are"))
#Next, we will perform stemming. This means that all the words are converted to their stem (Ex: learning -> learn, walked -> walk, etc.
#SnowballC is required for this
gotC=tm_map(gotC,stemDocument)

wordcloud(gotC,min.freq=3,random.order=F,sampe=c(5,0.5))
wordcloud(gotC,min.freq=3,random.order=F,sampe=c(5,0.5),colors = c(3,2,6))
          