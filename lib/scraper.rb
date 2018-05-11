require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    page = Nokogiri::HTML(html)
    students = []
    page.css(".student-card").each do |student_card|
    #binding.pry
      student = {
        :name => student_card.css("h4").text,
        :location => student_card.css("p.student-location").text,
        :profile_url => student_card.css("a").attribute('href').value
      }
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    page = Nokogiri::HTML(html)
    social_links = page.css("div.social-icon-container a")
    social_link_hash = {}
    page.css(".social-icon-container")
    student_name = page.css("div.vitals-text-container h1")
    i = 0
    while i < social_links.css("a").length
      social_links.each do |social_link|
        if social_link.attribute('href').value.include?("twitter")
          social_link_hash[:twitter] = social_link.attribute('href').value
        elsif social_link.attribute('href').value.include?("linkedin")
          social_link_hash[:linkedin] = social_link.attribute('href').value
          #binding.pry
        elsif social_link.attribute('href').value.include?("github")
          social_link_hash[:github] = social_link.attribute('href').value
        elsif social_link.attribute('href').value.include?("div.vitals-text-container h1")
          social_link_hash[:blog] = social_link.attribute('href').value
        end
        i += 1
      end
    end
    social_link_hash[:profile_quote] = page.css("div.vitals-text-container div").text
    social_link_hash[:bio] = page.css("p").text
    social_link_hash
    #binding.pry
  end

end
