require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
    attr_accessor :name, :location, :profile

  def self.scrape_index_page(index_url)
    student_index = doc = Nokogiri::HTML(open(index_url))

    student_index = doc.css(".card-text-container").collect do |student|
        student_info = {}
        student_info[:name]= student.css("h4.student-name").text
        student_info[:location] = student.css("p.student-location").text
        student_info[:profile_url] = student.css("a").text
        student_info
    end
    #binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end
