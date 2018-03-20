require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    scraped_students = []
    student_profile = doc.css(".student-card")
    # binding.pry
    student_profile.each do |student|
      student = {
      :name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("a").attribute('href').to_s
    }
      scraped_students << student
    end
    scraped_students
    # binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end
