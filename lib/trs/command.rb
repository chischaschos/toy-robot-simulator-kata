module TRS
  class Command
    attr_reader :name, :args, :output

    def initialize(name: nil, args: nil, status: false)
      @name = name
      @args = args
      @status = status
    end

    def success?
      @status
    end

    def fail!
      @status = false
    end

    def succeed!
      @status = true
    end

    def execute!(_robot)
      raise 'command not implemented'
    end

    private

    def placement_within_bounds?(x, y)
      x > -1 && x < 5 && y > -1 && y < 5
    end
  end
end
