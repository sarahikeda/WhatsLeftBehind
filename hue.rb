require 'hue'

class Light
  def initialize
    client = Hue::Client.new
    @light = client.lights.first
  end

  def change_color
    @light.on!
    @light.brightness = 250
    # positive hue is 12750, negative hue is 46920
    @light.hue == 46920 ? positive_hue : negative_hue
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
    # 30 minutes from now
    end_time = Time.now + 1800
    loop do
      if Time.now < end_time
        sleep 4
        change_color
      end
    end
  end

end

kitchenLight = Light.new
kitchenLight.color_loop
