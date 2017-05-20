require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :student_hash

  index_url = "./fixtures/student-site/index.html"
  def initialize(student_hash)

  end


  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))
    student_roster = doc.css("div.student-card")
    scraped_students=Array.new
    student_roster.each do |student_node|
      @student_hash = {name: " ", location: " ", profile_url: " " }
      @student_hash[:name] = student_node.css("h4.student-name").text
      if @student_hash[:name] != " "
        @student_hash[:location] = student_node.css("p.student-location").text
        @student_hash[:profile_url] = student_node.css('a').attribute("href").text
        student=Student.new(@student_hash)
        scraped_students << @student_hash
      end
    end
    scraped_students
  end



  def self.scrape_profile_page(profile_url)
    scraped_students = Hash.new
    doc = Nokogiri::HTML(open(profile_url))
    scraped_students[:profile_quote] = doc.css("div.profile-quote").text
    scraped_students[:bio] = doc.css("div.description-holder p").text
    links = doc.css("div.social-icon-container a")
    links.each do |i|
      scraped_students[:twitter] = i.attribute("href").text if i.attribute("href").text.match(/twitter/)
      scraped_students[:linkedin] = i.attribute("href").text if i.attribute("href").text.match(/linkedin/)
      scraped_students[:github] = i.attribute("href").text if i.attribute("href").text.match(/github/)
      scraped_students[:blog] = i.attribute("href").text if i.attribute("href").text.match(/http:/)
    end
    scraped_students
  end

end
