require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students_array = []
    students_array[1] = []
    students_array[2] = []

    html = open("./fixtures/student-site/index.html")
    doc = Nokogiri::HTML(html)
    # student_area = doc.css(".card-text-container h4")
    student_area = doc.css(".card-text-container")
     student_area.each do |x|
       students_name_hash = Hash.new
       students_location_hash = Hash.new
       students_name_hash[:name] = x.css("h4").text
       students_location_hash[:location] = x.css("p").text
       students_array[1] << students_name_hash
       students_array[2] << students_location_hash
     end
   students_array
   binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end
