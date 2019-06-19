require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  
  @@all = []

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    page.css("div.student-card a").each do |card|
      name = card.css("h4").text
      location = card.css("p").text
      profile_url = card.attr("href")
        student = {name: name, location: location, profile_url: profile_url}
        @@all << student
    end
    @@all
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    page = Nokogiri::HTML(open(profile_url))
        page.css("div.social-icon-container a").each do |link|
          href = link.attr("href")
          if href.include?("twitter") 
            student[:twitter] = href
          elsif href.include?("linkedin")
            student[:linkedin] = href
          elsif href.include?("github")
            student[:github] = href
          else
            student[:blog] = href
          end
        end
        student[:profile_quote] = page.css(".profile-quote").text if page.css(".profile-quote").text
        student[:bio] = page.css("p").text if page.css("p").text 
        student
    end

end
