var sentiment = require('sentiment');

tweets = ["Cloud 23 #Manchester #Hilton @h4yl3ylou @ Cloud 23 https://instagram.com/p/5S_u5wwysi/","@dickfundy blade II you mean...", "@gfawkes191 and about ww2, what do you mean exactly? Germany ? Cos guess what? It's just a football rivalry ","@gfawkes191 we hate the french? Nope sorry. It's just a joke. And argentina? Well I don't hate them. I don't know anyone who does","@Ryanb8499 I meant you as in ireland. But still.. You get my point? Only revenge should be taken on the people who committed the atrocities","The lion roars #JimmyCliff @ Manchester Academy https://instagram.com/p/5S-8_ih6Wu/ ","Me and my Jen  talking about too mad memories  xxxx #lifelongfriends #SchoolRenuion… https://instagram.com/p/5S-4kpCqSp/ ","Wonderful world #JimmyCliff @ Manchester Academy https://instagram.com/p/5S-1BiB6Wk/ ","[PART 2]\n\nBH - Promise  @ Fallowfield,Manchester https://instagram.com/p/5S-uGGRWiM/ ","@southg8lad @Yoga_John We're so going to have to take fetish wear shopping", "#crazypedros #pizza #manchester @ Crazy Pedro's Part Time Pizza Parlour https://instagram.com/p/5S-oJ7RGF_/ ", "MK was something else today!", "The Paperchase Cafe does the best lattes! @ Paperchase https://instagram.com/p/5S-JqksHSw/ ", "#CityByNight #Manchester #England #0046 #cantsleep @ Stalybridge Cheshire https://instagram.com/p/5S-OS3OLi_/ ", "Brioch and bacon crusted Pigeon Brest, confit pigeon leg, baby vegetables, #textures #oneeighty… https://instagram.com/p/5S-ADOptcY/ ", "Hawaii themed 21st Birthday.  #luau @ Manchester, United Kingdom https://instagram.com/p/5S9_Q2G55q/ ", "Lamb rump lamb loin, sweet Breads, watercress purée, crispy shallot rings, lambs jus #theone… https://instagram.com/p/5S9st0Jtb6/ ", "@barneyrednews gutted he was robbed!  #CrollaPerez", "Midnight steak  Joint open till 5am... #dangerous #lovemanchester  @ Toro's Steakhouse https://instagram.com/p/5S9gd-CSw-/ ","@LegacyFifa18 count down please"]

for(var i=0; i < tweets.length; i++) {
  var tweet_sentiment = sentiment(tweets[i])
  // sorting tweets into negative, neutral, and positive
  if ((tweet_sentiment['comparative']) < 0) {
    console.dir('Negative: ' + tweet_sentiment['negative'])
  } else if ('Positive: '+ (tweet_sentiment['comparative']) > 0) {
    console.dir(tweet_sentiment['positive'])
  } else {
    if ((tweet_sentiment['words'].length) >= 1) {
      console.dir('Neutral: '+ tweet_sentiment['words'])
    }
  }
}
