require 'open-uri'
require 'pry'
require 'nokogiri'


class Scraper

  def self.scrape_index_page(index_url)
    # returns array of students
    doc = Nokogiri::HTML(open(index_url))

    cards = doc.css(".student-card")
    student_info = []
    cards.each do |card|
      student = {}
      student[:name] = card.css("h4.student-name").text
      student[:location] = card.css("p.student-location").text
      student[:profile_url] = card.css("a")[0]["href"]
      student_info << student
    end
    
    student_info
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    profile = {}
    # if quote, set quote
    doc.css(".vitals-text-container .profile-quote").text ? profile[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text : false
    # if bio, set bio
    doc.css(".bio-block.details-block .description-holder p").text ? profile[:bio] = doc.css(".bio-block.details-block .description-holder p").text : false

    doc.css(".social-icon-container a").each do |link|
      # if link contains substring, set social. assume non-match is blog
      if link["href"].include?("github")
        profile[:github] = link["href"]
      elsif link["href"].include?("linkedin")
        profile[:linkedin] = link["href"]
      elsif link["href"].include?("twitter")
        profile[:twitter] = link["href"]
      else
        profile[:blog] = link["href"]
      end
    end

    profile
  end

end
