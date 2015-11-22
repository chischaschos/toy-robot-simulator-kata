require 'spec_helper'

describe TRS::Robot do
  it "knows when it hasn't been placed yet" do
    expect(subject).not_to be_placed
  end

  context 'when it has not been placed yet' do
    it 'returns the received command as failed' do
      dummy_command = TRS::Command.new(name: :dummy, status: true)

      subject.do!(dummy_command)

      expect(dummy_command).not_to be_success
    end

    it 'discards non PLACE commands' do
      %i{left right move report}.each do |command_name|
        command = TRS::Command.new(name: command_name)

        subject.do!(command)

        expect(command).not_to be_success
      end
    end

    it 'only accepts PLACE commands' do
      command = TRS::Command.new(name: :place, args: %w{0 0 NORTH})

      subject.do!(command)

      expect(command).to be_success
      expect(subject.x).to eq(0)
      expect(subject.y).to eq(0)
      expect(subject.f).to eq(:north)
    end
  end

end
