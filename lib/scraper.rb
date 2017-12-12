require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_array = []
    doc = Nokogiri::HTML(open(index_url))

    doc.css(".student-card").each do |student_card|
      student = Hash.new
      student[:name] = student_card.css("h4").text
      student[:location] = student_card.css(".student-location").text
      student[:profile_url] = student_card.css("a").attribute("href").value
      index_array << student
    end
    index_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
      student = Hash.new
      links = []
      index = 0
      doc.css("a").each do |link|
        if link.css("img").attribute("src").value.include? "twitter"
          student[:twitter] = link.attribute("href").value
        elsif link.css("img").attribute("src").value.include? "linkedin"
          student[:linkedin] = link.attribute("href").value
        elsif link.css("img").attribute("src").value.include? "github"
          student[:github] = link.attribute("href").value
        elsif link.css("img").attribute("src").value.include? "rss"
          student[:blog] = link.attribute("href").value
        end
      end
      student[:profile_quote] = doc.css(".profile-quote").text
      student[:bio] = doc.css(".description-holder").css("p").text
    student
  end

end
