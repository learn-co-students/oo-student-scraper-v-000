require_relative './config.rb'

def reload!
	load "./lib/command_line_interface.rb"
	load "./lib/scraper.rb"
	load "./lib/student.rb"
end


desc 'A console'
task :console do
	puts "starting console, hang on!"
	Pry.start	
end