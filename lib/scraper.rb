require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :name , :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

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

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    attributes_hash = {}
    
    attributes_hash = {}.tap do |hash|
      hash[:twitter] = doc.css("[href*=twitter]").attr("href").value unless doc.css("[href*=twitter]").empty?
      hash[:linkedin] = doc.css("[href*=linkedin]").attr("href").value unless :linkedin == "" || nil
      hash[:github] = doc.css("[href*=github]").attr("href").value unless :github == "" || nil
      hash[:blog] = doc.css(".social-icon-container a")[3].attr("href") unless doc.css(".social-icon-container a")[3].nil?
      hash[:profile_quote] = doc.css("div.profile-quote").text unless :profile_quote == "" || nil
      hash[:bio] = doc.css(".description-holder p").text unless :bio == "" || nil
    end

    attributes_hash
  end
end
