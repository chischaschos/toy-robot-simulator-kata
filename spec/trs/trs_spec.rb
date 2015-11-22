require 'spec_helper'
require 'trs'

describe TRS do

  describe '#parse_commands' do
    it 'discards invalid commands' do
      commands_statement = "DO_SOME \n" \
        "STUFF\n"

      commands = subject.parse_commands(commands_statement)

      expect(commands).to be_empty
    end

    it 'only removes invalid commands' do
      commands_statement = "DO_SOME \n" \
        "REPORT\n" \
        "LEFT\n" \
        "RIGHT\n" \
        "JUMP\n" \
        "MOVE\n" \
        "PLACES\n" \
        "PLACE\n" \
        "PLACE 0,0,NORTH\n"

      commands = subject.parse_commands(commands_statement)

      expect(commands).to eq(['REPORT', 'LEFT', 'RIGHT', 'MOVE', 'PLACE 0,0,NORTH'])
    end
  end

  describe '#input_command' do
    context 'when issuing a valid placement' do
      it 'PLACEs a robot' do
        commands_statement = "PLACE 0,0,NORTH\n" \
          "REPORT\n"

        output = subject.input_command(commands_statement)

        expect(output).to eq('Output: 0,0,NORTH')
      end
    end
  end

  describe '#execute_command' do
    context "when there isn't a robot placed" do
      it 'discards commands' do
        %w{LEFT RIGHT MOVE REPORT}.each do |command|
          command_result = subject.execute_command(command)

          expect(command_result).not_to be_success
        end
      end

      xit 'accepts placements' do
        command_result = subject.execute_command('PLACE 0,0,NORTH')

        expect(command_result).to be_success
      end
    end

  end
end
