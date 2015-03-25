module RubyGame
  class Game < Gosu::Window
    def initialize()
      super(640, 480, false)
      self.caption = "Romancing the Ruby"
      @background_image = Gosu::Image.new(self,File.join(IMAGES_PATH, 'background.png'),true )
      @font = Gosu::Font.new(self,Gosu::default_font_name, 60)
    end

    def player image, x, y, speed, fireball
      @joueur = Player.new( x, y, image, speed, fireball)
      @joueur.init_image(self)
    end

    def ruby image, x, y, speed, behaviour
      @gemme = Monster.new( x, y, image, speed, behaviour )
      @gemme.init_image(self)
    end

    def monsters  image, x, y, speed, behaviour
      monstre = Monster.new( x, y, image, speed, behaviour )
      monstre.init_image(self)
      @monstres << monstre
    end

    def update
      if(@state==:running)
        @joueur.move_left if button_down?(Gosu::Button::KbLeft)
        @joueur.move_right if button_down?(Gosu::Button::KbRight)
        @joueur.move_up if button_down?(Gosu::Button::KbUp)
        @joueur.move_down if button_down?(Gosu::Button::KbDown)

        @spell = player.fireball
        @state = :win if @joueur.touch?(@gemme)
        @gemme.move(@joueur)
        @monstres.each do |monstre|
          monstre.move(@joueur)
          @state = :lose if monstre.touch?(@joueur)
        end
      end
    end

    def draw
      @background_image.draw(0,0,0)
      @font.draw("You won!",200,240,2,1.0,1.0,0xffffff00) if @state == :win
      if @state == :lose
        @font.draw("  You Lose ",180,220,2,1.0,1.0,0xffffff00)
        @font.draw("Insert Coin!",180,260,2,1.0,1.0,0xffffff00)
      end
      @joueur.draw
      @gemme.draw
      @monstres.each do |monstre|
        monstre.draw
      end
    end

    def start!(&block)
      @state = :running
      @monstres = []
      @spell = []
      if block_given?
        @params = block
        block.call(self)
        self.show
      else
        @params.call(self)
      end

    end

    def button_down(id)
      self.close if id == Gosu::Button::KbEscape
      self.restart! if id== Gosu::Button::KbR
    end

    def restart!
      self.start!
    end

  end
end
