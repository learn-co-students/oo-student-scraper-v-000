require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    student_card = doc.css(".student-card")

    student_card.each do |student|
      students << {:name => "#{student.css(".student-name").text}",
      :location => "#{student.css(".student-location").text}",
      :profile_url => "#{student.css("a").first['href']}"}
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
