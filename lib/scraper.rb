require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    student_cards = page.css(".student-card").collect {|student|
      student_hash = {}
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      student_hash[:profile_url] = student.css("a").attribute("href").value
      student_hash
    }
    student_cards
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
      social_media_hash = {}
      social_media_hash[:profile_quote] = page.css(".profile-quote").text
      social_media_hash[:bio] = page.css(".description-holder p").text

      info = page.css(".social-icon-container a").collect {|social_media_link|
        link = social_media_link.attribute("href").text
        if link.include?("twitter")
          social_media_hash[:twitter] = link
        elsif link.include?("linkedin")
          social_media_hash[:linkedin] = link
        elsif link.include?("github")
          social_media_hash[:github] = link
        else link.include?("blog")
          social_media_hash[:blog] = link
        end
        }
      social_media_hash

  end

end
