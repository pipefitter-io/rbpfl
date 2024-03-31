require "minitest/autorun"
require "minitest/reporters"
require "rbpfl"
require "json"
require "fileutils"
require "pry-byebug"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
