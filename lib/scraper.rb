require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    learn = Nokogiri::HTML(html)

      scraper_array = []
      hash = {}

    learn.css(".student-card").map do |elements|

       hash[:name] = elements.css(".student-name").text
       hash[:location] = elements.css(".student-location").text
       hash[:profile_url] = "./fixtures/student-site/" + elements.css('a[href]').map{|link| link['href']}.join

     scraper_array << hash
      scraper_array
    #  binding.pry
    end
 end


      # names = learn.css('a[href]').map{|link| link['href']}
      #   names.map do |each_url|
      #     url = {:profile_url = "./fixtures/student-site/" + each_url}
      #   end
      #
      #     scraper_array << scraper


  def self.scrape_profile_page(profile_url)
    html_file = File.read(profile_url)
    doc = Nokogiri::HTML(html_file)


  end

end

Scraper.scrape_index_page("./fixtures/student-site/index.html")
Scraper.scrape_profile_page("./fixtures/student-site/students/joe-burgess.html")
