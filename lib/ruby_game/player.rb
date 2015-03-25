module RubyGame
  class Player < Container

    def initialize(positionX, positionY, motif="player.png",speed, maxfireball)
      super(positionX, positionY, motif="player.png",speed)
      @limit = maxfireball
      @MyFireball = []
    end

    def init_fireball
      max = @limit -1
      for n in (0..7) do
        @MyFireball << [Container.new(@x,@y,"fireball.png",7),x: @x,y: @y, state: :attach]
      end
    end
  end
end
