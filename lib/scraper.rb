require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper


#binding.pry
#scrape_index_page method is responsible for scraping the index page that lists all of the students
  def self.scrape_index_page(index_url)
    #binding.pry
    html = File.read('./fixtures/student-site/index.html')
    index_page = Nokogiri::HTML(html)
    scraped_students = []
    index_page.css("div.roster-card-container").each do |students|
      scraper = students.css("h4.student-name")
      students[scraper] = {
        :name => students.css('.student-name').text,
        :location => students.css('.student-location').text,
        :profile_url => students.css('a').first['href']
      }
    end
    scraped_students.first.has_key?
  end
    #doc = Nokogiri::HTML(open("http://138.68.63.182:30012/fixtures/student-site/"))
    #binding.pry
    #index_url = [student-name]  #["name", "location", "profile_url"]
    #h = hash[*index_url]
    #hash = {:name =>node.css('students.collect { |node| node.css('.student-name').text }'),
    #:location =>node.css('students.collect { |node| node.css('.student-location').text }'),
    #:profile_url =>node.css('cards.collect{|node| node.css('a').first['href'] }')}
    #hash = {:name => doc.css("setudent-name").text,
    #:location => doc.css(".student-location").text,
    #:profile_url => }
    #scraped_students = hash.collect {|k,v| key }

    #:location = scraped_students.first
    #binding.pry

    #div.roster-card-container => Iterate over to get
      #div.student-card
        #a_href for student profile_url#
          #div.view-profile-div
            #h3.view-profile-text
            #div.card-text-container
              #h4.student-name#
              #p.student-location#

    #names = doc.css(".student-name").text
    #names.each do |name|
    #end
    #binding.pry
    #doc.map do |node|
    #hash = {}

      #hash['link'] = node.css('cards.collect{|node| node.css('a').first['href'] }')
      #hash['name'] = node.css('students.collect { |node| node.css('.student-name').text }')
      #hash['location'] = node.css('students.collect { |node| node.css('.student-location').text }')
      #hash
    #end

  #doc.css(".student-location").text
  #doc.css(".student-card")


#scrape_profile_page method is responsible for scraping an individual student's profile page to get further information about that student.
  def scrape_profile_page(profile_url)
    self.scrape_index_page(index_url).each do |node|
      student = Student.new
      student.name = node.css("h1").text
      student.location = node.css("h2").text
      student.profile_url = node.css("div").text

    end
  end
end
