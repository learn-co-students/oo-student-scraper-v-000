require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open("#{index_url}")
    page = Nokogiri::HTML(html)

    page.css(".student-card").map.with_index do |card, idx|
      student_hash = {}
      student_hash[:name] = page.css(".student-name")[idx].text
      student_hash[:location] = page.css(".student-location")[idx].text
      student_hash[:profile_url] = page.css(".student-card a")[idx]["href"]
      student_hash
    end

  end

  def self.scrape_profile_page(profile_url)
    student_hash = {}

    html = open("#{profile_url}")
    page = Nokogiri::HTML(html)

    page.css(".social-icon-container a").each_with_index do |social_link, idx|
      # binding.pry
      if social_link["href"].include?("twitter")
        student_hash[:twitter] = social_link["href"]
      elsif social_link["href"].include?("linkedin")
        student_hash[:linkedin] = social_link["href"]
      elsif social_link["href"].include?("github")
        student_hash[:github] = social_link["href"]
      else
        student_hash[:blog] = social_link["href"]
      end
    end
    student_hash[:profile_quote] = page.css(".profile-quote").text
    student_hash[:bio] = page.css(".bio-content p").text
    student_hash
  end

end
