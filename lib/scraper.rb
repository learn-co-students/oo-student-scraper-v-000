require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  # def self.get_page
  #   doc = Nokogiri::HTML(open("http://138.68.63.182:30002/fixtures/student-site/"))
  # end
  #
  # def self.get_students
  #   self.get_page.css(".student-card")
  # end

  def self.scrape_index_page(index_url)
    roster = Nokogiri::HTML(File.read(index_url))
    #   doc = Nokogiri::HTML(open("http://138.68.63.182:30002/fixtures/student-site/"))

    students = []

    roster.css(".student-card").each do |student|
      students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      # binding.pry
    end
    students
  end
  #=> array of hashes where each hash represents a student

  def self.scrape_profile_page(profile_url)

  end

end
