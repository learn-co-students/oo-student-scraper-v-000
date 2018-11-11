require 'open-uri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)
    html = open(index_url)
    parsed_page = Nokogiri::HTML(html)
    all_students = parsed_page.css('div.student-card')
    
    all_students.collect do |student_card|
      
      student = {
        :name => student_card.css('h4.student-name').text,
        :location => student_card.css('p.student-location').text,
        :profile_url => student_card.css('a').attr('href').value
      }
      student
    end
  end
    
  def self.scrape_profile_page(profile_url)
    html = open(profile_url) #=> "Go to this webpage"
    parsed_profile = Nokogiri::HTML(html) #=> parses html 
     
    student_info = parsed_profile.css('div.social-icon-container') #=> calls css selector, go to div tag
    
    social_hash = {} #=> create new hash
    
    student_info.each do |element|
      links = element.css('a').map do |node| #=> pulls all 'a' tags from the node set
        node['href'] #=> on each node in the array, pull 'href'
      end
      
      links.each do |link| #=> only setting href that the student has on their profile
        if link.include?('twitter')
          social_hash[:twitter] = link  
        elsif link.include?('linkedin')
          social_hash[:linkedin] = link
        elsif link.include?('github')
          social_hash[:github] = link
        else
          social_hash[:blog] = link
        end
      end
    end
    
    other_info = parsed_profile.css('div.vitals-container')
    bio = parsed_profile.css('div.description-holder')
  
    #=> add key/value pairs to existing hash; use comma if I am creating a hash
    social_hash[:profile_quote] = other_info.css('div.profile-quote').text
    social_hash[:bio] = bio.css('p').text
    social_hash
  end
end

#=> if line exceeds 80 characters, break it up!

