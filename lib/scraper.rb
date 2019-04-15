require 'open-uri'
require 'pry'
require 'nokogiri'


class Scraper

  def self.scrape_index_page(index_url)
    #student_hash = {:name, :location, :profile_url}
    #student_array = []
    student_array = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").map do |student|
      student_hash = {:name => student.css(".student-name").text, :location => student.css(".student-location").text, :profile_url => "./fixtures/student-site/#{student.css("a").attribute("href").value}" }
      student_array << student_hash
    end
    student_array
  end



  def self.scrape_profile_page(profile_url)
    student = {}
    profile = Nokogiri::HTML(open(profile_url))
    links = profile.css(".social-icon-container").children.css("a").map {|link| link.attribute("href").value}
    links.map do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end
    student[:profile_quote] = profile.css(".profile-quote").text if profile.css(".profile-quote")
    student[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text if profile.css("div.bio-content.content-holder div.description-holder p")
    student
  end
end
