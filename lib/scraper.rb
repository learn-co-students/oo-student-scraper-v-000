require 'open-uri'
require 'pry'
require 'nokogiri'
class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index_page = Nokogiri::HTML(html)
    students = []
    index_page.css("div.roster-cards-container").each do |student_card|


    end
    index_page.css("p.student-location").each do |location|
      student_location = location.text
    end
    index_page.xpath("//div/a/@href").each do |path|
      profile_url = path.text
    end
      student = {
        :name => student_name,
        :location => student_location,
        :profile_url => profile_url
      }
      students << student
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
