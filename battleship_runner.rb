# frozen_string_literal: true

require_relative('./game')

def run
  game = Game.new
  game.start
end

run
