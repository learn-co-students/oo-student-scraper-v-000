require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    students = Nokogiri::HTML(html)
    
    student_array = []
    
    students.css("div.roster-cards-container div.student-card").each do |student|
      student_array << {
      :name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("a").attribute("href").value
      }
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile = Nokogiri::HTML(html)
    
    profile_hash = {}
    
    profile.css("div.social-icon-container a").each do |url|
      case url.attribute("href").value
      when /twitter/ 
        profile_hash[:twitter] = url.attribute("href").value
      when /linkedin/  
        profile_hash[:linkedin] = url.attribute("href").value 
      when /github/ 
        profile_hash[:github] = url.attribute("href").value 
      else 
        profile_hash[:blog] = url.attribute("href").value 
      end
    
        
    profile_hash[:profile_quote] = profile.css("div.profile-quote").text
    profile_hash[:bio] = profile.css("div.description-holder p").text
    end
    profile_hash
  end

end

#page: div. vital-container 
#div.social-icon-container
#profile_quote: div.profile-quote
#bio: div.description-holder p 

