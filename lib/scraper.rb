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
    student = {}
    page = Nokogiri::HTML(open(profile_url)) # use Nokogiri to grab the web page into an HTML object
    socials = page.css('.social-icon-container a') # scrape the social icons and links
    socials.each do |social|  # iterate over the social links
      url = social['href']
      if url["twitter"]  # figure out if the specific link is twitter, linkedin, github or blog
        student[:twitter] = url
      elsif url["linkedin"]
        student[:linkedin] = url
      elsif url["github"]
        student[:github] = url
      else
        student[:blog] = url
      end
    end
    quote = page.css('.profile-quote').text
    bio = page.css('.bio-content p').text.split.join(" ") # clean up the bio paragraph
    student[:profile_quote] = quote 
    student[:bio] = bio
    student # return the built out hash
  end

end

