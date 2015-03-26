module RubyGame
  class Player < Container
    include Abilities
    def initialize(positionX, positionY, motif="player.png",speed, maxfireball)
      super(positionX, positionY, motif="player.png",speed)
      @limit = maxfireball
      @MyFireball = []
    end

    def fireball(dir,scenery)
      fireball = Monster.new(@x,@y,"redlavaball.gif",7,dir)
      fireball.init_image(scenery)
      return fireball
    end
  end
end
