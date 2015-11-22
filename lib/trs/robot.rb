module TRS
  class Robot
    attr_reader :x, :y, :f

    def initialize
      @placed = false
    end

    def do!(command)
      if command.name == :place
        @x = command.args[0].to_i
        @y = command.args[1].to_i
        @f = command.args[2].downcase.to_sym

        command.succeed!
      else
        command.fail!
      end
    end

    def placed?
      @placed
    end
  end
end
