require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    my_hash = doc.css('.student-card').collect do |student|
      {:name => student.css('h4').text, :location => student.css('p').text, :profile_url => student.css('a')[0]['href']}
    end
    #student name? = doc.css('.student-card').first.css('h4').text TRUE
    #student location? = doc.css('.student-card').first.css TRUE
    #student profile_url?  = doc.css('.student-card').first.css('a')[0]['href'] TRUE



  end

  def self.scrape_profile_page(profile_url)

  end

end
