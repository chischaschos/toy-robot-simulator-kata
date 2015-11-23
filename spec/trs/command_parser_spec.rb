require 'spec_helper'

describe TRS::CommandParser do
  it 'discards invalid commands' do
    commands_statement = "DO_SOME \n" \
      "STUFF\n"

    commands = subject.parse(commands_statement)

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

    commands = subject.parse(commands_statement)

    expect(commands.first).to be_a(TRS::Command)
    expect(commands[0].name).to eq(:report)
    expect(commands[1].name).to eq(:left)
    expect(commands[2].name).to eq(:right)
    expect(commands[3].name).to eq(:move)

    place_command = commands[4]
    expect(place_command.name).to eq(:place)
    expect(place_command.args).to eq(%w{0 0 NORTH})
  end
end
