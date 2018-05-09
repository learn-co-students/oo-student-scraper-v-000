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
        :name => student_card.css("h4.student-name")[0].text,
        :location => student_card.css("p.student-location")[0].text,
        :profile_url => student_card.css("h3.view-profile-text")[0].text
      }
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)

    
  end

end

