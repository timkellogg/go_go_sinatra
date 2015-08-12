#!/usr/bin/env ruby
require 'rubygems'
require 'fileutils'
require 'colorize'

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

puts "Creating basic project structure...".colorize :blue
Dir.mkdir('lib')
Dir.mkdir('spec')
Dir.mkdir('public')
Dir.chdir('public')
puts `touch main.css`
puts "done"

# puts 'What gems do you want installed?'.colorize :blue
# gems_to_install = gets.chomp
#
# gems_to_install.each do |gem|
#
# end
  # Ask what gems to use
  # Run bundle
# Create Directory Structure
