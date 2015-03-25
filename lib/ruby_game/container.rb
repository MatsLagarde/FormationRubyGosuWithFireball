module RubyGame
  class Container
    attr_accessor :representation, :image, :x, :y, :width, :height


    def initialize(positionX, positionY, image_name, speed)
      @image = image_name
      @x , @y = positionX , positionY
      @speed = speed
    end


    def init_image(scenery)
      @width = scenery.width
      @height = scenery.height
      @representation = Gosu::Image.new(scenery,File.join(IMAGES_PATH, self.image),true )
    end


    def draw
      @representation.draw_rot(@x,@y,0,0)
    end


    def move_left
      if @x > 0
        @x = @x - @speed
      end
    end


    def move_right
      if @x < @width
        @x = @x + @speed
      end
    end


    def move_up
      if @y>0
        @y = @y - @speed
      end
    end


    def move_down
      if @y < @height
        @y = @y + @speed
      end
    end


    def touch?(target)
      Math.hypot(target.x-@x, target.y-@y) <= 30
    end

  end
end
