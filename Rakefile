require_relative './config/environment'

def reload!
  load_all './lib'
end

task :console do
  Pry.start
end

task :scrape_student do
  new_student = Scraper.new(fixtures/student-site/index.html)
  new_student.scrape_from_index("./fixtures/student-site/students/joe-burgess.html")
end
