require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    result = []
    students = Nokogiri::HTML(open(index_url)).css(".student-card")
    students.each do |s|
      result << {
        :name => s.css(".student-name").text,
        :location => s.css(".student-location").text,
        :profile_url => s.css("a")[0]["href"]
      }
    end
    result
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    result = {
      :bio => doc.css(".description-holder").css("p").text,
      :profile_quote => doc.css(".profile-quote").text
    }
    doc.css(".social-icon-container").css("a").each do |a|
      if a["href"].include?("twitter")
        result[:twitter] = a["href"]
      elsif a["href"].include?("linkedin")
        result[:linkedin] = a["href"]
      elsif a["href"].include?("github")
        result[:github] = a["href"]
      else
        result[:blog] = a["href"]
      end
    end
    result
  end
end
