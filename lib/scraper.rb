require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('./fixtures/student-site/index.html')
    student_scraper = Nokogiri::HTML(html)

    scraped_students = []

    student_scraper.css().each do |student|
      name = student.css().text
      scraped_students[name.to_sym] = {}
    end


  end

  def self.scrape_profile_page(profile_url)

  end

end
