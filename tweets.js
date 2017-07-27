var sentiment = require('sentiment');
var https = require('https');
var cheerio = require('cheerio');

function getTweets(){
  var options = {
    host: 'twitter.com',
    path: '/search?q=near%3A%22Manchester%2C+England%22+within%3A15mi+since%3A2015-07-02+until%3A2015-07-19&ref_src=twsrc%5Etfw&ref_url=https%3A%2F%2Ftwitter.com%2Fsettings%2Fwidgets%2Fnew%2Fsearch'
  };

  var req = https.request(options, function(res) {
    res.setEncoding('utf8');
    res.on('data', function (content) {
    scrapePage(content)
    });
  });
  req.end();
}

function scrapePage(content){
  var $ = cheerio.load(content);
  var tweet = $(".TweetTextSize").text()
  if (tweet !== '') {
    "tweet" + sentimentAnalyze(tweet)
  }
}

function sentimentAnalyze(tweet){
  var tweetResults = sentiment(tweet)
  if ((tweetResults['comparative']) < 0) {
      console.dir('Negative: ' + tweetResults.tokens.join(" "))
  } else if ((tweetResults['comparative']) > 0) {
      console.dir('Positive: ' + tweetResults.tokens.join(" "))
  } else {
      console.dir('Neutral: ' + tweetResults.tokens.join(" "))
  }
}

getTweets();
