require 'hue'

class Light
  def initialize
    client = Hue::Client.new
    @light = client.lights.first
  end

  def change_color
    @light.on!
    if @light.hue == 46920
      @light.hue = 65280
    else
      @light.hue = 46920
    end
  end

  def trigger_color
    # 30 minutes from now
    end_time = Time.now + 1800
    loop do
      if Time.now < end_time
        sleep 2
        change_color
      end
    end
  end

end

kitchenLight = Light.new
kitchenLight.trigger_color
