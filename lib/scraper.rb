require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    cards = doc.css(".student-card a")
    cards.map do |card|
      {
        name: card.css(".card-text-container .student-name").text,
        location: card.css(".card-text-container .student-location").text,
        profile_url: card.attr("href")
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    student_details = {}
    doc = Nokogiri::HTML(open(profile_url))
    profile_details = doc.css(".profile")
    social_links = profile_details.css(".social-icon-container a")
    links = social_links.map do |link|
      link.attr("href")
    end
    links.each do |link|
      if link.include?('twitter')
        student_details[:twitter] = link
      elsif link.include?('linkedin')
        student_details[:linkedin] = link
      elsif link.include?('github')
        student_details[:github] = link
      else
        student_details[:blog] = link
      end
    end

    student_details[:profile_quote] = profile_details.css(".profile-quote").text
    student_details[:bio] = profile_details.css(".bio-block p").text
    student_details
  end
end
