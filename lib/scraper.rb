require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))

    students = []

    page.css(".student-card").each do |card|
      students << {
        :name => card.css(".student-name").text,
        :location => card.css(".student-location").text,
        :profile_url => card.css("a").attribute("href").value
      }
    end

    students

  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))

    student = {}

    page.css(".social-icon-container a").each do |icon|
      if icon.css("img").attribute("src").value.include? "twitter"
        student[:twitter] = icon.attribute("href").value
      elsif icon.css("img").attribute("src").value.include? "linkedin"
        student[:linkedin] = icon.attribute("href").value
      elsif icon.css("img").attribute("src").value.include? "github"
        student[:github] = icon.attribute("href").value
      elsif icon.css("img").attribute("src").value.include? "rss"
        student[:blog] = icon.attribute("href").value
      end
    end

    student[:profile_quote] = page.css(".profile-quote").text
    student[:bio] = page.css(".bio-content .description-holder p").text

    student

  end

end
