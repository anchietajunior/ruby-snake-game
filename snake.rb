require 'ruby2d'
require './lib/snake.rb'
require './lib/game.rb'

set background: 'navy'
set fps_cap: 20

# width = 640 / 20 = 32
# height = 480 / 20 = 24

KEYS = %w[up down left right]
GRID_SIZE = 20
GRID_WIDTH = Window.width / GRID_SIZE
GRID_HEIGHT = Window.height / GRID_SIZE

snake = Snake.new
game = Game.new

update do
  clear

  unless game.finished?
    snake.move
  end

  snake.draw
  game.draw

  if game.snake_hit_ball?(snake.x, snake.y)
    game.record_hit
    snake.grow
  end

  if snake.hit_it_self?
    game.finish
  end
end

on :key_down do |event|
  if KEYS.include?(event.key)
    snake.direction = event.key if snake.can_change_direction_to?(event.key)
  elsif event.key == 'r'
    snake = Snake.new
    game = Game.new
  end
end

show
