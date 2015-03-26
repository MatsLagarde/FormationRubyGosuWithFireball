module RubyGame
  class Container
    attr_accessor :representation, :image, :x, :y, :width, :height, :target


    def initialize(positionX, positionY, image_name, speed, dir = :up)
      @image, @x, @y, @speed, @dir = image_name, positionX , positionY, speed, dir
    end

    def init_image(scenery)
      @width, @height = scenery.width, scenery.height
      @representation = Gosu::Image.new(scenery,File.join(IMAGES_PATH, self.image),true )
    end

    def draw
      @representation.draw_rot(@x,@y,0,0)
    end

  end
end
