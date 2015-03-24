module RubyGame
  class Container
    attr_accessor :representation, :x, :y

    def initialize(scenary, positionX, positionY, image_name)
      @representation = Gosu::Image.new(scenary,File.join(IMAGES_PATH, image_name),true )
      @x = positionX
      @y = positionY
    end

    def draw
      @representation.draw(@x,@y,0)
    end
    
  end
end
