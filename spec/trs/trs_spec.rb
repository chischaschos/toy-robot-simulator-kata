require 'spec_helper'

describe TRS do
  describe '#input_command' do
    it 'issues PLACE, MOVE and REPORT to the robot' do
      commands_statement = "PLACE 0,0,NORTH\n" \
        "MOVE\n" \
        "REPORT\n"
      output = "CMD: place [\"0\", \"0\", \"NORTH\"]\n" \
        "CMD: move \n" \
        "CMD: report \n" \
        "Output: 0,1,NORTH\n"

      expect do
        subject.input_command(commands_statement)
      end.to output(output).to_stdout
    end

    it 'issues PLACE, LEFT and REPORT to the robot' do
      commands_statement = "PLACE 0,0,NORTH\n" \
        "LEFT\n" \
        "REPORT\n"

      output = "CMD: place [\"0\", \"0\", \"NORTH\"]\n" \
        "CMD: left \n" \
        "CMD: report \n" \
        "Output: 0,0,WEST\n"

      expect do
        subject.input_command(commands_statement)
      end.to output(output).to_stdout
    end

    it 'issues PLACE, MOVE, MOVE, LEFT, MOVE, and REPORT to the robot' do
      commands_statement = "PLACE 1,2,EAST\n" \
        "MOVE\n" \
        "MOVE\n" \
        "LEFT\n" \
        "MOVE\n" \
        "REPORT\n"

      output = "CMD: place [\"1\", \"2\", \"EAST\"]\n" \
        "CMD: move \n" \
        "CMD: move \n" \
        "CMD: left \n" \
        "CMD: move \n" \
        "CMD: report \n" \
        "Output: 3,3,NORTH\n"

      expect do
        subject.input_command(commands_statement)
      end.to output(output).to_stdout
    end
  end
end
