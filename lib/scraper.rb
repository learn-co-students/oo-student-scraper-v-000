require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    student_cards = Nokogiri::HTML(open("#{index_url}")).css(".student-card")
    students = []
    student_cards.each do |card|
      students << {
        :name => card.css(".student-name").text,
        :location => card.css(".student-location").text,
        :profile_url => card.css("a").attr("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open("#{profile_url}"))
    student = {}
    # Social media, blog, etc.
    social_links = doc.css(".social-icon-container").css("a")
      social_links.each do |a|
        link = a.attr("href")
        if link.include?("twitter")
          student[:twitter] = link
        elsif link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("github")
          student[:github] = link
        else
          student[:blog] = link
        end
      end
    # Other bio info
    student[:bio] = doc.css(".description-holder").css("p").text
    student[:profile_quote] = doc.css(".profile-quote").text

    student
  end

end
