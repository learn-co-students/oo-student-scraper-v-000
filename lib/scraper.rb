require 'open-uri'
require 'pry'
require 'nokogiri'
class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('fixtures/student-site/index.html')
    doc = Nokogiri::HTML(html)
    students = {}

    doc.css("div.student-card").each do |student|
      name = student.css("div.card-text-container h4.student-name").text
      students[name.to_sym] = {
        :name => student.css("div.card-text-container h4.student-name").text,
        :location => student.css("div.card-text-container p.student-location").text,
        :profile_url => student.css("a")
      }
    #responsible for scraping the index page that lists all of the students and the
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    #responsible for scraping an individual student's profile page to get further information about that student
  end

end
# binding.pry
# self.scrape_index_page(index_url)
