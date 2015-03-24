module RubyGame
  class Game < Gosu::Window
    def initialize
      super(640, 480, false)
      @background_image = Gosu::Image.new(self,File.join(IMAGES_PATH, 'background.png'),true )
      @player = Player.new(self,590,420)
      @ruby = Ruby.new(self,100,100)
    end

    def draw
      @background_image.draw(0,0,0)
      @player.draw
      @ruby.draw
    end

    def start!
      self.show
    end
  end
end
