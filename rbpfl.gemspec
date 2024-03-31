# frozen_string_literal: true

require_relative "lib/rbpfl/version"

Gem::Specification.new do |spec|
  spec.name = "rbpfl"
  spec.version = Rbpfl::VERSION
  spec.authors = ["Brian Witte"]
  spec.email = ["brianwitte@mailfence.com"]

  spec.summary = "Ruby Pipe & Filter Library"
  spec.description = "A library for pipe & filter patterns with Pipes, Stages, contract handling & validation, and more... for Ruby applications."
  spec.homepage = "https://example.com/rbpfl"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # Specify your gem's dependencies in rbpfl.gemspec
  spec.add_dependency "async", "~> 2.10", ">= 2.10.1"
  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
