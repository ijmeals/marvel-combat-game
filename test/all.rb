require "minitest/autorun"

files = Dir.glob('test/**/*.rb') 
files.each{|file| require_relative file.gsub(/^test\/|.rb$/,'')}  