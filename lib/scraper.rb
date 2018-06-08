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
    html = Nokogiri::HTML(open(profile_url))
    attributes = {}
    profile = html.css('div.vitals-container')
    
    attributes.tap do |attr|
      attr[:twitter] = profile.css('a')[0].attribute('href').value if profile.css('a')[0].attribute('href').value
        #:twitter => profile.css('a')[0].attribute('href').value,
      attr[:linkedin] = profile.css('a')[1].attribute('href').value if profile.css('a')[1].attribute('href').value
      attr[:github] = profile.css('a')[2].attribute('href').value if profile.css('a')[2].attribute('href').value
      attr[:blog] = profile.css('a')[3].attribute('href').value if profile.css('a')[3].attribute('href').value
      attr[:profile_quote] = profile.css('div.profile-quote').text if profile.css('div.profile-quote').text
      attr[:bio] = html.css('div.description-holder p').text if html.css('div.description-holder p').text
    }
    attributes
  end

end

