require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open("http://159.89.225.105:56893/fixtures/student-site/")
    doc = Nokogiri::HTML(html)
    binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end


#names doc.css("h4").text
#location doc.css("p").text
