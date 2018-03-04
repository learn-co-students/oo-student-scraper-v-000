require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card a").collect do |student|
      {:name => student.css(".student-name").text, :location => student.css(".student-location").text, :profile_url => "#{student.attr('href')}"}
    end
  end

  def self.scrape_profile_page(profile_url)
    
  end

end