module TRS
  module RobotActions
    module Validations
      def placement_within_bounds?(x, y)
        x > -1 && x < 5 && y > -1 && y < 5
      end
    end

    class Place
      include Validations

      def execute!(command, robot)
        x = command.args[0].to_i
        y = command.args[1].to_i

        if placement_within_bounds?(x, y)
          robot.x = x
          robot.y = y
          robot.f = command.args[2].downcase.to_sym
          robot.placed = true

          command.succeed!
        end
      end
    end

    class Move
      include Validations

      def execute!(command, robot)
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

            command.succeed!
          end
        end
      end
    end

    class Report
      def execute!(command, robot)
        if robot.placed
          command.output = "Output: #{robot.x},#{robot.y},#{robot.f.to_s.upcase}"
          command.succeed!
        end
      end
    end

    class Left
      def execute!(command, robot)
        if robot.placed

          case robot.f
          when :north then robot.f = :west
          when :west then robot.f = :south
          when :south then robot.f = :east
          when :east then robot.f = :north
          end

          command.succeed!
        end
      end
    end

    class Right
      def execute!(command, robot)
        if robot.placed

          case robot.f
          when :north then robot.f = :east
          when :east then robot.f = :south
          when :south then robot.f = :west
          when :west then robot.f = :north
          end

          command.succeed!
        end
      end
    end
  end
end
