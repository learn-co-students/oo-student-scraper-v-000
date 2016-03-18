require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    Nokogiri::HTML(open(index_url)).css(".student-card").collect {|card|

    {
    name: card.css("h4").text,
    #binding.pry
    #student_names = doc.css(".student-card").css("h4")
    location: card.css("p").text,

    profile_url: "http://students.learn.co/#{card.css("a").attribute("href").value}"
      }}
end




def self.scrape_profile_page(profile_url)
  social_link_hash={}
  doc = Nokogiri::HTML(open(profile_url))

   links = doc.css(".social-icon-container").css("a").collect {|s|
      s.attribute("href").value }
    links.each do |link|
      if link.include?("linkedin")
        social_link_hash[:linkedin] = link
      elsif link.include?("github")
        social_link_hash[:github] = link
      elsif link.include?("twitter")
        social_link_hash[:twitter] = link
      else
        social_link_hash[:blog] = link
      end
    end

      # binding.pry
      social_link_hash[:profile_quote] = doc.css(".profile-quote").text
      social_link_hash[:bio] = doc.css(".description-holder").css("p").text

  social_link_hash
  end
end