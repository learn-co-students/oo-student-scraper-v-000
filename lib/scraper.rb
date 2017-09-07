require 'open-uri'
require "nokogiri"
require 'pry'

class Scraper
  @@students = []
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
  
    doc.css(".student-card").each do |student|
    # binding.pry
    index_student = {
      name: student.css(".student-name").text,
      location: student.css(".student-location").text,
      profile_url: student.at("a")["href"]
     }
     @@students << index_student
    end
    @@students
  end

  def self.scrape_profile_page(profile_url)
    # binding.pry
    doc = Nokogiri::HTML(open(profile_url))
    doc.css(".social-icon-container").each do |student|
      binding.pry
      student_profile = {
          twitter: student.at("a")["href"],
          :linkedin=>"https://www.linkedin.com/in/jmburges",
          :github=>"https://github.com/jmburges",
          :blog=>"http://joemburgess.com/",
          :profile_quote=>"\"Reduce to a previously solved problem\"",
          :bio=>
      "I grew up outside of the Washington DC (NoVA!) and went to college at Carnegie Mellon University in Pittsburgh. After college, I worked as an Oracle consultant for IBM for a bit and now I teach here at The Flatiron School."
      }
     
      student
    end
#     {:twitter=>"https://twitter.com/jmburges",
#     :linkedin=>"https://www.linkedin.com/in/jmburges",
#     :github=>"https://github.com/jmburges",
#     :blog=>"http://joemburgess.com/",
#     :profile_quote=>"\"Reduce to a previously solved problem\"",
#     :bio=>
# "I grew up outside of the Washington DC (NoVA!) and went to college at Carnegie Mellon University in Pittsburgh. After college, I worked as an Oracle consultant for IBM for a bit and now I teach here at The Flatiron School."}}

  end

end


#  Scraper.scrape_index_page("./fixtures/student-site/index.html")
# Scraper.scrape_profile_page(profile_url)