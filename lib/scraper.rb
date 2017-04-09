require 'open-uri'
require 'pry'

class Scraper
  @@students = []
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    name = doc.css(".student-name").text
    name.collect do |name|
      hash[:name] = name
      self.students << hash
    end
  end

  def self.scrape_profile_page(profile_url)
    
  end

  def self.students
    @@students
  end

