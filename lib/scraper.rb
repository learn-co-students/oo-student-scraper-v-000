require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".roster-cards-container")
    cards = doc.css(".student-card")

    cards_array = []

    cards.each do |element|
      students_hash = {}
      students_hash = {
        name: element.css(".student-name").text,
        location: element.css(".student-location").text,
        profile_url: element.css("a").attr("href").text,
      }
      cards_array << students_hash
    end
    cards_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_hash = {}

    socials = doc.css(".social-icon-container a")

     socials.each do |social|
       if social.attr("href").include?("twitter")
         profile_hash[:twitter] = social.attr("href")
       elsif social.attr("href").include?("linkedin")
         profile_hash[:linkedin] = social.attr("href")
       elsif social.attr("href").include?("github")
         profile_hash[:github] = social.attr("href")
       else
          profile_hash[:blog] = social.attr("href")
       end
     end #socials each
     profile_hash[:profile_quote] = doc.css(".profile-quote").text
     profile_hash[:bio] = doc.css(".description-holder").css("p").text
      profile_hash

  end #self.scrape_profile_page

end #scraper
