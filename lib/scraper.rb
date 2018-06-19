require 'open-uri'
require 'pry'
#name = doc.css(".student-card").css("h4").text
#location = doc.css(".student-card").css("p").text
class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = {}
    students_array = []
    doc.css(".student-card").each do|student|
     students = {
      :name => student.css("h4").text,
      :location => student.css("p").text,
   
     }
       
    end
    students_array << students
    students_array
    binding.pry
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

