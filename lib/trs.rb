module TRS
  autoload :CommandParser, 'trs/command_parser'
  autoload :Command,       'trs/command'
  autoload :RobotActions,  'trs/robot_actions'
  autoload :Robot,         'trs/robot'

  def self.input_command(commands_statement)
    robot = Robot.new

    commands = CommandParser.new.parse(commands_statement)

    commands.each do |command|
      puts "CMD: #{command.name} #{command.args}"
      robot.do!(command)
      puts command.output if command.output
    end
  end
end
