require 'hue'
require 'launchy'
require 'pry'

class Light
  def initialize
    client = Hue::Client.new
    @light = client.lights.first
  end

  def change_color
    @light.on!
    @light.brightness = 250
    # positive hue is 12750, negative hue is 46920
    @sentiment == 'positive' ? positive_hue : negative_hue
  end

  def launch_projection
    Launchy.open("/Users/sarah/Desktop/code/WhatsLeftBehind/tweets.html")
  end

  def change_projection_tweet(tweet_number)
    tweets = ['positive', 'neutral', 'neutral', 'neutral', 'positive', 'negative', 'neutral', 'negative', 'positive', 'positive', 'neutral', 'negative', 'neutral', 'positive', 'neutral', 'neutral', 'positive', 'positive', 'neutral', 'negative', 'positive']
    @sentiment = tweets(tweet_number)
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

kitchenLight = Light.new
kitchenLight.color_loop
