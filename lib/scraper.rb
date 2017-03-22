require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_list = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card")
    # binding.pry
    students.each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a").attribute("href").value
      student_list << {:name => name, :location => location, :profile_url => profile_url}
    end
    student_list
  end

  def self.scrape_profile_page(profile_url)

  end

end

# :name
# student.css(".student-name").text
# :location
# student.css(".student-location").text
# :profile_url
# students.css("a").attribute("href").value
