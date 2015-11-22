require 'spec_helper'

describe TRS::Robot do
  it 'never allows out of bounds placements' do
    invalid_args = [
      %w{-1  0}, %w{ 0 -1}, %w{-1 -1},
      %w{4 5}, %w{5 4}, %w{5 5},
    ]
    invalid_args.each do |invalid_arg|
      args = invalid_arg << ' NORTH'
      command = TRS::Command.new(name: :place, args: args)

      subject.do!(command)

      expect(command).not_to be_success
    end
  end

  context 'when it has not been placed yet' do
    it { is_expected.not_to be_placed }

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
