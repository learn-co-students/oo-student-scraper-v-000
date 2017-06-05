require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("#{index_url}"))

    doc.css(".student-card").collect do |card|
      {
      :name => card.css(".student-name").text,
      :location => card.css(".student-location").text,
      :profile_url => card.css("a").attribute("href").value
    }
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open("#{profile_url}"))
    student = {}

    doc.css(".social-icon-container a").each do |a|
      social_link = a.attribute("href").value

      student[:twitter] = social_link if social_link.include? "twitter"
      student[:linkedin] = social_link if social_link.include? "linkedin"
      student[:github] = social_link if social_link.include? "github"
      student[:blog] = social_link if !social_link.include?("twitter") && !social_link.include?("linkedin") && !social_link.include?("github")
    end
    student[:profile_quote] =  doc.css(".profile-quote").text
    student[:bio]= doc.css(".description-holder p").text
    student
  end

end
