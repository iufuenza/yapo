# Yapo

This gem is used for building powerful command-line interfaces. 
It can also be used for simplifying the integration and daily usage of any third party CLIs.

You will be able to run bash scripts in your project by creating your custom, and easy to memorize, commands. That way, you won't need to remember some confusing instructions, or third party commands, to run and contribute to a project that you are working on. 

Using Yapo, you will reduce the setup time in any project that needs a big set of instructions to start up the project.

Please review the list of [examples](#examples), and feel free to use them.

## Installation

Run this in your terminal to install the gem globally in your machine:
```console
$ gem install yapo
```

## Usage

Add a .yapo.yml file in the root of your project, and fill it with whatever command you want to create. File example:
```yaml
version: '0.1.0'
# OPTIONAL
build: &build
  - "echo Building Hello World!"
  - "docker build ." # whatever build command you use
run: &run
  - "echo Running Hello World!"
test: &test
  - "rspec" # whatever test command you use
# REQUIRED
commands:
  build:
    - *build
  run:
    - *run
  test:
    - *build
    - *test
```

If you have the gem installed, then you can run your custom commands as follows:

```console
yapo exec build
# Will run: echo 'Building Hello World!' && docker build .'
yapo exec run
# Will run: echo 'echo Running Hello World!'
yapo exec test
# Will run: rspec
```

If you want to prepend a command to another custom command, you can add '-p' flag with the name of the prepend command. For example:

```ruby
yapo exec custom_command_for_build -p docker
# Will run: 'docker-compose run web some bash script 1' && docker-compose run web echo 'some bash script 2'
```

## Examples

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/iufuenza/yapo.
