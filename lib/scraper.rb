require 'open-uri'
require 'pry'

class Scraper
  
  attr_accessor :name, :location, :profile_url, :twitter
  
 

  def self.scrape_index_page(index_url)
    html = open(index_url)
   
    index_page = Nokogiri::HTML(html)
    # binding.pry
    
    students = []
    
    index_page.css('.student-card a').map do |student|
     
    
     name = student.css('h4').text
     page_url = student.attribute('href').value
     location = student.css('p').text
      
      name = {:name =>  name, :location => location , :profile_url => page_url}
      
      students << name
    
    end
  # binding.pry
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile = Nokogiri::HTML(html)
    
    social_media = []
    i = 0
    while i < profile.css('div.social-icon-container a').length
      social_media << profile.css('div.social-icon-container a')[i].attribute('href').value
      i+= 1
    end

     social_media.each do | account|
       binding.pry
       case account.include? 
         when 'twitter'
           twitter = account
          when 'linkedin'
            linkedin =  account
          when 'github'
            github = account
          else
            other = account
            binding.pry
        end
        
    end    
     
  end

end


