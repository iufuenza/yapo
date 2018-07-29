require 'yapo/commands/exec'

RSpec.describe Yapo::Commands::Exec do
  it "executes `exec` command successfully" do
    output = StringIO.new
    command = Yapo::Commands::Exec.new('testing_command', {})
    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end

  it "handles validation error if version does not match" do
    stub_const("Yapo::VERSION", "0.0.0")
    output = StringIO.new
    command = Yapo::Commands::Exec.new('testing_command', {})
    command.execute(output: output)

    expect(output.string).to eq("ERROR:ValidationError\n")
  end

  it "handles validation error if command does not exists" do
    output = StringIO.new
    command = Yapo::Commands::Exec.new('some_unexisting_command', {})
    command.execute(output: output)

    expect(output.string).to eq("ERROR:ValidationError\n")
  end

  it "executes `exec` command with prepend successfully" do
    output = StringIO.new
    command = Yapo::Commands::Exec.new('testing_command', { prepend: 'testing_prepend' })
    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end

  it "handles syntax error if prepend command does not exists" do
    output = StringIO.new
    command = Yapo::Commands::Exec.new('testing_command', { prepend: 'some_unexisting_prepend_command' })
    command.execute(output: output)

    expect(output.string).to eq("ERROR:SyntaxError\n")
  end

  it "handles syntax error if command name is present but empty, in .yapo.yml" do
    output = StringIO.new
    command = Yapo::Commands::Exec.new('empty_testing_command', {})
    command.execute(output: output)

    expect(output.string).to eq("ERROR:CommandError\n")
  end

  it "handles command error if command is incomplete" do
    output = StringIO.new
    command = Yapo::Commands::Exec.new('incomplete_bash_command', {})
    command.execute(output: output)

    expect(output.string).to eq("ERROR:CommandError\n")
  end

  it "handles command error if command is invalid" do
    output = StringIO.new
    command = Yapo::Commands::Exec.new('invalid_bash_command', {})
    command.execute(output: output)

    expect(output.string).to eq("ERROR:CommandError\n")
  end
end
