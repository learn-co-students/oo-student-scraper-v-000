require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
binding.pry 
    #html_index = open("http://159.203.84.37:30004/fixtures/student-site/")
    #not convinced this is necessary.
    #doc = Nokogiri::HTML(open(index_url))
    #doc.css('div, class or id')
    #we can use .text to extract text from div, class or id

    #array = [{:name => "doc.search('css.selector_name')", :location => "doc.search('css.selector_name')", :profile_url => "doc.search('css.selector_name')"}]

  end

  def self.scrape_profile_page(profile_url)

  end

end
