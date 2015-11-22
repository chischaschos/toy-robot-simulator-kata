module TRS
  class Robot
    # TODO: Validate f has valid values?, parser only checks command names not
    # arguments
    attr_accessor :x, :y, :f, :placed

    def initialize
      @placed = false
    end

    def do!(command)
      case

      when command.name == :place
        command.execute!(self)
        return

      when placed && command.name == :move
        x = @x
        y = @y

        case @f
        when :north
          y += 1
        when :south
          y -= 1
        when :east
          x += 1
        when :west
          x -= 1
        end

        if placement_within_bounds?(x, y)
          @x = x
          @y = y

          command.succeed!
          return
        end
      end

      command.fail!
    end

    private

    def placement_within_bounds?(x, y)
      x > -1 && x < 5 && y > -1 && y < 5
    end
  end
end
