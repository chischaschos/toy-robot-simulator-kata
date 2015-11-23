module TRS
  class CommandParser
    def parse(commands_statement)
      valid_commands = /^REPORT|LEFT|RIGHT|MOVE|PLACE \d,\d,\w+$/

      commands_statement.split("\n").each_with_object([]) do |command, commands|
        clean_command = command.strip.chomp
        commands << build_command(clean_command) if clean_command =~ valid_commands
      end
    end

    def build_command(command_string)
      name, args = if command_string =~ /PLACE/
                     [:place, command_string[6..-1].split(',')]
                   else
                     command_string.downcase.to_sym
                   end

      command_class = Commands.const_get(name.capitalize.to_sym)
      command_class.new(args: args)
    end
  end
end
