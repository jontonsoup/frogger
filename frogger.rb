Shoes.app(:width => 550, :height => 600, :resizable => false) do
  init
  @running = false
  run_game
end

def restart_game
 @running = false
 clear_game
 init
 run_game
end

def clear_game
  @frog.remove
  @right_moving_cars.each {|x| x.remove}
  @left_moving_cars.each {|x| x.remove}
end


def init
  car_spacing = 100

  (0..20).each do |i|
    @lines = flow {line 0,i * 60, width, i * 60}
  end
  @frog = oval 10, 550, 40

  @right_moving_cars = []
  (0..4).each do |i|
    offset = i * 300 * rand
    top_offset = (100 + i * car_spacing)
    @right_moving_cars << rect(offset, top_offset, 50, 10)
  end

  @left_moving_cars = []
  (0..4).each do |i|
    offset = i * 300 * rand
    top_offset = (130 + i * car_spacing)
    @left_moving_cars << rect(offset, top_offset, 50, 10)
  end
end


def run_game
  @running = confirm "Start Game?"

  move_position = 20
  car_speed = 5
  @bottom = 500
  @right = 500
  @left = 0
  collision_size_top = 20
  collision_size_right = 50


  keypress do |k|
    if k == :up
      @frog.move(@frog.left, @frog.top - move_position)
    end
    if k == :down
      @frog.move(@frog.left, @frog.top + move_position)
    end
    if k == :right
      @frog.move(@frog.left + move_position, @frog.top )
    end
    if k == :left
      @frog.move(@frog.left - move_position, @frog.top )
    end
  end

  animate(car_speed) do
    if @running
      @right_moving_cars.each do |car|
        if @right < car.left
          car.move(0, car.top)
        else
          car.move(car.left + move_position, car.top)
        end
        if car.top + collision_size_top > @frog.top && car.top - collision_size_top < @frog.top && car.left + collision_size_right > @frog.left && car.left - collision_size_right < @frog.left
          restart_game
        end
      end
      @left_moving_cars.each do |car|
        if @left > car.left
          car.move(@right, car.top)
        else
          car.move(car.left - move_position, car.top)
        end
        if car.top + collision_size_top > @frog.top && car.top - collision_size_top < @frog.top && car.left + collision_size_right > @frog.left && car.left - collision_size_right < @frog.left
          restart_game
        end
      end

      if @frog.top < 40
        alert "You won!"
        restart_game
      end
    end
  end
end

