#!/usr/bin/env ruby
require 'rubygems'
require 'fileutils'
require 'colorize'

puts `brew install tree`

puts "This utility puts the file on the desktop by default".colorize :blue
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
  file.write()
end

puts 'Your directory structure:'
puts `tree`

puts "done".colorize :green
