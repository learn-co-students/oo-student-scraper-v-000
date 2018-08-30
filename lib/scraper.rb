require 'open-uri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(File.read(index_url))
    
    scraped_students = []
    
    index_page.css("div.card-text-container").each do |student_attr|
      student_name = student_attr.css("h4.student-name").text
      student_location = student_attr.css("p.student-location").text
      student_profile = index_page.css("div.student-card a").attribute("href").value
      
      scraped_students << {
        :name => student_name, 
        :location => student_location, 
        :profile_url => student_profile
      }
      binding.pry
    end
    return scraped_students
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

