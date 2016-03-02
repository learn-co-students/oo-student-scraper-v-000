require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  attr_accessor :page_url, :doc, :index
 
  def initialize(page_url)
    @page_url=page_url
  end



  def self.scrape_index_page(index_url)
    scraped_students=[]
    student_hash={}
    @doc= Nokogiri::HTML(open(index_url))
    @doc.css(".student-card").each do |student|
       student_hash = {
      :name => student.css(".student-name").text,
      :location => student.css(".student-location").text,
      :profile_url => student.css("a").attribute("href").value
    }
      scraped_students<<student_hash
    end
    scraped_students
  end

    
  

  def self.scrape_profile_page(profile_url)
    
  end

end
#Scraper.scrape_index_page(../fixtures/student-site/index.html)

# student: @doc.css(".student-card")
# name: @doc.css
# location: @doc.css(".student-location").first.text
# links: links= @doc.css(".student-card a")
# links: links[0]["href"]
