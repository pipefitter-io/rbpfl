# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
end

require "standard/rake"

task default: %i[test standard]

require 'rake'
require 'fileutils'

LICENSE_TEXT = <<~LICENSE
=begin
The MIT License (MIT)

Copyright (c) 2024 Brian Witte

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
=end
LICENSE

desc "Prepends the MIT license header to all .rb files in lib if not already present"
task :prepend_license do
  Dir.glob('lib/**/*.rb').each do |file|
    content = File.read(file)
    unless content.start_with?(LICENSE_TEXT)
      new_content = "#{LICENSE_TEXT}\n\n#{content}"
      File.open(file, 'w') { |f| f.write(new_content) }
      puts "Prepended license to #{file}"
    else
      puts "License already present in #{file}"
    end
  end
end
