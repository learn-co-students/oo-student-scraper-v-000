require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.roster-cards-container").each do |student_info|
      students << {
        :name => student_info.css("h4.student-name").text,
        :location =>
        :profile_url =>
        binding.pry
      }
      end
    end


  end

  def self.scrape_profile_page(profile_url)

  end

end
