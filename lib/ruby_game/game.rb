require 'gosu'

module RubyGame
  class Game < Gosu::Window
    def initialize
      super(640, 480, false)
    end

    def start!
      self.show
    end
  end
end


c = RubyGame::Game.new
c.start!
