module TRS
  class Command
    attr_reader :name, :args

    def initialize(name:, args: nil, status: false)
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
  end
end
