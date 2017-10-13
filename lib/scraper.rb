require 'open-uri'
require 'nokogiri'
require 'pry'

require_relative './student.rb'

class Scraper

  def self.scrape_index_page(index_url)
    get_page
    get_students
  end

  def self.scrape_profile_page(profile_url)
    get_page
    
  end

  def get_page(url)
     doc = Nokogiri::HTML(open("url"))
  end

  def get_students
    self.get_page.css(".post")
     # this returns the array
  end
   #
  #  return array of hashes with
  #  :name :location, :profile_url
   #
  #  return :linkedin  :github  :blog  :profile_quote :bio

    # doc = Nokogiri::HTML(open("index_url"))

end
