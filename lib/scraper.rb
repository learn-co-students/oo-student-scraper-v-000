require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_html = open(index_url)
    index_doc = Nokogiri::HTML(index_html)
    students = []
    index_doc.css("div .roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student_url = student.attr("href")
        students <<  {:name => student_name, :location => student_location, :profile_url => student_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_html = open(profile_url)
    profile_doc = Nokogiri::HTML(profile_html)
    student_info = {}
    links = profile_doc.css(".social-icon-container").children.css("a").collect do |link| link.attribute("href").value
    end
    links.each do |link|
      if link.include?("twitter")
        student_info[:twitter] = link
      elsif link.include?("linkedin")
        student_info[:linkedin] = link
      elsif link.include?("github")
        student_info[:github] = link
      else
        student_info[:blog] = link
      end
    end
    student_info[:profile_quote] = profile_doc.css(".profile-quote").text
    student_info[:bio] = profile_doc.css(".description-holder p").text
    student_info
  end

end
