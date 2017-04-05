require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []

    index_page.css("div.roster-cards-container").each do |card|
      card.css("div.student-card a").each do |student|
        students << {:name => student.css("div.card-text-container h4.student-name").text, :location => student.css("div.card-text-container p.student-location").text, :profile_url => "./fixtures/student-site/" + student.attribute("href").value}
      end
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    student_page = Nokogiri::HTML(open(profile_url))
    student = {}

    links = student_page.css("div.social-icon-container a").collect{|link| link.attribute("href").value}

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

    student[:profile_quote] = student_page.css("div.profile-quote").text
    student[:bio] = student_page.css("div.bio-content div.description-holder p").text

    student
  end

end
