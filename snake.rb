require 'ruby2d'

set background: 'navy'
set fps_cap: 10

# width = 640 / 20 = 32
# height = 480 / 20 = 24

KEYS = %w[up down left right]
GRID_SIZE = 20
GRID_WIDTH = Window.width / GRID_SIZE
GRID_HEIGHT = Window.height / GRID_SIZE

class Snake
  attr_writer :direction

  def initialize
    @positions = [[2, 0], [2, 1], [2, 2], [2, 3]]
    @direction = 'down'
  end

  def draw
    @positions.each do |position|
      Square.new(
        x: position[0] * GRID_SIZE,
        y: position[1] * GRID_SIZE, 
        size: GRID_SIZE - 1, 
        color: 'white'
      )
    end
  end

  def move
    @positions.shift
    case @direction
    when 'down'
      @positions.push(new_coords(head[0], head[1] + 1))
    when 'up'
      @positions.push(new_coords(head[0], head[1] - 1))
    when 'left'
      @positions.push(new_coords(head[0] - 1, head[1]))
    when 'right'
      @positions.push(new_coords(head[0] + 1, head[1]))
    end
  end

  def can_change_direction_to?(new_direction)
    case @direction
    when 'up' then new_direction != 'down' 
    when 'down' then new_direction != 'up'
    when 'left' then new_direction != 'right'
    when 'right' then new_direction != 'left'
    end
  end

  private

  def new_coords(x, y)
    [x % GRID_WIDTH, y % GRID_HEIGHT]
  end

  def head
    @positions.last
  end
end

snake = Snake.new

update do
  clear
  snake.move
  snake.draw
end

on :key_down do |event|
  if KEYS.include?(event.key)
    snake.direction = event.key if snake.can_change_direction_to?(event.key)
  end
end

show
