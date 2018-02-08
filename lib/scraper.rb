require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    array_index = []
    doc = Nokogiri::HTML(open(index_url))
    binding.pry
    doc.css(".student-card").each.with_index do |student, i|
      array_index[i][:name] = student.css("student-name").text
      array_index[i][:location] = student.css("student-location").text
      array_index[i][:profile_url] = student.css("a").text
    end
    array_index
  end

  def self.scrape_profile_page(profile_url)

  end

end
