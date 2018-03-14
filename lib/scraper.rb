require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    student_cards = index_page.css(".student-card")
    students = []
    student_cards.each do |card|
      student = {}
      student[:name] = card.css("h4.student-name").text
      student[:location] = card.css("p.student-location").text
      student[:profile_url] = card.css("a").attribute("href").value
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    profile_info = {}
    social_links = profile_page.css("div.social-icon-container a")
    social_links.each do |link|
      link_type = link.css("img").attribute("src").value.gsub("../assets/img/", "").gsub("-icon.png", "").gsub("rss", "blog")
      profile_info[link_type.to_sym] = link.attribute("href").value
    end
    profile_info[:profile_quote] = profile_page.css("div.vitals-text-container div.profile-quote").text
    profile_info[:bio] = profile_page.css("div.details-container div.bio-content div.description-holder p").text
    profile_info
  end



end
