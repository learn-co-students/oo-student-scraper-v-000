require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    # return
    # {:name => "name", :location => "location", :profile_url => "students/abby-smith.html"}
    html = File.read(index_url)
    index_page = Nokogiri::HTML(html)
    index_page.css(".student-card").collect do |student|
      return {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attr("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)

  end

end

Scraper.scrape_index_page('./fixtures/student-site/index.html')
