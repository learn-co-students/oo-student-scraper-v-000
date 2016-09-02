require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :name , :location , :profile_url

  def self.scrape_index_page(index_url) #= "/fixtures/student-site/index.html")
    #html = File.read(index_url)
    #doc = Nokogiri::HTML(html)

    doc = Nokogiri::HTML(open(index_url))

    students = {}

    doc.css(".student-card").each do |student|
      students = [
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attr("href").value
        ]
      end
    #responsible for scraping the index page that lists all of the students

    #This is a class method that should take in an argument of the URL of the index page. It should use nokogiri and Open-URI to access that page. The return value of this method should be an array of hashes in which each hash represents a single student. The keys of the individual student hashes should be `:name`, `:location` and `:profile_url`.
    students
    binding.pry
  end

  def self.scrape_profile_page(profile_url)
    #is responsible for scraping an individual student's profile page to get further information about that student.

    #This is a class method that should take in an argument of a student's profile URL. It should use nokogiri and Open-URI to access that page. The return value of this method should be a hash in which the key/value pairs describe an individual student. Some students don't have a twitter or some other social link. Be sure to be able to handle that (mass assignment!). Here is what the hash should look like: #example#

    #The only attributes you need to scrape from a student's profile page are the ones listed above: twitter url, linkedin url, github url, blog url, profile quote, and bio. The hash you build using those attributes should be formatted like the one in the example above.

  end

end
