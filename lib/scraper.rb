require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    students = []
    Nokogiri::HTML(open(index_url)).css(".student-card").each{|s| students << {:name => s.css("h4.student-name").text, :location => s.css("p.student-location").text, :profile_url => s.css("a").attribute("href").text.prepend("./fixtures/student-site/")}}
    students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    page = Nokogiri::HTML(open(profile_url))
    page.css(".social-icon-container a").each do |s|
      if s.attribute("href").text.include?("twitter") then student[:twitter] = s.attribute("href").text
      elsif s.attribute("href").text.include?("linkedin") then student[:linkedin] = s.attribute("href").text
      elsif s.attribute("href").text.include?("github") then student[:github] = s.attribute("href").text
      else student[:blog] = s.attribute("href").text
      end
    end
    student[:profile_quote] = page.css(".profile-quote").text
    student[:bio] = page.css("p").text
    student
  end
end

# twitter url, linkedin url, github url, blog url, profile quote, and bio