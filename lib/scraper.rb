require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
html = File.read(index_url)
    learn = Nokogiri::HTML(html)
     binding.pry


  #   students = {}
  #
    #  students[:name] = learn.search(  learn.css(".student-name").first.text  ).text
  # students[:location] = learn.search(  learn.css(".student-location").first.text  ).text
  # students[:profile_url] = learn.search().text

  end



  def self.scrape_profile_page(profile_url)

  end

end

Scraper.scrape_index_page("./fixtures/student-site/index.html")
