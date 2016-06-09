require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    profile_hashes = []
    page = Nokogiri::HTML(open(index_url))
    profiles = page.css(".student-card")
    
    profiles.each do |profile|
      hashes = {
      :name => profile.css(".student-name").text,
      :location => profile.css(".student-location").text,
      :profile_url => profile.css("a").attribute("href").value.prepend("#{index_url}")
    }
    profile_hashes << hashes
    end
    profile_hashes
  end
  
  def self.scrape_profile_page(profile_url)
    student_profile = {}
    page = Nokogiri::HTML(open(profile_url))    
    
    student_profile[:twitter] = page.css(".social-icon-container a").attribute("href").value
    #student_profile[:linkedin] = 
    #student_profile[:github] = 
    #student_profile[:blog] = 
    #student_profile[:profile_quote] = 
    #student_profile[:bio] = 

    puts student_profile
  end  

end

Scraper.scrape_profile_page("http://127.0.0.1:4000/students/ryan-johnson.html")