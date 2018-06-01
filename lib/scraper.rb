require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    result = []
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css("div.student-card")
    students.each do |student|
      result << {
        name: student.css("div.card-text-container h4").text,
        location: student.css("div.card-text-container p").text,
        profile_url: student.css("a")[0]["href"]
      }
    end
    result
  end

  def self.scrape_profile_page(profile_url)
    result = {}
    doc = Nokogiri::HTML(open(profile_url))
    social_links = doc.css("div.social-icon-container a").map {|link| link["href"]}
    social_links.each do |link|
      if link.include?("twitter")
        result[:twitter] = link
      elsif link.include?("linkedin")
        result[:linkedin] = link
      elsif link.include?("github")
        result[:github] = link
      else
        result[:blog] = link
      end
    end
    result[:profile_quote] = doc.css("div.profile-quote").text
    result[:bio] = doc.css("div.description-holder p").text
    result
  end
end
