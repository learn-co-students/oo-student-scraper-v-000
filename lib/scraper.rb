require 'open-uri'
require 'pry'
require 'nokogiri'

index_url = "fixtures/student-site/index.html"


class Scraper

  attr_accessor :scraped_students

  def self.scrape_index_page(index_url)
    scraped_students = []
    html = Nokogiri::HTML(open(index_url))
    html.css("div.student-card").each do |card|
      student = {
      :name => card.css(".student-name").text,
      :location => card.css(".student-location").text,
      :profile_url => card.css("a").attribute("href").value
    }
    scraped_students << student
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = {}
    html = Nokogiri::HTML(open(profile_url))
    html.css(".vitals-container a").each do |a|
      if a.attribute("href").value =~ (/twitter/)
        scraped_student[:twitter] = a.attribute("href").value
      elsif a.attribute("href").value =~ (/linkedin/)
        scraped_student[:linkedin] = a.attribute("href").value
      elsif a.attribute("href").value =~ (/github/)
        scraped_student[:github] = a.attribute("href").value
      else
        scraped_student[:blog] = a.attribute("href").value
      end
    end
    scraped_student[:profile_quote] = html.css(".profile-quote").text
    # bio_text = html.css(".description-holder").text
    scraped_student[:bio] = html.css(".description-holder p").text.split.join(" ") #gsub("\n",'').gsub("/\s+/", " ")
    # binding.pry
    scraped_student
  end
end
