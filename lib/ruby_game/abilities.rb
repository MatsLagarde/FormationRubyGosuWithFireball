module RubyGame
  module Abilities
    def move_left()
      @x = @x - @speed if @x > 0
    end

    def move_right()
      @x = @x + @speed if @x < @width
    end

    def move_up()
      @y = @y - @speed if @y>0
    end

    def move_down()
      @y = @y + @speed if @y < @height
    end

    def move_follow()
      @x += (@target.x <=> @x)
      @y += (@target.y <=> @y)
    end

    def change_course()
      @dir = [:left,:right,:up,:down].sample
    end

    def move_on_rails()
      self.public_send("move_" + @dir.to_s)
      change_course if collision?
    end

    def move_random()
      @dir = change_course
      self.public_send("move_" + @dir.to_s)
    end

    def touch?(target)
      Math.hypot(target.x-@x, target.y-@y) <= 30
    end

    def collision?()
      @x <= 0 || @x >= @width || @y <= 0 || @y >= @height
    end
  end
end
