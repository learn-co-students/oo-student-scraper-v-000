require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    arr = []
    doc.css('.roster-cards-container').each do |student|
      student.css('.student-card').each do |sub|
        profile = sub.css('a').first['href']
        location = sub.css('.student-location').text
        name = sub.css('.student-name').text
        arr << {location: location, name: name, profile_url: profile}
      end
    end
    arr
  end

  def self.scrape_profile_page(profile_url)
     doc = Nokogiri::HTML(open(profile_url))
     profile = {}
     doc.css(".social-icon-container a").collect{|link| link.attribute('href').value}.each do |link|
       if link.include?("linkedin")
         profile[:linkedin] = link
       elsif link.include?("github")
         profile[:github] = link
       elsif link.include?("twitter")
         profile[:twitter] = link
       else link.include?("blog")
         profile[:blog] = link
       end
     end
     profile[:profile_quote] = doc.css(".profile-quote").text
     profile[:bio] = doc.css(".description-holder p").text
     profile
   end
end
