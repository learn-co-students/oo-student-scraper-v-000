require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    school = []
    cards = doc.css("div.roster-cards-container")
    cards.each do |card|
     card.css('.student-card a').each do |student|
       name = student.css('.student-name').text
       location = student.css('.student-location').text
       profile = "#{student.attr('href')}"
       school << {name: name, location: location, profile_url: profile}
     end
   end
   school
  end

   def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile = Nokogiri::HTML(html)
    student = {}
    profile.css(".social-icon-container a").each do |social_link|
      link = social_link.attribute("href").value
      if link.include?('twitter')
        student[:twitter] = link
      elsif link.include?('linkedin')
        student[:linkedin] = link
      elsif link.include?('github')
          student[:github] = link
      else student[:blog] = link
      end
    end
    student[:profile_quote] = profile.css('.profile-quote').text
    student[:bio] = profile.css('.bio-content .description-holder p').text
    #student[:education] = profile.css('.details-container .education-block .description-holder h4').text (For fun, an education attribute.)
    student
  end
end
