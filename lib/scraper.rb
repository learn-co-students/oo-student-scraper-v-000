require 'open-uri'
require 'pry'
#name = doc.css(".student-card").css("h4").text
#location = doc.css(".student-card").css("p").text
class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    doc = Nokogiri::HTML(html)
    students = {}
    students_a = []
    
    doc.css("div .student-card").collect do |student|
     students = {
      :name => student.css("h4").text,
      :location => student.css("p").text,
      }
    #  binding.pry
    end
    
    students_a << students
    students_a
   #binding.pry
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

