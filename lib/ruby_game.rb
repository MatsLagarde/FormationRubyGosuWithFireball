require "gosu"
require "awesome_print"
require_relative "ruby_game/container"
require_relative "ruby_game/player"
require_relative "ruby_game/ruby"
require_relative "ruby_game/monster"
require_relative "ruby_game/game"


module RubyGame

  ROOT_PATH = File.expand_path('../',File.dirname(__FILE__))
  IMAGES_PATH = File.join(ROOT_PATH, "app/assets/images")

end
