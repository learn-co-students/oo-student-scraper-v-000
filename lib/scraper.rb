require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper


#binding.pry
  def self.scrape_index_page(index_url)
    #binding.pry
    doc = Nokogiri::HTML(open("http://138.68.63.182:30019/fixtures/student-site/"))
    #binding.pry
    scraped_students = []
    hash = {:name =>node.css('students.collect { |node| node.css('.student-name').text }'), :location =>node.css('students.collect { |node| node.css('.student-location').text }'), :profile_url =>node.css('cards.collect{|node| node.css('a').first['href'] }')}
    #hash = {:name => doc.css("setudent-name").text, :location => doc.css(".student-location").text, :profile_url => }
    scraped_students = hash.collect {|k,v| key }
    
    #:location = scraped_students.first
    #binding.pry

    #div.roster-card-container => Iterate over to get 
      #div.student-card
        #a_href.HTML for student=profile_url
          
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

  end

  def scrape_profile_page(profile_url)
    self.scrape_index_page(index_url).each do |node|
      student = Student.new
      student.name = node.css("h1").text
      student.location = node.css("h2").text
      student.profile_url = node.css("div").text

    end
  end
end
