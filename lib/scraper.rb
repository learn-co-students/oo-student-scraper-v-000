require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    scraped_students = []
     page.css('.student-card').each do |s|
      h = {}
      h[:name] = s.css("h4").text
      h[:location] = s.css("p").text
      h[:profile_url] = "http://127.0.0.1:4000/" + s.css("a").attribute("href").value
      scraped_students << h
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    h = {}
    page.css('.social-icon-container a').each do |s|
      if s.attribute("href").value.include?("twitter")
        h[:twitter] = s.attribute("href").value
      elsif s.attribute("href").value.include?("linkedin")
          h[:linkedin] = s.attribute("href").value
      elsif s.attribute("href").value.include?("github")
          h[:github] = s.attribute("href").value
      else s.attribute("href").value.include?("blog")
          h[:blog] = s.attribute("href").value
      end
    end
    h[:profile_quote] = page.css('.profile-quote').text
    h[:bio] = page.css('.bio-block').css("p").text
    h
  end 

end

