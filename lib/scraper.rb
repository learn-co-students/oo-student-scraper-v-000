require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")
    students.collect do |card|
      student = {}
      student[:name] = card.css("h4.student-name").text
      student[:location] = card.css("p.student-location").text
      student[:profile_url] = card.css("a").attribute("href").value
      student
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_hash = {}
    links = doc.css("div.social-icon-container a")
    parsed_links = links.collect do |link|
      link.attribute("href").value
    end
    parsed_links.each do |link|
      if link.include?("linkedin")
        student_hash[:linkedin] = link
      elsif link.include?("twitter")
        student_hash[:twitter] = link
      elsif link.include?("github")
        student_hash[:github] = link
      else
        student_hash[:blog] = link
      end
    end
    student_hash[:profile_quote] = doc.css("div.profile-quote").text if doc.css("div.profile-quote").text
    student_hash[:bio] = doc.css("div.bio-content div.description-holder p").text if doc.css("div.bio-content div.description-holder p").text
    student_hash
  end

end
