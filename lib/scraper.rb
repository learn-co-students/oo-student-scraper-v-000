require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    students = []
    #  html = File.read('fixtures/student-site/index.html')
     doc = Nokogiri::HTML(html)
     doc.css("div.roster-cards-container").each do |student_card|
       student_card.css(".student-card a").each do |student|
         name = student.css(".student-name").text
         location = student.css(".student-location").text
         profile_url = student.attr("href")
         students << {name: name, location: location, profile_url: profile_url}
       end
     end
     students
   end


  def self.scrape_profile_page(profile_url)
student = {}
  end

end
