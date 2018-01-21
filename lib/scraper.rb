require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  #div.roster-cards-container
  #div.student-card
  #:name  h4.student-name.text
  #:location p.student-location.text
  #:profile_url a.attribute href.value

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.roster-cards-container").each do |student_card|
      student = {}
      student_card.css("div.student-card").each do |student_attr|
        student = {
          :name => student_attr.css("h4.student-name").text,
          :location => student_attr.css("p.student-location").text,
          :profile_url => student_attr.css("a").attribute("href").value
        }
        students << student
      end
    end
    students
  end

  #:twitter => icon.css("a").attribute("href").twitter
  #:linkedin => icon.css("a").attribute("href").linkedin
  #:github => icon.css("a").attribute("href").github
  #:blog =>
  #:profile_quote => doc.css(".profile-quote").text
  #:bio => doc.css("div.description-holder").css("p").text


  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    student = {}

    profile.css(".social-icon-container a").each do |icon|
      icon_link = icon.attribute("href").text
      if icon_link.include?("twitter")
        student[:twitter] = icon_link
      elsif icon_link.include?("linkedin")
        student[:linkedin] = icon_link
      elsif icon_link.include?("github")
        student[:github] = icon_link
      else
        student[:blog] = icon_link
      end
    end

    student[:profile_quote] = profile.css(".profile-quote").text
    student[:bio] = profile.css("p").text
    student
  end
end
