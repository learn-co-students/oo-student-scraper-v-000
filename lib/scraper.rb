require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    page = Nokogiri::HTML(html)
    students = []
    page.css("div.roster-cards-container").each do |student_card|
    binding.pry
      student = {
        :name => student_card.css("div.student-name"),
        :location => student_card.css("p.student-location"),
        :profile_url => student_card.css("div.view-profile-div"),
      }
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)

    
  end

end

