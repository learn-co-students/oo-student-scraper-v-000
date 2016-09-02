require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc =Nokogiri::HTML(open(index_url))
   

    doc.css(".student-card").each do |student| 
      hash = {
      :name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text, 
      :profile_url => student.css("a").attribute("href").text.prepend("./fixtures/student-site/")}
      students << hash
    end
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
    student[:bio] = page.css('.description-holder p').text
    student
    end

end

