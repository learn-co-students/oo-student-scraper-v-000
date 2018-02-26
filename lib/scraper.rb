require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    studs = [] 
    page = Nokogiri::HTML(open(index_url))
    students = page.css('div.roster-cards-container div.student-card')
    students.each do |person|
      name = person.css('h4.student-name').text
      location = person.css('p.student-location').text
      profile_uri = person.css('a')[0]['href']
      st = {name: name, location: location, profile_url: profile_uri}
      studs << st
    end
    studs
  end

  def self.scrape_profile_page(profile_url)
    # Scrapes a students profile page and returns a hash of attributes describing an indivual student
    social_urls = []
    page = Nokogiri::HTML(open(profile_url)) # use Nokogiri to grab the web page into an HTML object
    socials = page.css('.social-icon-container a')
    socials.each do |social|
      social_urls << social['href']
    end
    quote = page.css('.profile-quote').text
    bio = page.css('.description-holder').text
    binding.pry 
  end

end

