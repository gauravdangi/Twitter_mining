
library(RCurl)
library(twitteR)
library(tm)
library(wordcloud)
library(SnowballC)

setup_twitter_oauth(API_Key,API_Secret,Access_Token,Access_Token_Secret)
#Extracting data from twitter
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

sultan_c <- tm_map(sultan_c,removePunctuation)
sultan_c <- tm_map(sultan_c,removeNumbers)
sultan_c <- tm_map(sultan_c,content_transformer(tolower))
sultan_c <- tm_map(sultan_c,removeWords,stopwords("english"))
sultan_c <- tm_map(sultan_c,removeWords,c("https","via","and","httpstco0rusf.."))
sultan_c <- tm_map(sultan_c,stripWhitespace)
#Now we will perform stemming for better result
sultan_c <- tm_map(sultan_clean,stemDocument)
#Using wordcloud for fancy result
wordcloud(sultan_c)
wordcloud(sultan_c,random.order = F,scale = c(5,0.5))
wordcloud(sultan_c,min.freq=random.order = F,scale = c(5,0.5),color=rainbow(50))
wordcloud(sultan_c,random.order = F,scale = c(5,0.5),colors = rainbow(100))
