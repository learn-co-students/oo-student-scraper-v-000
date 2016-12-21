require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    learn = Nokogiri::HTML(html)


      scraper_array = []
      scraper = {}

      learn.css(".student-name").map do |each_name|
        name = scraper[:name] = each_name.text
      end

      learn.css(".student-location").map do |each_location|
        location = scraper[:location] = each_location.text
      end

      names = learn.css('a[href]').map{|link| link['href']}
        names.map do |each_url|
          url = scraper[:profile_url] = "./fixtures/student-site/" + each_url
        end

          scraper_array << scraper
          # binding.pry
  end


  def self.scrape_profile_page(profile_url)
    html_file = File.read(profile_url)
    doc = Nokogiri::HTML(html_file)



 # binding.pry
  end

end

Scraper.scrape_index_page("./fixtures/student-site/index.html")
Scraper.scrape_profile_page("./fixtures/student-site/students/joe-burgess.html")
