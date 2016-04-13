require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    students = []
    index.css(".student-card").each do |student|
      index_info = {}
      index_info[:name] = student.css(".student-name").text
      index_info[:location] = student.css(".student-location").text

      student_site = student.css("a").attr("href").text

      index_info[:profile_url] = "http://127.0.0.1:4000/#{student_site}"
      students << index_info
      end
    students
  end
  

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    students = {}
    profile.css('.social-icon-container a').each do |link|
      links = link['href']

      if links.include?('twitter')
        students[:twitter] = links
      elsif links.include?('linkedin')
        students[:linkedin] = links
      elsif links.include?('github')
        students[:github] = links
      else
        students[:blog] = links
      end
    end

    students[:profile_quote] = profile.css('.profile-quote').text.strip
    students[:bio] = profile.css('.description-holder p').text.strip
    students
    
   end
   

end