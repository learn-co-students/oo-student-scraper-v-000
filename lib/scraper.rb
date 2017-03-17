#!/usr/bin/env ruby
require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
#scrape_index_page method is responsible for scraping the index page that lists all of the students
  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    index_page = Nokogiri::HTML(html)
  #array
    scraped_students = []
    index_page.css('.roster-card-container').each do |cards|
      cards.css("div.student-card").each do |student|
  #hash
        scraped_students << {
          :location => student.css('.student-location').text,
          :name => student.css('.student-name').text,
          :profile_url => student.css('a').first['href']
        }
      end
    end
    scraped_students
  end

#scrape_profile_page method is responsible for scraping an individual student's profile page to get further information about that student.
  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile_page = Nokogiri::HTML(html)
#array
    scraped_students = []

      profile_page.css('div.social-icon-container').each do |social|
        #social.css('a').first[href].each do ||

#hash
        scraped_students << {
          :twitter => social.css('a')[0]['href'],  #or social.css('a').first['href'], => "https://twitter.com/jmburges"
          :linkedin => social.css('a')[1]['href'], #=> "https://www.linkedin.com/in/jmburges"
          :github => social.css('a')[2]['href'], #=> "https://github.com/jmburges"

          #John Anthony Rivera
          :blog => profile_page.css('.social-icon').attribute('src').value,
                      #profile_page.css('.social-icon').attribute("src").value
                        #=> "../assets/img/twitter-icon.png"
          #<img class="social-icon" src="../assets/img/rss-icon.png">http://johnanthony-dev.com/blog/
          #<img class="social-icon" src="../assets/img/rss-icon.png"> http://joemburgess.com/
          #<img class="social-icon" src="../assets/img/rss-icon.png">
          #<img class="social-icon" src="../assets/img/rss-icon.png"> http://dannydawson.io/
          :profile_quote => profile_page.css('.profile-quote').text,# => "\"Reduce to a previously solved problem\""
          :bio => profile_page.css('.description-holder p').text
#=> "I grew up outside of the Washington DC (NoVA!) and went to college at Carnegie Mellon University in Pittsburgh. After college, I worked as an Ora
#cle consultant for IBM for a bit and now I teach here at The Flatiron School."

        }
      end
    end
    scraped_students
end

# output = Scraper.scrape_index_page('./fixtures/student-site/index.html')
output = Scraper.scrape_profile_page("./fixtures/student-site/students/joe-burgess.html")
binding.pry 
