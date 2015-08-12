#!/usr/bin/env ruby

require 'rubygems'
require 'fileutils'
require 'colorize'

puts `brew install tree`
puts 'What are the names of the contributers?'
author_names = gets.chomp

puts "This utility puts the file on the desktop by default\n".colorize :blue
puts "Enter your current username".colorize :blue
username = gets.chomp
Dir.chdir "/Users/#{username}/Desktop"

puts "What do you want to call the project?"
dirname = gets.chomp
Dir.mkdir(dirname) unless File.exists?(dirname)
Dir.chdir(dirname)

puts "What gems would you like installed? Please put space between gems like 'sinatra capybara rspec'"
gems_to_install = gets.chomp

File.open('Gemfile', "w") do |file|
  file.write("source('https://rubygems.org')\n\n")
  gems_to_install.split(' ').each do |gem|
    file.write("gem('#{gem}')\n")
  end
end

puts `bundle install`

Dir.mkdir('lib')
Dir.mkdir('spec')
Dir.mkdir('views')
Dir.chdir('views')
File.open('layout.erb', 'w') do |file|
  file.write("<html>\n")
  file.write("\t<head>\n")
  file.write("\t\t<title>#{dirname}</title>\n")
  file.write("\t\t<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css'>\n")
  file.write("\t\t<link rel='stylesheet' href='main.css'>\n")
  file.write("\t</head>\n")
  file.write("\t<body>\n")
  file.write("\t\t<div class='container'>\n")
  file.write("\t\t\t<%= yield %>\n")
  file.write("\t\t</div>\n")
  file.write("\t</body>\n")
  file.write("</html>")
end

puts `touch index.erb`
Dir.chdir('..')
Dir.mkdir('public')
Dir.chdir('public')
puts `touch main.css`
Dir.chdir('..')

File.open('app.rb', "w") do |file|
  file.write("require('sinatra')\n\n")
  file.write("get('/') do\n")
  file.write("erb(:index)\n")
  file.write("end\n")
end

File.open('README.md', "w") do |file|
  file.write("# #{dirname}")
  file.write("## Contributors: ")
  author_names.split(' ').each do |author|
    file.write("* #{author}\n")
  end
  file.write("## Setup\n\n")
  file.write("* Download the Repo\n")
  file.write("* `cd` into the Directory\n")
  file.write("* `ruby app.rb` to start the server\n")
  file.write("* `rspec` to test\n\n")
  file.write("### Technologies Used\n")
  file.write(" (Add information here)\n")
  file.write("### Legal\n")
  file.write("Copyright (c) 2015 **_{List of contribtors}_**\n\n")
  file.write("This software is licensed under the MIT license.\n\n")
  file.write("Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n\n")
end

puts "Gemfile\n".colorize :blue
puts `cat Gemfile`

puts "Layout.erb\n".colorize :blue
puts `cat views/layout.erb`

puts "README.md\n".colorize :blue
puts `cat README.md`

puts "Full directory structure\n".colorize :blue
puts `tree`

puts "done".colorize :green

puts 'launching atom...'.colorize :blue
puts `atom .`
