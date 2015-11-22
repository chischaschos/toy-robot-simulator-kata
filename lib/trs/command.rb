module TRS
  class Command
    attr_reader :name, :args

    def initialize(name: name, args: nil, status: false, output: nil)
      @name = name
      @args = args
      @status = status
    end

    def success?
      @status
    end
  end
end