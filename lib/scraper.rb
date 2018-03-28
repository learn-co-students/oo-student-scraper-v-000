require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))

    #binding.pry

    students = []
    index_page.css("div.student-card").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a").attribute("href").value
      student = {:name => name, :location => location, :profile_url => profile_url}
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))

    student = {}

    student[:bio] = profile_page.css("div.description-holder p").text
    student[:profile_quote] = profile_page.css("div.profile-quote").text

    profile_page.css("div.social-icon-container a").each do |profile|
      link = profile.attribute("href").value
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?(".com")
        student[:blog] = link
      end
    end
    student
  end
end
