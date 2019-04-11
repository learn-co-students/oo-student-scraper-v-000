require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  #responsible for scraping the index page that lists all of the students

  #This is a class method that should take in an argument of the URL of the index page,
  #for the purposes of our test the URL will be "./fixtures/student-site/index.html".
  #It should use Nokogiri and Open-URI to access that page.
  #The return value of this method should be an array of hashes in which each hash
  #represents a single student. The keys of the individual student hashes should be
  # :name, :location and :profile_url.
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    scraped_students = []
    # Iterate through the students
    index_page.css("div.student-card").each do |student|
      scraped_students.push(name: student.css("h4.student-name").text, location: student.css("p.student-location").text, profile_url: student.css("a").attribute("href").value)
    end
    # return the students
    scraped_students
  end

  #responsible for scraping an individual student's profile page to get further
  #information about that student. The only attributes you need to scrape from a
  #student's profile page are: twitter url, linkedin url, github url, blog url, profile quote, and bio.
  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    scraped_student = {}
    #binding.pry
    profile_page.css("div.main-wrapper.profile").each_with_object({}) do |detail|
      scraped_student[:twitter] = detail.css("a")[1].attribute("href").value,
      scraped_student[:linkedin] = detail.css("a")[2].attribute("href").value,
      scraped_student[:github] = detail.css("a")[3].attribute("href").value,
      scraped_student[:blog] = detail.css("a")[4].attribute("href").value,
      scraped_student[:profile_quote] = detail.css("div.profile-quote").text,
      scraped_student[:bio] = detail.css("div.bio-content.content-holder p").text
    end

    scraped_student
  end

end
