require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students_array = []
    students_hash = {}
    html = open("./fixtures/student-site/index.html")
    doc = Nokogiri::HTML(html)
    student_area = doc.css(".card-text-container h4")
     student_area.each do |x|
       binding.pry
       students_hash["name"] = x.child.text
       students_array << students_hash
     end
  students_array
  end

  def self.scrape_profile_page(profile_url)

  end

end
