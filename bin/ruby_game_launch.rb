require_relative "../lib/ruby_game"

game = RubyGame::Game.new()

game.start! do |g|
  g.player   "player.png",      590, 420, 5, 3
  g.ruby     "ruby.png",        200, 200, 0, :on_rails
  g.set_monster_lambada(5, :follow)
  g.set_monster_lambada(2, :on_rails)

=begin
  g.monsters "ghost1.png",      200, 200, 3, :random
  g.monsters "cactuar.png",     200, 200, 3, :random
  g.monsters "ghost2.png",      200, 200, 3, :random
  g.monsters "ghost3.png",      200, 200, 3, :random
  g.monsters "dark_knight.png", 200, 200, 2, :follow
  g.monsters "hornet.png",      200, 200, 3, :random
  g.monsters "undead.png",      200, 200, 3, :random
=end

end
