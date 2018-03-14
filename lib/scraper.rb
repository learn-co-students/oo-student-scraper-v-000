require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    doc = File.read(index_url)
    index_page = Nokogiri::HTML(doc)
    index_page.css(".student-card").each do |student|
      scraped_student = {}
      scraped_student[:name] = student.css("h4").text
      scraped_student[:location] = student.css("p").text
      scraped_student[:profile_url] = './fixtures/student-site/' + student.css("a").attribute("href")
      scraped_students << scraped_student
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    doc = File.read(profile_url)
    profile_page = Nokogiri::HTML(doc)
    profile_page.css(".social-icon-container a").each do |social|
      link = social.attribute("href").value
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
    student[:profile_quote] = profile_page.css("div.profile-quote").text
    student[:bio] = profile_page.css("div.description-holder p").text
    student
  end

end
