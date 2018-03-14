require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = []
    doc.css(".student-card").each do |page|
      # :name = student.css(".student-name").text
      # :location = student.css(".student-location").text
      # :url = './fixtures/student-site/' + student.css("a").attribute("href").value
      student = {}
      # binding.pry
      student[:name] = page.css(".student-name").text
      student[:profile_url] = page.css("a").attribute("href").value
      student[:location] = page.css(".student-location").text

      students << student
    end
    students
  end


  def self.scrape_profile_page(profile_url)
    shtml = open(profile_url)
    sdoc = Nokogiri::HTML(shtml)
    # binding.pry
    profile = {}
    sdoc.css(".social-icon-container a").each do |link|
      # binding.pry
      profile[:twitter] =  link.attribute("href").value if link.attribute("href").value.include? ("twitter")
      profile[:linkedin] =  link.attribute("href").value if link.attribute("href").value.include? ("linkedin")
      profile[:github] =  link.attribute("href").value if link.attribute("href").value.include? ("github")
      profile[:blog] =  link.attribute("href").value if link.css("img").attribute("src").value.include? ("rss-icon")
    end

    profile [:profile_quote] = sdoc.css(".profile-quote").text
    profile [:bio] = sdoc.css(".description-holder p").text
    profile
  end
end
