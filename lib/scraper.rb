require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    
    profiles = []
    
    page.css(".student-card").each do |profile|
      new_profile = {
        :name => profile.css(".student-name").text,
        :location => profile.css(".student-location").text,
        :profile_url => profile.css("a").attribute("href").value
        }
      profiles << new_profile
    end
    profiles
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    
    profile = {}
    
    page.css(".social-icon-container").each do |a|
      link = a.css("a").attribute("href").value 
      
      if link.include?("twitter")
        profile(:twitter) = link
      elsif link.include?("linkedin")
        profile(:linkedin) = link
      elsif link.include?("github")
        profile(:github) = link
      else
        profile(:blog) = link
      end
    end
    
    binding.pry
    
    student = {}
    
    
    
    # :twitter => social.css("a").first.attribute("href").value
    # :linkedin => 
    # :github =>
    # :blog => 
    # :profile_quote => 
    # :bio => 
    
    # social = 
  end

end

