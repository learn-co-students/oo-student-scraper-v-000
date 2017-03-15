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

    scraped_students = []
    profile_page.css('div.vitals-container').each do |vitals|
      vitals.css('div.social-icon-container').each do |social|
      binding.pry
      end
    end
        #scraped_students << {
        #  :twitter => social.css('a href'),
        #  :linkedin => social.css('a href'),
        #  :github => social.css('a href'),
        #  :blog =>,
        #  :profile_quote => social.css('.profile_quote'),
        #  :bio =>
        #}
  end
end

# output = Scraper.scrape_index_page('./fixtures/student-site/index.html')
output = Scraper.scrape_profile_page("./fixtures/student-site/students/joe-burgess.html")
#binding.pry
