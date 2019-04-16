require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
   stud=[]
   index = Nokogiri::HTML(open(index_url))
   students = index.css(".roster-cards-container .student-card")
    students.collect do |student|
    stud << {:name => student.css("h4").text, :location => student.css(".student-location").text, :profile_url =>   student.css("a").attribute("href").text}
    end
    stud
  end

  def self.scrape_profile_page(profile_url)
   prof= [] 
  index = Nokogiri::HTML(open(profile_url))
  profile = index.css(".profile")
  index.css(".social-icon-container a").each do |p|
  end
  prof[:twitter] = p.attribute(href)
end

end

