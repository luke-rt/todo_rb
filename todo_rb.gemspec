# frozen_string_literal: true

require_relative "lib/todo_rb/version"

Gem::Specification.new do |spec|
  spec.name = "todo_rb"
  spec.version = TodoRb::VERSION
  spec.authors = ["luke-rt"]
  spec.email = ["luke.rtong@gmail.com"]

  spec.summary = "Simple Todo app"
  spec.description = "Todo app written in Ruby using CSV"
  spec.homepage = "https://github.com/luke-rt/todo_rb"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "bin"
  spec.executables = ["todo"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "standard"
end
