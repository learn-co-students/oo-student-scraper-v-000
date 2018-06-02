# require 'Nokogiri'
require 'open-uri'
require 'pry'

class Scraper #responsible for scraping the data from a webpage

  def self.scrape_index_page(index_url)
    #index_url = "../fixtures/student-site/index.html"
    html = open(index_url)
    list = Nokogiri::HTML(html)

    # student names
    names = list.css(".student-name")
    names_array = []
    names.each do |n|
      names_array << n.text
    end

    # student locations
    locations = list.css(".student-location")
    location_array = []
    locations.each do |l|
      location_array << l.text
    end

    # student pages
    websites = list.css(".student-card a[href]")
    website_array = []
    websites.select do |w|
      website_array << w["href"]
    end

    # the complete array
    student_array = []

    x = 0
    names_array.each do |name|
      student_array << {
        :name => name,
        :location => location_array[x],
        :profile_url => website_array[x]
      }
      x = x + 1
    end
    student_array

  end


  def self.scrape_profile_page(profile_url)

  end

end
