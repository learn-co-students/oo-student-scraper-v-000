require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
   
    students = []
  
    index.css('div.student-card').each do |student|
      student = {
        :name => student.css('h4.student-name').text,
        :location => student.css('p.student-location').text,
        :profile_url => student.css('a').attribute('href').value
      }
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))

    attributes = {}
    
    profile.css('div.vitals-container').each do |attr|
      attributes = {
        :twitter => attr.css('a')[0].attribute('href').value, 
        :linkedin => attr.css('a')[1].attribute('href').value,
        :github => attr.css('a')[2].attribute('href').value,
        :blog => attr.css('a')[3].attribute('href').value,
        :profile_quote => attr.css('div.profile-quote').text,
        :bio => attr.css('div.description-holder p').text
     
      }
      binding.pry
    end
    attributes
  end

end

