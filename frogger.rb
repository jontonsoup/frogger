Shoes.app(:width => 500, :height => 500, :resizable => false) do
  init

  move_position = 20
  car_speed = 5
  @bottom = 500
  @right = 500
  @left = 0


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
    @right_moving_cars.each do |car|
      if @right < car.left
        car.move(0, car.top)
      else
        car.move(car.left + move_position, car.top)
      end
    end
    @left_moving_cars.each do |car|
      if @left > car.left
        car.move(@right, car.top)
      else
        car.move(car.left - move_position, car.top)
      end
    end
  end
end


def init
  @slot = stack
  car_spacing = 100

  (0..20).each do |i|
    flow {line 0,i * 60, width, i * 60}
  end
  @frog = oval 10, 400, 40

  @right_moving_cars = []
  (0..5).each do |i|
    @right_moving_cars << rect(@left, i * car_spacing, 50, 10)
  end

  @left_moving_cars = []
  (0..5).each do |i|
    @left_moving_cars << rect(@right, i * car_spacing + 30, 50, 10)
  end
end

