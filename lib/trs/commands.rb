module TRS
  module Commands
    class Place < Command
      def initialize(args)
        super(name: :place, args: args)
      end

      def execute!(robot)
        x = args[0].to_i
        y = args[1].to_i

        if placement_within_bounds?(x, y)
          robot.x = x
          robot.y = y
          robot.f = args[2].downcase.to_sym
          robot.placed = true

          succeed!
        end
      end
    end

    class Move < Command
      def initialize
        super(name: :move)
      end

      def execute!(robot)
        if robot.placed
          x = robot.x
          y = robot.y

          case robot.f
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
            robot.x = x
            robot.y = y

            succeed!
          end
        end
      end
    end
  end
end
