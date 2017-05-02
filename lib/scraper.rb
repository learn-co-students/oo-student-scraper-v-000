require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    jon_snow = Nokogiri::HTML(open(index_url))
    student_index = []
    students = doc.css("")
    students.each do |student|
      student_hash = {
        
      }
      student_index << student_hash
    end
    student_index
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

