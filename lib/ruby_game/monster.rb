module RubyGame
  class Monster < Container
    include Abilities

    def initialize(positionX, positionY, motif="ghost1.png",speed, behaviour)
      super(positionX, positionY, motif, speed)
      @behaviour = behaviour
    end


    def move()
      self.public_send("move_" + @behaviour.to_s)
    end

  end
end
