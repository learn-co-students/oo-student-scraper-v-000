require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students= Nokogiri::HTML(open(index_url)).css(".student-card")
    
    students.collect do |student|
      { :name => "#{student.css(".student-name").text}",
        :location => "#{student.css(".student-location").text}",
        :profile_url => "#{student.css("a").attribute("href").value}" }
    end
  end

  def self.scrape_profile_page(profile_url)
    profile= Nokogiri::HTML(open(profile_url))
    social_links = profile.css(".social-icon-container a").collect do |nodeset|
      nodeset.attribute("href").value
    end
    
    profile_hash = {}
    
    social_links.each do |link|
      if link.include? "twitter"
        profile_hash[:twitter] = link
      elsif link.include? "linkedin"
        profile_hash[:linkedin] = link
      elsif link.include? "github"
        profile_hash[:github] = link
      elsif link.include? "facebook"
        profile_hash[:facebook] = link
      else 
        profile_hash[:blog] = link
      end
    end
    
    profile_hash[:profile_quote] = "#{profile.css(".profile-quote").text}"
    profile_hash[:bio] = "#{profile.css(".description-holder p").text}"
    
    profile_hash
  end

end

          