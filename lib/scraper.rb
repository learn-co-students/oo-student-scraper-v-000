require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    @array = []

    students = doc.css(".roster-cards-container")

    students.each do |student|

      student.css(".student-name").each do |name|
      @name = name.text
      # hash[:name] = name
      end

      student.css(".student-location").each do |location|
      @location = location.text
      # hash[:location] = location
      end

      student.css(".student-card a").map do |link|
      @link = link['href']
      # hash[:profile_url] = link
      end

      hash = { :name => @name, :location => @location, :profile_url => @link }
      binding.pry
       array << hash
      #  binding.pry
      end
       array
      # binding.pry
    end


  def self.scrape_profile_page(profile_url)

  end

end
