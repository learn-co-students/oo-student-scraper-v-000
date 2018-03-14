require_relative './config/environment'

def reload!
  load './lib/command_line_interface.rb'
  load './lib/scraper.rb'
  load './lib/student.rb'
  load './fixtures/student-site/index.html'
end

desc "A console"
task  :console do
  pry.start
end
