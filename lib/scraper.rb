require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_site = Nokogiri::HTML(open(index_url))
    student_info = []
    
    # binding.pry

    
    student_site.css(".student-card").each do |student|
      i = 0
      student_hash = {
        :name => student.css(".card-text-container").css(".student-name").text,
        :location => student.css(".card-text-container").css(".student-location").text,
        :profile_url => student.css("a")[i]["href"]
      }
      student_info << student_hash
      i += 1
    end
    student_info


  end

  def self.scrape_profile_page(profile_url)
    
  end

end

