require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").map do |student|
      {
      name: student.css("h4").text,
      location: student.css("p").text,
      profile_url: student.css("a")[0]["href"]
    }
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    doc.css(".social-icon-container a").each do |link|
      url = link.attr("href")
      if url.include?("twitter")
        student[:twitter] = url
      elsif url.include?("linkedin")
        student[:linkedin] = url
      elsif url.include?("github")
        student[:github] = url
      else
        student[:blog] = url
      end
    end
    student[:profile_quote] = doc.css(".profile-quote").text if doc.css(".profile-quote").text
    student[:bio] = doc.css("p").text if doc.css("p").text
    student
  end
end
