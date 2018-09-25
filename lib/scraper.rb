require 'open-uri'
require 'pry'

# doc = Nokogiri::HTML("http://165.227.133.20:40811/fixtures/student-site/")

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    index_url = "http://165.227.133.20:40811/fixtures/student-site/"
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css(".student-card")[0].css("h4.student-name")[0].children[0].text
    # binding.pry
   
    students
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

