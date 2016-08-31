require 'open-uri'
require 'pry'

# name: doc.css("h4.student-name").text
# location: doc.css("p.student-location").text
# link: doc.css(".student-card")
class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.roster-cards-container").each do |card|
      card.css("div.student-card").each do |student|
        link = "./fixtures/student-site/#{student.css("a").attribute("href").value}"
        name = student.css("h4.student-name").text
        location = student.css("p.student-location").text
        students << {name: name, location: location, profile_url: link}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    student_page = {}
    media = page.css("div.social-icon-container a").map{|attr| attr.attribute("href").value}
    media.each do |link|
      if link.include?("twitter")
        student_page[:twitter] = link
      elsif link.include?("github")
        student_page[:github] = link
      elsif link.include?("linkedin")
        student_page[:linkedin] = link
      elsif link
        student_page[:blog] = link
      end
      student_page[:profile_quote] = page.css("div.profile-quote").text if page.css("div.profile-quote").text
      student_page[:bio] = page.css("div.bio-content.content-holder div.description-holder p").text
    end
    student_page
  end

end
