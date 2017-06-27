require 'HTTParty'
require 'Nokogiri'
require 'JSON'
require 'hue'
require 'launchy'
require 'pry'
require 'sentimental'
require 'rb_lib_text'

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

  def get_tokens
    @tweets.map {|tweet| RbLibText.tokens(tweet[0])[0..2] }
  end

end

class Light

  def initialize(tweets)
    @tweet = tweets
    client = Hue::Client.new
    @light = client.lights.first
  end

  def change_color
    @light.on!
    @light.brightness = 250
    # positive hue is 12750, negative hue is 46920
    if @sentiment == :positive
      positive_hue
    elsif @sentiment == :negative
      negative_hue
    else
      neutral_hue
    end
  end

  def launch_projection
    Launchy.open("/Users/sarah/Desktop/code/WhatsLeftBehind/tweets.html")
  end

  def change_projection_tweet(tweet_number)
    sentiments = @tweet.get_tweets
    @sentiment = sentiments[tweet_number]
  end

  def positive_hue
    @light.hue = 12750
    @light.saturation = 50
    @light.brightness = 250
  end

  def negative_hue
    @light.hue = 46920
    @light.saturation = 250
    @light.brightness = 250
  end

  def neutral_hue
    @light.hue = 12750
    @light.saturation = 50
    @light.brightness = 100
  end

  def color_loop
    launch_projection
    tweet_number = 0
    # 30 minutes from now
    end_time = Time.now + 200
    loop do
      if Time.now < end_time
        sleep 2
        change_projection_tweet(tweet_number)
        change_color
        tweet_number +=1
      end
    end
  end

end

class Installation
  def initialize
    @tweets = Tweet.new('https://twitter.com/search?q=near%3A%22Manchester%2C+England%22+within%3A15mi+since%3A2015-07-02+until%3A2015-07-19&ref_src=twsrc%5Etfw&ref_url=https%3A%2F%2Ftwitter.com%2Fsettings%2Fwidgets%2Fnew%2Fsearch')
    @tweets.get_tweets
    @light = Light.new(@tweets)
  end

  def create_projection
    @words_from_tweets = @tweets.get_tokens
    @light.color_loop
    # Launchy.open("/Users/sarah/Desktop/code/WhatsLeftBehind/tweets.html")
  end
end

installation = Installation.new
installation.create_projection
