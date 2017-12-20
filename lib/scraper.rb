require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    index = Nokogiri::HTML(html)

    index.css(".student-card").map do |student|
      {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile = Nokogiri::HTML(html)

    student = {}

    social_container = profile.css(".social-icon-container a")
    social_container.each do |social|
      sns_name = social.attribute("href").value
      if sns_name.include?("twitter")
        student[:twitter] = sns_name
      elsif sns_name.include?("linkedin")
        student[:linkedin] = sns_name
      elsif sns_name.include?("github")
        student[:github] = sns_name
      else
        student[:blog] = sns_name
      end
    end

    student[:profile_quote] = profile.css(".profile-quote").text if profile.css(".profile-quote")
    student[:bio] = profile.css(".description-holder p").text if profile.css(".description-holder p")
    student
  end
end
