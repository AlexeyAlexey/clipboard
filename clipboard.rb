#!/usr/local/bin/ruby
require 'rubygems'

require 'libdevinput' 
require "open3"
require 'httparty'
require 'nokogiri'
require 'launchy'



request = "http://www.lingvo-online.ru/ru/Translate/en-ru/"


dev = DevInput.new "/dev/input/event4" #keyboard "input" device   
dev.each do |event|   
  next unless event.type == 1 
  next unless event.value == 1

  if event.code == 54#right "shift" key       
  	Open3.popen3('xclip -o') do |stdin, stdout, stderr| 
      selected = /([a-zA-Z]*)('*)(-*)([a-zA-Z]*)/.match(stdout.read)[0]
      Launchy.open( "http://www.lingvo-online.ru/en/Translate/en-ru/" + selected ) unless selected == ""
      #response = HTTParty.get(request + selected)
  	end       
  end  
end   
  