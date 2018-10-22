require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = index_url
    students = []
    doc = Nokogiri::HTML(open(html))
    doc.css("div.student-card").each do|student|
    name = student.css(".student-name").text
    location = student.css(".student-location").text
    profile_url = student.css("a").attribute("href").value

    student_info = {
      :name => name,
      :location => location,
      :profile_url => profile_url
    }
    students << student_info
    end
    students
# binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end
