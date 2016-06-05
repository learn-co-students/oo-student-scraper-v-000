require 'open-uri'
require 'pry'

require 'nokogiri'
class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index = Nokogiri::HTML(html)
    students = []


    index.css(".roster-cards-container .student-card").each do |student|
      hash = {
         :name => student.css('.student-name').text, 
         :location => student.css('.student-location').text, 
         :profile_url => student.css('a').attribute("href").value 
      }
      students << hash
    end
   
    students
 
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile = Nokogiri::HTML(html)
     
    hash = {}

      profile.css(".social-icon-container a").each_with_index do |social, index|
        val = social.attribute("href").value
        skip if val.nil? || val == false

      
           if val.include?("twitter")
             hash[:twitter] = val 
           elsif val.include?("linkedin")
             hash[:linkedin] = val 
           elsif val.include?("github") 
             hash[:github] = val 
           elsif val.include?("/")
             hash[:blog] = val 
           end 
           
      end

      hash[:profile_quote] = profile.css(".profile-quote").text.strip
      binding.pry
      hash[:bio] = profile.css(".description-holder p").text.strip

      hash
    
    
  end





end

