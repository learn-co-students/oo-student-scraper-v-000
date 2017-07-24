require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url
  @@scraped_students = []

  def self.scrape_index_page(index_url)
    html = File.read('fixtures/student-site/index.html')
    doc = Nokogiri::HTML(html)
    doc.css("student-card.card-text-container").each do |card|
      student = card.css("h4").text
      @@scraped_students[student.to_sym] = [
            :name => card.css("h4").text,
            :location => card.css("p").text
          ]
    end
    @@scraped_students
  end

  def self.scrape_profile_page(profile_url)

  end

end
