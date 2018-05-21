require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url = "http://165.227.16.205:49280/fixtures/student-site/")
    # html = open(index_url)
     html = File.read('fixtures/student-site/index.html')
     doc = Nokogiri::HTML(html)
     binding.pry
     doc.css("").each do |student|
     end
  end

  def self.scrape_profile_page(profile_url)

  end

end
