require 'open-uri'
require 'nokogiri'
require 'pry'
require_relative './student.rb'

class Scraper

  attr_accessor :name, :location, :profile_url, :doc

  def initialize
    @name = name
    @location = location
    @profile_url = profile_url
    @doc =
    Nokogiri::HTML(open("http://138.68.63.182:30016/fixtures/student-site/"))
  end

  #scraped_students = Scraper.scrape_index_page(index_url)
  #expect(scraped_students).to be_a(Array)
  #expect(scraped_students.first).to have_key(:location)
  #expect(scraped_students.first).to have_key(:name)
  #expect(scraped_students).to include(student_index_array[0], student_index_array[1], student_index_array[2])

  def self.scrape_index_page(index_url)
    @index_url
    doc =
    Nokogiri::HTML(open("http://138.68.63.182:30016/fixtures/student-site/"))
    scraped_students = []
    #binding.pry
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
    end

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
    #doc1 =
    #Nokogiri::HTML(open("http://138.68.63.182:30010/fixtures/student-site/students"))
    #doc1.css(".a_href")
    #binding.pry
  end

#end
