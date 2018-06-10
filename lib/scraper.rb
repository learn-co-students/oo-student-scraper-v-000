require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open("./fixtures/student-site/index.html")
    doc = Nokogiri::HTML(html)
    student_index = []
    doc.css(".student-card").each do |student|
      student_index << {
      name: student.css(".student-name").text,
      location: student.css(".student-location").text,
      profile_url: student.css("a").attribute("href").value,
    }
    end
    student_index
  end

  def self.scrape_profile_page(profile_url)

  end

end
