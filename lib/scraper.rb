require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))

    scraped_student_array = []

    index_page.css(".student-card").each do |student|
      student_info = {}
      student_info[:name] = student.css(".student-name").text
      student_info[:location] = student.css(".student-location").text
      student_info[:profile_url] = student.css("a").attribute("href").text
      scraped_student_array << student_info
      #binding.pry
    end
    scraped_student_array

  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))

    profile_info = {}

    profile_info[:profile_quote] = profile_page.css(".profile-quote").text
    profile_info[:bio] = profile_page.css(".description-holder p").text

    # can handle profile pages without all of the social links
    profile_page.css(".social-icon-container a").each do |social|
      if social["href"].include?("twitter")
        profile_info[:twitter] = social["href"]
      elsif social["href"].include?("linkedin")
        profile_info[:linkedin] = social["href"]
      elsif social["href"].include?("github")
        profile_info[:github] = social["href"]
      else
        profile_info[:blog] = social["href"]
      end
    end
    # binding.pry
    profile_info
  end

end
