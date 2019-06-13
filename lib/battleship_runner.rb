# frozen_string_literal: true

require_relative('./game')

def start_game
  game = Game.new
  game.start
end

start_game
