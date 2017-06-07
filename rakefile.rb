require_relative './config/environment'

puts "scraping"

def reload!
  load  './lib/student.rb'
  load  './lib/scraper.rb'
  load  './lib/command_line_interface.rb'
end

desc "A console"
task :console do
  Pry.start
end
