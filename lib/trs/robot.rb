module TRS
  class Robot
    attr_accessor :x, :y, :f, :placed

    def initialize
      @placed = false
    end

    def do!(command)
      if actions[command.name]
        actions[command.name].new.execute!(command, self)
      end
    end

    def actions
      {
        left:   RobotActions::Left,
        move:   RobotActions::Move,
        place:  RobotActions::Place,
        report: RobotActions::Report,
        right:  RobotActions::Right,
      }
    end
  end
end
