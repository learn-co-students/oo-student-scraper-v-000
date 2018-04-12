require 'open-uri'
require 'pry'

class Scraper
  
  attr_accessor :name, :location, :page_url
  
 

  def self.scrape_index_page(index_url)
    html = open('./fixtures/student-site/index.html')
    index_page = Nokogiri::HTML(html)
    binding.pry
    
    students = {}
    
    index_page.css('roster-body-wrapper').each do |student|
        :name=> index_page.css('h4').children.text,
        :location => index_page.css('.student-location').children.text,
        :page_url => index_page.css('.student-card a').attribute('href').value
    
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

