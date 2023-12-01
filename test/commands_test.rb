require "test_helper"
require "json"

class CommandsTest < ActiveSupport::TestCase
  include ActiveSupport::Testing::Isolation

  test "json command prints JSON with imports" do
    out, err = run_command("json")
    assert_includes JSON.parse(out), "imports"
  end

  private
    def run_command(command, *args)
      original_argv = ARGV.dup
      ARGV.replace([command, *args])

      Dir.chdir("#{__dir__}/dummy") do
        capture_io { load "importmap/commands.rb" }
      end
    ensure
      ARGV.replace(original_argv)
    end
end
