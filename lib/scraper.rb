require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    profiles = []
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css('div.student-card')
    students.each {|s|
    profiles << {:name => s.css('h4').text, :location => s.css('p').text, :profile_url => s.css('a')[0]['href']}}
    profiles
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    links = doc.css('div.social-icon-container a').collect { |link| link['href']}
    linkedin = links.detect {|url| url.include?"linkedin"}
    github = links.detect {|url| url.include?"github"}
    twitter  = links.detect {|url| url.include?"twitter"}
    blog = links.detect {|url| url.include?"http:"}
    profile = {}
      profile[:linkedin] = linkedin if linkedin != nil
      profile[:github] = github if github != nil
      profile[:blog] = blog if blog != nil
      profile[:twitter] = twitter if twitter !=nil
      profile[:profile_quote] = doc.css('div.profile-quote').text
      profile[:bio] = doc.css('div.description-holder p').text
    profile
  end

end