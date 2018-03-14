require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open("#{index_url}")
    page = Nokogiri::HTML(html)

    page.css(".student-card").map do |student|
      student_hash = {}
      student_hash[:name] = student.css(".student-name")[0].text
      student_hash[:location] = student.css(".student-location")[0].text
      student_hash[:profile_url] = student.css("a")[0]["href"]
      student_hash
    end
  end



  def self.scrape_profile_page(profile_url)
    html = open("#{profile_url}")
    page = Nokogiri::HTML(html)
    profile_hash = {}
    page.css(".social-icon-container a").map do |link|
      if link["href"].include?("twitter")
        profile_hash[:twitter] = link["href"]
      elsif link["href"].include?("linked")
        profile_hash[:linkedin] = link["href"]
      elsif link["href"].include?("github")
        profile_hash[:github] = link["href"]
      else
        profile_hash[:blog] = link["href"]
      end
    end
    profile_hash[:profile_quote] = page.css(".profile-quote").text
    profile_hash[:bio] = page.css(".bio-content p").text
    profile_hash
  end
end
