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
    social = page.css(".social-icon-container a")

    social.each do |media|
      info = media.attribute("href").value
      student_profile[:twitter] = info if info.include? "twitter"
      student_profile[:linkedin] = info if info.include? "linkedin"
      student_profile[:github] = info if info.include? "github"
      student_profile[:blog] = info if (!info.include? "github") && (!info.include? "linkedin") && (!info.include? "twitter")
    end     
     
    student_profile[:profile_quote] = page.css(".profile-quote").text
    student_profile[:bio] = page.css(".description-holder p").text

    student_profile
  end  

end