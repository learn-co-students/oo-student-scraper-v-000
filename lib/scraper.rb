require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html=File.read('./fixtures/student-site/index.html')
    index = Nokogiri::HTML(html)
    students = []
    index.css("div.card-text-container").each do |student|
      #binding.pry
      name = student.css("h4.student-name").text
      students[name.to_s] = {
        :name => name,
        :location => student.css("p.student-location").text
      }
      binding.pry
    end
  end

  def self.scrape_profile_page(profile_url)

  end

end
