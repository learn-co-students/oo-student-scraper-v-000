require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
# The return value of this method should be an array of hashes
# in which each hash represents a single student.
# The keys of the individual student hashes should be
# :name, :location and :profile_url.
    students_array = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.student-card").each do |c|
      name = c.css("h4.student-name").text
      location = c.css("div.student-card p.student-location").text
      profile_url =
    end
    :name => doc.css("div.student-card h4.student-name").text
    :location => doc.css("div.student-card p.student-location").text
    :profile_url => doc.css("").text
  end

  def self.scrape_profile_page(profile_url)

  end

end
