require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card")
    s = []
    students.each do |student|
      s << {:name => student.css(".card-text-container .student-name").text ,:location => student.css(".card-text-container .student-location").text,:profile_url => "./fixtures/student-site/"+student.css("a").first.attributes["href"].value}
    end
    s
  end

  def self.scrape_profile_page(profile_url)

  end

end
