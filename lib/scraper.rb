require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    # binding.pry
    # doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    doc = Nokogiri::HTML(open(index_url))
    # binding.pry
    # student name
    # doc.css(".student-card").first.css(".student-name").text
    # # student location
    # doc.css(".student-card").first.css(".student-location").text
    # # student link
    # doc.css(".student-card").first.css("a").attribute("href").value
    students = []

    doc.css(".student-card").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a").attribute("href").value
      student_hash = {:name => name,
        :location => location,
        :profile_url => profile_url }
      students << student_hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    # binding.pry
    student = {}
    # student[:profile_quote] = doc.css(".profile_quote").text
    # student[:bio] = doc.css("div.description-holder p").text
    social_media = doc.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
    social_media.each do |link|
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
    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css("div.description-holder p").text
    student




  end



end
