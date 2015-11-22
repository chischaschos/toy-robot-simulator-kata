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
      xit 'accepts multiple commands at once'

      xit 'accepts consecutive commands'
    end

  end
end
