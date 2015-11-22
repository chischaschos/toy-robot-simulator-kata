class TRS

  def parse_commands(commands_statement)
    valid_commands = %r(^REPORT|LEFT|RIGHT|MOVE|PLACE \d,\d,\w+$)

    commands_statement.split("\n").each_with_object([]) do |command, commands|
      clean_command = command.strip.chomp
      commands << clean_command if clean_command =~ valid_commands
    end
  end

  def input_command(command_statement)
    #commands = parse_commands
    #commands.each do |command|
    #
    #end
      'Output: 0,0,NORTH'
  end

  def execute_command(command)
    CommandResult.new(status: false)
  end

end

class CommandResult

  def initialize(status: false, output: nil)
    @status = status
  end

  def success?
    @status
  end
end
