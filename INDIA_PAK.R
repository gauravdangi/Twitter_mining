#Extracting data from twitter
library(RCurl)
library(twitteR)
library(tm)
library(wordcloud)
#get following details from apps.twitter.com
API_Key='hbuUzNQy5R5ynnpCI8vf3PH0K'
API_Secret='pkYesEirOZPIGpEN5n4kOBtyyCVcol04equSattxx7Iaixp5N2'
Access_Token='466563423-tHBRzZAaDNjfZF1bE7qKMuhKJFxrBls6F7NDdYej'
Access_Token_Secret='r25LJWoqK3v5gqu9WzcnevQpsqroG9a5y63xAwo1Tseb3'
setup_twitter_oauth(API_Key,API_Secret,Access_Token,Access_Token_Secret)

#searching for 50 recent tweets which mention the word 'sultan' and 'Salman Khan'
india_pak<-searchTwitteR("India+Pakistan+war",n=5000,lang = 'en',resultType = "recent")
india_pak
head(india_pak)
#convert messey list to character vector
war_ip=sapply(india_pak,function(x) x$getText())
war_ip
ip=Corpus(VectorSource(war_ip))
ip
#for reading from sultan_c
ip[[1]]$content

#remove unwanted things
?tm_map
?tm_filter
ip=tm_map(ip,removePunctuation)
ip=tm_map(ip,removeNumbers)
ip=tm_map(ip,content_transformer(tolower))
ip=tm_map(ip,removeWords,stopwords("english"))
ip=tm_map(ip,removeWords,c("https","via","and","httpstco0rusf.."))
ip=tm_map(ip,stripWhitespace)

#Using wordcloud for fancy result
wordcloud(ip)
wordcloud(ip,random.order = F,scale = c(5,0.5))
wordcloud(ip,random.order = F,scale = c(5,0.5),colors = rainbow(100))
