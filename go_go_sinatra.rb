#!/usr/bin/env ruby

# Used to install dependencies first
puts `gem install colorize`
puts `brew install tree`

require 'rubygems'
require 'fileutils'
require 'colorize'

puts 'What are the names of the contributers?'
author_names = gets.chomp
username     = `whoami`.chomp
Dir.chdir "/Users/#{username}/Desktop"

puts "What do you want to call the project?"
dirname = gets.chomp
Dir.mkdir(dirname) unless File.exists?(dirname)
Dir.chdir(dirname)

puts "What gems would you like installed? Please put space between gems like 'sinatra capybara rspec'"
puts "[sinatra is installed by default]"
gems_to_install = gets.chomp

File.open('Gemfile', "w") do |file|
  file.write("source 'https://rubygems.org'\n\n")
  file.write("gem 'sinatra' ")
  gems_to_install.split(' ').each do |gem|
    file.write("gem '#{gem}'\n\n")
  end
end

puts `bundle install`

Dir.mkdir('lib')
Dir.mkdir('spec')
Dir.mkdir('views')
Dir.chdir('views')
File.open('layout.erb', 'w') do |file|
  file.write("<html>\n")
  file.write("\t<head lang='en'>\n")
  file.write("\t\t<title>#{dirname}</title>\n")
  file.write("\t\t<link rel='stylesheet' type='text/css' href='http://cdn.foundation5.zurb.com/foundation.css'>\n")
  file.write("\t\t<script src='//code.jquery.com/jquery-1.11.3.min.js'></script>\n")
  file.write("\t\t<script src='http://cdn.foundation5.zurb.com/foundation.js'></script>\n")
  file.write("\t\t<link rel='stylesheet' type='text/css' href=\"<%= url('/main.css') %>\">\n")
  file.write("\t</head>\n")
  file.write("\t<body>\n")
  file.write("\t\t<div id='site-wrapper' class='container'>\n")
  file.write("\t\t\t<%= yield %>\n")
  file.write("\t\t</div>\n")
  file.write("\t\t<script>\n\t\t\t$(document).foundation();\n\t\t</script>\n")
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
  file.write("require 'sinatra' \n\n")
  file.write("get '/'  do\n")
  file.write("\terb(:index)\n")
  file.write("end\n")
end

File.open('README.md', "w") do |file|
  file.write("#\t#{dirname}\n")
  file.write("##\tContributors:\n")
  author_names.split(' ').each do |author|
    file.write("* #{author}\n")
  end
  file.write("##\tSetup\n\n")
  file.write("* Download the Repo\n")
  file.write("* `cd` into the Directory\n")
  file.write("* `ruby app.rb` to start the server\n")
  file.write("* `rspec` to test\n\n")
  file.write("###\tTechnologies Used\n")
  file.write(" (Add information here)\n")
  file.write("###\tLegal\n")
  file.write("Copyright (c) 2015 **_#{author_names}_**\n\n")
  file.write("This software is licensed under the MIT license.\n\n")
  file.write("Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n\n")
end

puts "Initialize git repository y/n?"
install_git = gets.chomp

if install_git.downcase == 'y' || install_git.downcase == 'yes'
  puts `git init`
  puts `git add .`
  puts `git commit -m "first commit with help from gosinatra (https://github.com/timkellogg/go_go_sinatra)"`
end

puts "Gemfile\n".underline.colorize :blue
puts `cat Gemfile`

puts "Layout.erb\n".underline.colorize :blue
puts `cat views/layout.erb`

puts "README.md\n".underline.colorize :blue
puts `cat README.md`

puts "Full directory structure\n".underline.colorize :blue
puts `tree`

puts "Done!".colorize :green

puts 'Launching atom...'.colorize :blue
puts `atom .`
