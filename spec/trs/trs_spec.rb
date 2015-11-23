require 'spec_helper'

describe TRS do
  describe '#input_command' do
    it 'issues PLACE, MOVE and REPORT to the robot' do
      commands_statement = "PLACE 0,0,NORTH\n" \
        "MOVE\n" \
        "REPORT\n"

      output = subject.input_command(commands_statement)

      expect(output).to eq('Output: 0,1,NORTH')
    end

    it 'issues PLACE, LEFT and REPORT to the robot' do
      commands_statement = "PLACE 0,0,NORTH\n" \
        "LEFT\n" \
        "REPORT\n"

      output = subject.input_command(commands_statement)

      expect(output).to eq('Output: 0,0,WEST')
    end

    it 'issues PLACE, MOVE, MOVE, LEFT, MOVE, and REPORT to the robot' do
      commands_statement = "PLACE 1,2,EAST\n" \
        "MOVE\n" \
        "MOVE\n" \
        "LEFT\n" \
        "MOVE\n" \
        "REPORT\n"

      output = subject.input_command(commands_statement)

      expect(output).to eq('Output: 3,3,NORTH')
    end
  end
end
