var sentiment = require('sentiment');
var https = require('https');
var cheerio = require('cheerio');
// for(var i=0; i < tweets.length; i++) {
//   var tweet = tweets[i]
//   var tweet_sentiment = sentiment(tweet)
//   console.dir(tweet_sentiment.tokens)
//   // sorting tweets into negative, neutral, and positive
//   if ((tweet_sentiment['comparative']) < 0) {
//     // console.dir('Negative: ' + tweet_sentiment['negative'])
//   } else if ((tweet_sentiment['comparative']) > 0) {
//     // console.dir('Positive: ' + tweet_sentiment['positive'])
//   } else {
//     // console.dir('Neutral: ' + tweet_sentiment['neutral'])
//   }
// }

var options = {
  host: 'twitter.com',
  path: '/search?q=near%3A%22Manchester%2C+England%22+within%3A15mi+since%3A2015-07-02+until%3A2015-07-19&ref_src=twsrc%5Etfw&ref_url=https%3A%2F%2Ftwitter.com%2Fsettings%2Fwidgets%2Fnew%2Fsearch'
};

var req = https.request(options, function(res) {
  res.setEncoding('utf8');
  res.on('data', function (chunk) {
    var $ = cheerio.load(chunk);
    console.dir($(".TweetTextSize").text());
  });
});

req.write('data\n');
req.write('data\n');
req.end();
