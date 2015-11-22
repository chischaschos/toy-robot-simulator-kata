module TRS
  autoload :CommandParser, 'trs/command_parser'
  autoload :Command,       'trs/command'
  autoload :Robot,         'trs/robot'

  def self.parse_commands(commands_statement)
    CommandParser.new.parse(commands_statement)
  end

  def self.input_command(command_statement)
    #commands = parse_commands
    #commands.each do |command|
    #
    #end
    'Output: 0,0,NORTH'
  end

  def self.execute_command(command)
    robot = Robot.new
    robot.do!(command)
    command
  end

end


