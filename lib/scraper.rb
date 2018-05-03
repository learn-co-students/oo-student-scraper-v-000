
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div .roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        students << {:name => "#{student.css(".student-name").text}", :location => "#{student.css(".student-location").text}", :profile_url => "#{student.attr("href")}"}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    new_doc = doc.css(".social-icon-container a")
    links = []
      new_doc.each do |link|
          links << link.attr("href")
      end
      links.each do |link|
        if link.include?("twitter")
          student[:twitter] = link
        elsif link.include?('linkedin')
          student[:linkedin] = link
        elsif link.include?('github')
          student[:github] = link
        else
          student[:blog] = link
        end
      end
        student[:profile_quote] = doc.css("div .profile-quote").text
        student[:bio] = doc.css(".bio-content p").text
        student
      end

end
