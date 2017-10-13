require 'open-uri'
require 'nokogiri'
require 'pry'

require_relative './student.rb'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end

  def self.scrape_profile_page(profile_url)

  end

    def get_page(url)
       doc = Nokogiri::HTML(open("url"))
     end

     def get_courses
     self.get_page.css(".post")
     # this returns the array
   end

   return array of hashes with
   :name :location, :profile_url

   return :linkedin  :github  :blog  :profile_quote :bio

end
