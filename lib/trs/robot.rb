module TRS
  class Robot
    attr_reader :x, :y, :f

    def initialize
      @placed = false
    end

    def do!(command)
      if command.name == :place
        x = command.args[0].to_i
        y = command.args[1].to_i

        if placement_within_bounds?(x, y)
          @x = x
          @y = y
          @f = command.args[2].downcase.to_sym

          command.succeed!
          return
        end
      end

      command.fail!
    end

    def placed?
      @placed
    end

    private

    def placement_within_bounds?(x, y)
      x > -1 && x < 5 && y > -1 && y < 5
    end
  end
end
