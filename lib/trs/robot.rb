module TRS
  class Robot
    # TODO: Validate f has valid values?, parser only checks command names not
    # arguments
    attr_accessor :x, :y, :f, :placed

    def initialize
      @placed = false
    end

    def do!(command)
      command.execute!(self)
    end
  end
end
