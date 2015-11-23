module TRS
  autoload :CommandParser, 'trs/command_parser'
  autoload :Command,       'trs/command'
  autoload :Commands,      'trs/commands'
  autoload :Robot,         'trs/robot'

  def self.input_command(commands_statement)
    robot = Robot.new

    commands = CommandParser.new.parse(commands_statement)

    commands.map do |command|
      robot.do!(command)
      command.output
    end.compact.join
  end
end
