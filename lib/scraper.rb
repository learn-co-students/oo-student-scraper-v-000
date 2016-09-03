require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :name , :location , :profile_url, :twitter, :linkedin, :github, :blog, :profile_quote, :bio

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))

    students = []

    doc.css(".student-card").each do |student|
      students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => "./fixtures/student-site/#{student.css("a").attr("href").value}"
        }
      end
    #responsible for scraping the index page that lists all of the students

    #This is a class method that should take in an argument of the URL of the index page. It should use nokogiri and Open-URI to access that page. The return value of this method should be an array of hashes in which each hash represents a single student. The keys of the individual student hashes should be `:name`, `:location` and `:profile_url`.
    students
  end

  def attribute(attribute)
    attribute.each {|key, value| self.send(("#{key}="), value)}
    attribute
  end

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))

    attributes_hash = {:twitter => nil, :linkedin => nil, :github => nil, :blog => nil, :profile_quote => nil, :bio => nil}

    doc.css("body").each do |profile|
      attributes_hash = {
        :twitter => profile.css("[href*=twitter]").attr("href").value,
        :linkedin => profile.css("[href*=linkedin]").attr("href").value,
        :github => profile.css("[href*=github]").attr("href").value,
        :blog => profile.css(".social-icon-container a")[3].attr("href"),
        :profile_quote => profile.css("div.profile-quote").text,
        :bio => profile.css(".description-holder p").text
      }
      end
    #attribute(student)
    attributes_hash
  end
end
