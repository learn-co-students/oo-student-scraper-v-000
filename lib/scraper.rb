require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array = []
    doc.css("div.student-card").each do |student_card|
      student_array << {
      :name => student_card.css(".card-text-container h4").text,
      :location => student_card.css(".card-text-container p").text,
      :profile_url => student_card.css("a").attribute("href").value
      }
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_array = {}
    social_links = doc.css(".social-icon-container a")
    social_links.each do |social|
      if social.attribute("href").value.include?("twitter")
        profile_array[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        profile_array[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        profile_array[:github] = social.attribute("href").value
      else
        profile_array[:blog] = social.attribute("href").value
      end
    end
    profile_array[:profile_quote] = doc.css(".profile-quote").text
    profile_array[:bio] = doc.css(".description-holder p").text
    profile_array
  end

end
