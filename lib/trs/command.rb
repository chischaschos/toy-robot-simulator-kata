module TRS
  class Command
    attr_reader :name, :args
    attr_accessor :output

    def initialize(name: nil, args: nil, status: false)
      @name = name
      @args = args
      @status = status
    end

    def success?
      @status
    end

    def succeed!
      @status = true
    end
  end
end
