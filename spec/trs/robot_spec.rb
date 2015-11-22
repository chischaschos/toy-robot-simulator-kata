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
    it { expect(subject.placed).to be_falsy }

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

    it 'can only be placed with a PLACE command' do
      command = TRS::Command.new(name: :place, args: %w{0 0 NORTH})

      subject.do!(command)

      expect(command).to be_success
      expect(subject.x).to eq(0)
      expect(subject.y).to eq(0)
      expect(subject.f).to eq(:north)
      expect(subject.placed).to be_truthy
    end
  end

  context 'when it is already placed' do
    context 'when the MOVE command is issued' do
      context 'when the resulting position is within bounds' do
        it 'moves north' do
          command = TRS::Command.new(name: :place, args: %w{0 0 NORTH})
          subject.do!(command)
          command = TRS::Command.new(name: :move)

          subject.do!(command)

          expect(command).to be_success
          expect(subject.x).to eq(0)
          expect(subject.y).to eq(1)
        end

        it 'moves south' do
          command = TRS::Command.new(name: :place, args: %w{1 1 SOUTH})
          subject.do!(command)
          command = TRS::Command.new(name: :move)

          subject.do!(command)

          expect(command).to be_success
          expect(subject.x).to eq(1)
          expect(subject.y).to eq(0)
        end

        it 'moves east' do
          command = TRS::Command.new(name: :place, args: %w{1 1 EAST})
          subject.do!(command)
          command = TRS::Command.new(name: :move)

          subject.do!(command)

          expect(command).to be_success
          expect(subject.x).to eq(2)
          expect(subject.y).to eq(1)
        end

        it 'moves west' do
          command = TRS::Command.new(name: :place, args: %w{1 1 WEST})
          subject.do!(command)
          command = TRS::Command.new(name: :move)

          subject.do!(command)

          expect(command).to be_success
          expect(subject.x).to eq(0)
          expect(subject.y).to eq(1)
        end
      end

      context 'when the resulting position is out of bounds' do
        it 'does not move north' do
          command = TRS::Command.new(name: :place, args: %w{0 4 NORTH})
          subject.do!(command)
          expect(command).to be_success
          command = TRS::Command.new(name: :move)

          subject.do!(command)

          expect(command).not_to be_success
          expect(subject.x).to eq(0)
          expect(subject.y).to eq(4)
        end

        it 'does not move south' do
          command = TRS::Command.new(name: :place, args: %w{0 0 SOUTH})
          subject.do!(command)
          command = TRS::Command.new(name: :move)

          subject.do!(command)

          expect(command).not_to be_success
          expect(subject.x).to eq(0)
          expect(subject.y).to eq(0)
        end

        it 'does not move east' do
          command = TRS::Command.new(name: :place, args: %w{4 0 EAST})
          subject.do!(command)
          command = TRS::Command.new(name: :move)

          subject.do!(command)

          expect(command).not_to be_success
          expect(subject.x).to eq(4)
          expect(subject.y).to eq(0)
        end

        it 'does not move west' do
          command = TRS::Command.new(name: :place, args: %w{0 0 WEST})
          subject.do!(command)
          command = TRS::Command.new(name: :move)

          subject.do!(command)

          expect(command).not_to be_success
          expect(subject.x).to eq(0)
          expect(subject.y).to eq(0)
        end
      end
    end

    context 'when the REPORT command is issued' do
      xit 'returns its X,Y and orientation'
    end
  end
end
