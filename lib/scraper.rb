require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    hash_ary = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".roster-cards-container .student-card")
    students.each do |student|
      hash = {:name => student.css(".card-text-container h4").text, :location => student.css(".card-text-container p").text, :profile_url => student.css("div.student-card a").text}
      hash_ary << hash
    end
    hash_ary
    #binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end
