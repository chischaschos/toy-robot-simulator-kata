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

    expect(commands[0]).to be_a(TRS::Commands::Report)
    expect(commands[1]).to be_a(TRS::Commands::Left)
    expect(commands[2]).to be_a(TRS::Commands::Right)
    expect(commands[3]).to be_a(TRS::Commands::Move)

    place_command = commands[4]
    expect(place_command.name).to eq(:place)
    expect(place_command.args).to eq(%w{0 0 NORTH})
  end
end
