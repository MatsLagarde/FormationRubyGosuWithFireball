module RubyGame
  class Game < Gosu::Window
    def initialize()
      super(640, 480, false)
      self.caption = "Romancing the Ruby"
      @background_image = Gosu::Image.new(self,File.join(IMAGES_PATH, 'background.png'),true )
      @font = Gosu::Font.new(self,Gosu::default_font_name, 60)
      @time = 0
    end

    def player(image, x, y, speed, fireball)
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
      monstre.target = @joueur
      @monstres << monstre
    end


    def random_monster()
      motif = ["ghost1.png","ghost2.png","ghost3.png","cactuar.png","dark_knight.png","hornet.png","undead.png"]
      behaviour = [:random,:on_rails,:follow]
      monsters(motif.sample, 200, rand(0..480), rand(1..3), behaviour.sample)
    end

    def set_monster_lambada(crowd, behaviour)
      motif = ["ghost1.png","ghost2.png","ghost3.png","cactuar.png","dark_knight.png","hornet.png","undead.png"]
      crowd.times do
        monsters(motif.sample, 200, rand(0..480), rand(1..3),behaviour)
      end
    end

    def update
      if(@state==:running)
        @time += 1
        @joueur.move_left if button_down?(Gosu::Button::KbLeft)
        @joueur.move_right if button_down?(Gosu::Button::KbRight)
        @joueur.move_up if button_down?(Gosu::Button::KbUp)
        @joueur.move_down if button_down?(Gosu::Button::KbDown)
        @state = :win if @joueur.touch?(@gemme)
        @gemme.move()
        keep_spells = []

#on lance des sorts et on regarde si il atteigne le mur ou un monstre
        @spells.each do |spell|
          keep_monsters = []
          spell.move()
          keep_spell = true
          if !spell.collision?
            @monstres.each do |monstre|
              if spell.touch?(monstre)
                keep_spell = false
                @score +=1
                cheer_up
              else
                keep_monsters << monstre
              end
            end
            keep_spells << spell if keep_spell
            @monstres = keep_monsters
          end
        end
        @spells = keep_spells


#on bouge les monstres et on regarde si il touche le joueur

        @monstres.each do |monstre|
          if monstre.touch?(@joueur)
            @state = :lose
          else
            monstre.move()
          end
        end

        if(@time == 20)
          random_monster
          @time = 0
        end
      end
    end


    def button_down(id)
      self.close if id == Gosu::Button::KbEscape
      self.restart! if id== Gosu::Button::KbR
      @spells << @joueur.fireball(:right,self) if id == Gosu::Button::KbD
      @spells << @joueur.fireball(:left,self) if id == Gosu::Button::KbA
      @spells << @joueur.fireball(:up,self) if id == Gosu::Button::KbW
      @spells << @joueur.fireball(:down,self) if id == Gosu::Button::KbS
    end

    def cheer_up()
      @cheers = case @score
        when 0..50 then "Not bad continue"
        when 51..100 then "Great"
        when 101..200 then "Super KIILL"
        when 201..300 then "OVERKILLLL"
        else "You're GOOOOD LIKE"
      end
    end

    def draw
      my_draw = lambda { |o| o.draw }
      @background_image.draw(0,0,0)
      @font.draw("kill: "+ @score.to_s + " " + @cheers,10,10,2,1.0,1.0,0xffffff00)
      @font.draw("You won!",200,240,2,1.0,1.0,0xffffff00) if @state == :win
      if @state == :lose
        @font.draw("  You Lose ",180,220,2,1.0,1.0,0xffffff00)
        @font.draw("Insert Coin!",180,260,2,1.0,1.0,0xffffff00)
      end
      @joueur.draw
      @gemme.draw
      @spells.each { |spell| spell.draw }
      @monstres.each { |monstre| monstre.draw }
    end

    def init_static_values()
      @monstres = []
      @spells = []
      @score = 0
      @cheers = ""
      @state = :running
    end

    def start!(&block)
      init_static_values
      @init = block if block_given?
      self.instance_eval(&@init)
      self.show if block_given?
    end


    def restart!
      self.start!
    end

  end
end
