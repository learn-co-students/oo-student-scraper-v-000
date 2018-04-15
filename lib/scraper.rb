require 'open-uri'
require 'pry'

class Scraper
  
  attr_accessor :name, :location, :profile_url, #:twitter, :github, :linkedin, :other, :bio
  
 

  def self.scrape_index_page(index_url)
    html = open(index_url)
   
    index_page = Nokogiri::HTML(html)

    students = []
    
    index_page.css('.student-card a').map do |student|
     name = student.css('h4').text
     page_url = student.attribute('href').value
     location = student.css('p').text
      
      name = {:name =>  name, :location => location , :profile_url => page_url}
      
      students << name
    end
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

    student={}
    student[:bio]= profile.css(".description-holder p").text
    student[:profile_quote] = profile.css('.profile-quote').text
    
    social_media.map do | account|
        if account.include? 'twitter'
             student[:twitter] = account
        elsif account.include? 'linkedin'
              student[:linkedin] =  account
        elsif account.include? 'github'
             student[:github] = account
          else
            student[:blog] = account
        end
    end  
     student
  end
  
end


