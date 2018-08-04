require 'open-uri'
require 'nokogiri'
require 'pry'
def data_scraper(url)
    Nokogiri::HTML(open(url))
end