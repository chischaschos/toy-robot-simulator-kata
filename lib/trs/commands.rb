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

      private

      def placement_within_bounds?(x, y)
        x > -1 && x < 5 && y > -1 && y < 5
      end
    end
  end
end
