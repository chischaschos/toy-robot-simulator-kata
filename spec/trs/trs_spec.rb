require 'spec_helper'

describe TRS do

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
        command = subject.execute_command('PLACE 0,0,NORTH')

        expect(command).to be_success
      end
    end

  end
end
