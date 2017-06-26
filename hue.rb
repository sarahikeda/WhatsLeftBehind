require 'HTTParty'
require 'Nokogiri'
require 'JSON'
require 'hue'
require 'launchy'
require 'pry'
require 'sentimental'

class Tweet

  def initialize(website)
    @page = HTTParty.get(website)
    @analyzer = Sentimental.new
    # load default sentiment dictionaries
    @analyzer.load_defaults
  end

  def get_tweets
    scrape_page
    parse_page
    get_sentiment
  end

  def scrape_page
    @html_page = Nokogiri::HTML(@page)
  end

  def parse_page
    @tweets = []
    @html_page.css('.TweetTextSize').each do |tweet|
      @tweets << [tweet.text]
    end
  end

  def get_sentiment
    sentiments = @tweets.map {|tweet| @analyzer.sentiment tweet }
  end

end

class Light

  def initialize(sentiments)
    @sentiments = sentiments
    client = Hue::Client.new
    @light = client.lights.first
  end

  def change_color
    @light.on!
    @light.brightness = 250
    # positive hue is 12750, negative hue is 46920
    @sentiment == :positive ? positive_hue : negative_hue
  end

  def launch_projection
    Launchy.open("/Users/sarah/Desktop/code/WhatsLeftBehind/tweets.html")
  end

  def change_projection_tweet(tweet_number)
    @sentiment = @sentiments[tweet_number]
  end

  def positive_hue
    @light.hue = 12750
    @light.saturation = 50
  end

  def negative_hue
    @light.hue = 46920
    @light.saturation = 250
  end

  def color_loop
    launch_projection
    tweet_number = [0]
    # 30 minutes from now
    end_time = Time.now + 200
    loop do
      if Time.now < end_time
        sleep 4
        change_projection_tweet(tweet_number)
        change_color
        tweet_number +=1
      end
    end
  end

end

tweet = Tweet.new('https://twitter.com/search?q=near%3A%22Manchester%2C+England%22+within%3A15mi+since%3A2015-07-02+until%3A2015-07-19&ref_src=twsrc%5Etfw&ref_url=https%3A%2F%2Ftwitter.com%2Fsettings%2Fwidgets%2Fnew%2Fsearch')
sentiments = tweet.get_tweets
kitchenLight = Light.new(sentiments)
# kitchenLight.color_loop
