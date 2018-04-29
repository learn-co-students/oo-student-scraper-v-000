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
    #binding.pry

    students = {}
  #students = doc.css(".student-card")
  #name = doc.css(".student-card")[0].css("h4").text
  #location = doc.css(".student-card")[0].css("p").text
  #profile_url = .css(".student-card")[0].css("h3").text
  
  doc.css(".student-card").each do |student|
    name = student.css(".student-card").css("h4").text
    students[name.to_sym] = {
      :location => student.css(".student-card").css("p").text,
      :profile_url => student.css(".student-card").css("h3").text
    }
  end
  students
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

