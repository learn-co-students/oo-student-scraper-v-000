require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  # name:
  # location:
  # profile_url:

  def self.scrape_index_page(index_url)
    binding.pry
    doc = Nokogiri::HTML(open(index_url))

    doc.css(".student-card").each do|student|
      {:name => student.css("h4").text, :location => student.css("p"), :profile_url => student.css("a href")}
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
