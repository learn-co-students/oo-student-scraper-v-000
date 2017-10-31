require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    document = Nokogiri::HTML(open(index_url))
    scraped_students = []

    document.css(".student-card").each do |card|

      student = {
        :name => card.css("h4.student-name").text,
        :location => card.css("p.student-location").text,
        :profile_url => card.css("a").attribute("href").value
      }

      scraped_students << student
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    document = Nokogiri::HTML(open(profile_url))

    prof = {}
    prof[:profile_quote] = document.css("div.profile-quote").text
    prof[:bio] = document.css("div.bio-content p").text

    document.css("div.social-icon-container a").each do |link|
      if link["href"].include?("twitter")
        prof[:twitter] = link["href"]
      elsif link["href"].include?("linkedin")
        prof[:linkedin] = link["href"]
      elsif link["href"].include?("github")
        prof[:github] = link["href"]
      else link["href"].include?("blog")
        prof[:blog] = link["href"]
      end
    end

    prof

  end

end
