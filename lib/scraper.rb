require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url
  def self.get_page
    Nokogiri::HTML(open("./fixtures/student-site/index.html"))
  end
  
  def self.scrape_index_page(index_url)
    doc = self.get_page
    array = []
    students = {}
  doc.css(".student-card").each do |student|
    hash_student = {
      :name => student.css("h4").text,
      :location => student.css("p").text,
      :profile_url => student.css("a").attribute("href").value
    }
      array.push(hash_student)
  end
  array
end
  def self.scrape_profile_page(profile_url)
    
  end

end

