require 'open-uri'
require 'nokogiri'
require 'pry'
# require 'mechanize'

class Scraper

  @student_info_hash_array = []

  def self.scrape_index_page(index_url)    
    web_page = Nokogiri::HTML(open(index_url))

    web_page.css("div.student-card").each do |student| 
      
      student_info_hash = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").text
      }
      @student_info_hash_array << student_info_hash
    end
    @student_info_hash_array
  end
  
  def self.scrape_profile_page(profile_url)
    profile_hash = {}
    
    profile_page = Nokogiri::HTML(open(profile_url))
    
    link = profile_page.css("div.social-icon-container").children.css("a").map { |sm| sm.attribute("href").text }
    
    link.each do |site|

      if site != nil
        if site.include? "twitter"
            profile_hash[:twitter] = site
        elsif site.include? "linkedin"
            profile_hash[:linkedin] = site
        elsif site.include? "github"
          profile_hash[:github] = site
        else
          profile_hash[:blog] = site
        end
      end
  
    quote = profile_page.css("div.profile-quote").text
      profile_hash[:profile_quote] = quote

    bio = profile_page.css("div.description-holder p").text
      profile_hash[:bio] = bio

    end
    profile_hash
  end
end