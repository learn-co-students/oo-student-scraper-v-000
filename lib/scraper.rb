require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    scraped_students = []
    section = doc.css(".student-card")
    section.each do |student|
      scraped_students << {name: student.css("h4").text, location: student.css(".student-location").text, profile_url: student.css("a").attribute("href").value}
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    section = doc.css(".vitals-container")

    #  github = section.css.(".social-icon-container").css.("a").attribute("href").value
    # linkedin =
    twitter = section.css("a").attribute("href").value
    # blog =
    # quote =
    # bio =
binding.pry

  end

end
# is a class method that scrapes the student index page ('./fixtures/student-site/index.html')
# and a returns an array of hashes in which each hash represents one student (FAILED - 1)

# expected [{:name => "Ryan Johnson", :location => "New York, NY", :profile_url => "students/ryan-johnson.html"},
