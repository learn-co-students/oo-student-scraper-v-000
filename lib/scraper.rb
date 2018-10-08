require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper 
  attr_accessor :page 
  
  index_url = "./fixtures/student-site/index.html"
  profile_url = ".fixtures/student-site/students"

  
  @@all = Array.new
  
  def self.scrape_index_page(index_url)
    parsed_page = Nokogiri::HTML(open(index_url))   
    students = Array.new
    listings = parsed_page.css('div.student-card')
    listings.each do |card|
      @student = {
        name: card.css('div.card-text-container h4.student-name').text,
        location: card.css('a div.card-text-container p.student-location').text,
        profile_url: card.css('a').attribute('href').value,
      }
      students << @student
      end
      students
  end

  def self.scrape_profile_page(profile_url)
    profiles = []
    student_details = {}
    page = Nokogiri::HTML(open(profile_url))
      vitals_info = page.css('.social-icon-container').children.css('a').map {|x| x.attribute('href').value}

      vitals_info.each do |card|
                #binding.pry
           
           if card.include?('twitter')
            student_details[:twitter] = card 
           elsif card.include?('linkedin')
             student_details[:linkedin] = card 
           elsif card.include?('github')
             student_details[:github] = card 
           else
             student_details[:blog] = card  
          end
      end
        quote_info = page.css('div.vitals-container div.vitals-text-container')
          student_details[:profile_quote] = quote_info.css('div.profile-quote').text
        bio_info = page.css('div.details-container')
          student_details[:bio] = bio_info.css('div.description-holder p').text
   
    student_details
  end
  
end
 

