require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
     html = open(index_url)
     index = Nokogiri::HTML(html)
     stud=[]
     index.css(".student-card a").each do |student| 
       student_hash = {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.attribute("href").value}
        stud << student_hash
    end
    stud
  end

  def self.scrape_profile_page(profile_url)
   prof= [] 
  index = Nokogiri::HTML(open(profile_url))
  profile = index.css(".profile")
  index.css(".social-icon-container a").each do |p|
  end

end

end

