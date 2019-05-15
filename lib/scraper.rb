require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    students = []

    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        name = student.css(".student-name").text
        location = student.css(".student-location").text
        url = student.attribute('href').value
        students << {:name => name, :location => location, :profile_url => url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile = Nokogiri::HTML(html)

    student = {}
    links = []

    student[:profile_quote] = profile.css(".profile-quote").text
    student[:bio] = profile.css(".description-holder p").text

    profile.css(".social-icon-container").children.css("a").each do |icon|
      links << icon.attribute('href').value
      links.each do |link|
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
    end

    new_student = {}
    new_student[:bio] = student[:bio]
    new_student[:blog] = student[:blog]
    new_student[:github] = student[:github]
    new_student[:linkedin] = student[:linkedin]
    new_student[:profile_quote] = student[:profile_quote]
    new_student[:twitter] = student[:twitter]
    new_student.delete_if { |k, v| v == nil}
    new_student

  end

end
