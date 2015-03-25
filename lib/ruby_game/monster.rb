module RubyGame
  class Monster < Container
    def initialize(positionX, positionY, motif="ghost1.png",speed, behaviour)
      super(positionX, positionY, motif, speed)
      @behaviour = behaviour
      @dir = :left
    end

    def move(player)
      case @behaviour
      when :random
        self.random_move
      when :follow
        self.follow(player)
      when :onRails
        self.go_on_rails
      end
    end

    def go_on_rails()
      if @dir == :left
        self.move_left
      else
        self.move_right
      end

      if(self.x <= 0 && @dir == :left)
        @dir = :right
      end
      if(self.x >= self.width && @dir == :right)
        @dir = :left
      end

    end

    def follow(player)
      self.x += (player.x <=> self.x)
      self.y += (player.y <=> self.y)
    end

    def random_move()
      a = rand(0..4)
      case a
        when 0
          #do nothing
        when 1
          self.move_up
        when 2
          self.move_right
        when 3
          self.move_down
        when 4
          self.move_left
        else
          #do nothing
      end
    end
  end
end
