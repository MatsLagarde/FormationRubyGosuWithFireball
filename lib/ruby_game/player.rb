module RubyGame
  class Player < Container
    def initialize(scenary, positionX, positionY)
      super(scenary, positionX, positionY, "player.png")
    end
  end
end
